#
# Cookbook:: apache
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved

# Install & enable Apache
package "apache2" do
  action :install
end

service "apache2" do
  action [:enable, :start]
  supports :reload => true
end

# Virtual Hosts Files
node["apache"]["sites"].each do |sitename, data|
  document_root = "/var/www/html/#{sitename}"
  
  directory document_root do
    mode "0755"
    recursive true
  end

  execute "enable-sites" do
    command "a2ensite #{sitename}"
    action :nothing
  end

  template "/etc/apache2/sites-available/#{sitename}.conf" do
    source "virtualhosts.erb"
    mode "0644"
    variables(
      :document_root => document_root,
      :port => data["port"],
      :serveradmin => data["serveradmin"],
      :servername => data["servername"]
    )
    notifies :run, "execute[enable-sites]"
    notifies :restart, "service[apache2]"
  end

  directory "/var/www/html/#{sitename}/public_html" do
    action :create
  end

  directory "/var/www/html/#{sitename}/logs" do
    action :create
  end

  file "/var/www/html/#{sitename}/public_html/index.html" do
    content "<!doctype html><html lang=\"en\"><head><meta charset=\"UTF-8\"><title>17CLD - Development Environment</title><style type=\"text/css\">body{background: white; padding: 100px; color: #8dcb8d;}h1{text-shadow: 0 1px 0 white;}.list-item-1{font-size: larger; font-weight: bolder; font-family: serif; margin: 0; padding: 0; list-style: none;}.list-item-1 li{color: #808080; margin: 5px 0 5px 10px; text-shadow: 0 1px 0 white;}.list-item-1 li:before{content: \'\\25ca\'; display: inline-block; color: white; padding: 2px; border-radius: .5px; float: left; clear: left; text-shadow: -1px -1px 0 #808080; margin-left: -10px; padding: 2px 10px 0 0;}</style></head><body> <h1>#{data["environment"]} Environment</h1><ul class=\"list-item-1\"> <li>Bruno Toledo Barros - RM 331281</li><li>Gustavo Amorim Cunha - RM 330313</li><li>Daniel Tristao - RM 331520</li><li>Diogo Poli - RM 331323</li><li>Vinicius Paiva - RM 330750</li></ul></body></html>"
  end
end
