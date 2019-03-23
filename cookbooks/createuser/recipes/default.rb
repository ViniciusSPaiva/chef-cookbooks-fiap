#
# Cookbook:: createuser
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.
#Cria o usuário CTO
user 'cto' do
  comment 'CTO user'
  home '/home/cto'
  shell '/bin/bash'
  password '$1$0.B6lnoZ$RLJ/Cma7MN/CKtcYaovJx/'
  action :create
end

#Cria o diretório /home/cto
directory '/home/cto' do
  owner 'cto'
  group 'cto'
  mode '0755'
  action :create
end

#Adiciona novo usuário no grupo SUDO
execute 'sudocto' do
  command 'usermod -aG sudo cto'
end
