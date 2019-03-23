#
# Cookbook:: porta-ssh
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

#node.force_override['ssh-port'] = '22'
#node.force_override['new-ssh-port'] = '44500'



cookbook_file "/tmp/ssh-port.sh" do
  source "ssh-port.sh"
  mode 0755
end

execute "Alterar porta SSH" do
  command "sh /tmp/ssh-port.sh"
end

