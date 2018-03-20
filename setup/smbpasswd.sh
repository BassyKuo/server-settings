#!/bin/bash
users=$(cut -d: -f1,3 /etc/passwd | egrep ':[0-9]{4}$' --color=no | cut -d: -f1)
passwd=elsalab
prompt=$(echo -e "Do you want to add: \n\n$users\n\n to be SAMBA users? [Y/n] ")
read -p "$prompt" ans
if [[ $ans =~ ^[yY]*$ ]]; then
	echo -e "$passwd\n$passwd" > smbpassword

	for u in $users; do 
		sudo smbpasswd -a $u -s < smbpassword
	done
	rm smbpassword

	echo "Successfully."
	echo "Default SAMBA password: $passwd"
	echo "Change your password using \`smbpasswd\`."
fi
