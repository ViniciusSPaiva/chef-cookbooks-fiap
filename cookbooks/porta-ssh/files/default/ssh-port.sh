#!/bin/bash

sed 's/22/33500/g' /etc/ssh/sshd_config
service ssh restart
