#!/bin/bash

sed 's/#{node['ssh-port']}/#{node['new-ssh-port']}/g' /etc/ssh/sshd_config
#sed 's/22/33500/g'/etc/ssh/sshd_config
#service ssh restart
