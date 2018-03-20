#!/bin/bash

port=${1:-22}
sshd_config=/etc/ssh/sshd_config

echo "Modify $sshd_config"
sudo cp -p rc/sshd_config $sshd_config
sudo chmod 755 /etc/ssh/sshd_config
sudo chown root /etc/ssh/sshd_config
sudo chgrp root /etc/ssh/sshd_config

sudo sed -i "s/^Port\s[0-9]\+/Port $port/g" $sshd_config

echo "Modify sshd port: $port"
sudo yum install -y policycoreutils-python	# install `semanage`
sudo semanage port -a -t ssh_port_t -p tcp $port

echo "Firewall setting ..."
sudo firewall-cmd --permanent --zone=public --add-port=${port}/tcp
sudo firewall-cmd --reload

sudo service sshd restart
sudo systemctl enable sshd.service
systemctl status sshd
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys

echo "Done!"
