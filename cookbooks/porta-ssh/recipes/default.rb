#
# Cookbook:: porta-ssh
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

node.force_override['ssh-port'] = '45500'
node.force_override['new-ssh-port'] = '45000'


execute "Alterar porta SSH" do
  command "sed -i 's/#{node['ssh-port']}/#{node['new-ssh-port']}/g' /etc/ssh/sshd_config && service ssh restart"
  action :run
end
