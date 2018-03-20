#!/bin/bash

# [Usage]
#	$ sudo bash addusers.sh USER1 USER2 USER3
#
# [Default Password]
#	elsalab

test $USER = "root" || exit 0
test $# -ne 0 || exit 0

users=$@
password=elsalab
touch users.passwd
for u in ${users[*]}; do
	sudo useradd -d /home/$u -s /bin/bash -m $u
	sudo chmod 700 /home/$u
	echo "${u}:${password}" >> users.passwd
done
sudo chpasswd -c SHA512 < users.passwd
rm -f users.passwd
