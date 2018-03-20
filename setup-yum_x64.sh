#!/bin/bash

#----------------------------------------------------------------
###             FOR ROOT ADMINISTRATOR EXECUTING              ###
#----------------------------------------------------------------
# YUM Install:
#	vim git numpy scipy gcc gcc-c++ blas blas-devel atlas-devel 
#	openssh* git-email wget fail2ban xauth tkinter dbus-x11 octave
#	nmap nfs-utils sendmail samba samba-client samba-common
#	epel-release 
#	python-pip cmake openblas-devel
#	screen autoconf automake libtool curl make unzip
#
# Pip install:
#	virtualenv numpy scipy nose opencv-python lmdb
#
# General Setting:
#	selected_editor="/usr/bin/vim.basic" > /root/.selected_editor
#
# Setting:
#	git config
#	crontab
#	vim-plugins-setup
#	sshd-setup
#	fail2ban
#	NFS
#	Samba
#
# Add File:
#	.bashrc
#	.vimrc
#	.ssh/config
#	; git-repository		[root]
#	; git-members			[root]
#
### Written by Bassy<aaammmyyy27@gmail.com> 2017/4/30 v3.5.3

# Insatll
echo "Install Package ...."
read -p "> sudo apt-get update [need root]: [Y/n] " ans_install
if [[ $ans_install =~ ^[yY]*$ ]]; then
	if [ $USER = root ]; then
		sudo yum update -y
		sudo yum install -y epel-release
		sudo yum install -y vim git numpy scipy gcc gcc-c++ blas blas-devel atlas-devel openssh* git-email wget fail2ban xauth tkinter dbus-x11 octave sendmail
		sudo yum install -y nmap	# listen port (like `netstat`, `lsof`)
		sudo yum install -y python-pip cmake openblas-devel
		sudo yum install -y screen
		sudo yum install -y autoconf automake libtool curl make unzip
	fi
fi
echo

# Pip install
read -p "> pip install --user --upgrade pip virtualenv numpy scipy nose lmdb opencv-python: [Y/n] " ans_pip
if [[ $ans_pip =~ ^[yY]*$ ]]; then
	sudo pip install --upgrade pip
	sudo pip install --upgrade virtualenv
	sudo pip install --upgrade numpy scipy nose lmdb opencv-python
fi
echo

# `select-editor`
read -p "Setting editor = vim? [Y/n] " ans_edit
if [[ $ans_edit =~ ^[yY]*$ ]]; then
	echo -e "\
	# Generated by /usr/bin/select-editor \n\
	SELECTED_EDITOR=\"/usr/bin/vim.basic\"" > /root/.selected_editor
fi
echo

# Git Config Setting
read -p "Setting Git Global Configures [add in ~/.gitconfig]: [Y/n] " ans
if [[ $ans =~ ^[yY]*$ ]]; then
	git config --global core.editor vim
	git config --global merge.tool vimdiff
	git config --global color.status auto
	git config --global color.branch auto
	git config --global color.interactive auto
	git config --global color.diff auto
	git config --global color.ui true
	if test -e setup/git_config-setup.sh; then
		read -p "Please enter your github email: " git_email
		read -p "Please enter your github name: " git_name
		bash setup/git_config-setup.sh $git_email $git_name
	fi
	echo "[config list]"
	git config --global --list
	echo
	echo "Set git configures completely."
fi
echo

# Crontab setting
read -p "Setting Crontab to backup $HOME every day: [y/N] " ans_cron
if [[ $ans_cron =~ ^[yY]+$ ]]; then
	#cronday=( fname1 fname2 fname3 )
	#cronweek=( fname1 fname2 fname3 )
	#for FILE in ${cronday[*]}; do
		#cp -p doc/cron/daily/$FILE /etc/cron.daily/$FILE && chmod 755 $FILE
	#done
	#for FILE in ${cronweek[*]}; do
		#cp -p doc/cron/week/$FILE /etc/cron.weekly/$FILE && chmod 755 $FILE
	#done

		   #m h dom mon dow user	command
	cp rc/crontab $HOME/.crontab
	sed -i "s/\$USER/${USER}/g" $HOME/.crontab
	crontab $HOME/.crontab

	#sudo service cron restart
	echo "Crontable set completely."
fi
echo

# Add File
echo "Add Files..."
read -p "cp rc/.bashrc ~/.bashrc   [Y/n] "				ans_1
read -p "cp rc/.bash_profile ~/.bash_profile   [Y/n] "	ans_2
read -p "cp rc/.vimrc ~/.vimrc     [Y/n] "				ans_3
[[ $ans_1 =~ ^[yY]*$ ]] && cp --backup=t -p rc/.bashrc			$HOME/.bashrc
[[ $ans_2 =~ ^[yY]*$ ]] && cp --backup=t -p rc/.bash_profile	$HOME/.bash_profile
[[ $ans_3 =~ ^[yY]*$ ]] && cp --backup=t -p rc/.vimrc			$HOME/.vimrc
echo

# Vim Plugins setting
read -p "Add vim plugin? [Y/n] " ans_vim
if [[ $ans_vim =~ ^[yY]*$ ]]; then
	test -e setup/vim-plugins-setup.sh && bash setup/vim-plugins-setup.sh
	echo
	echo "Set vim-plugins completely."
fi
echo

# SSHd setting [root]
read -p "Modify sshd setting [need root]? [y/N] " ans_sshd
if [[ $ans_sshd =~ ^[yY]+$ ]]; then
	read -p "Enter the port number for this server: [22] " pt
	! [[ $pt =~ ^[0-9]{1,5}$ ]] && pt=22
	test -e setup/sshd-setup.sh && bash setup/sshd-setup.sh $pt
	echo
	echo "Set sshd completely."
fi
echo

# Add ssh/config
read -p "Add ELSA,ANNA,BELLE server in ~/.ssh/config [y] or copy the whole rc/.ssh/config [a]?	[Y/a/n] "	ans_4
if [[ $ans_4 =~ ^[yY]*$ ]] ; then
	mkdir -p $HOME/.ssh/
	read -p "Enter ELSA host alias: "	$elsa_as
	read -p "Enter your ELSA id: "	$elsa_name
	read -p "Enter ANNA host alias: "	$anna_as
	read -p "Enter your ANNA id: "	$anna_name
	read -p "Enter BELLE host alias: "	$belle_as
	read -p "Enter your BELLE id: "	$belle_name
	echo -e "Host $elsa_as\tHostName 140.114.75.138\tUser $elsa_name"	>> $HOME/.ssh/config
	echo -e "Host $anna_as\tHostName 140.114.75.60\tUser $anna_name"	>> $HOME/.ssh/config
	echo -e "Host $belle_as\tHostName 140.114.75.33\tUser $belle_name"	>> $HOME/.ssh/config
elif [[ $ans_4 =~ ^[aA]*$ ]]; then
	mkdir -p $HOME/.ssh/
	rsync -a rc/.ssh/config	$HOME/.ssh/config
fi
echo
read -p "Connect ELSA,ANNA,BELLE without password? [Y/n] " ans_autossh
if [[ $ans_autossh =~ ^[yY]*$ ]] ; then
	elsa_as=${elsa_as:-"140.114.75.138"}
	anna_as=${elsa_as:-"140.114.89.60"}
	belle_as=${elsa_as:-"140.114.75.33"}
	ssh-keygen
	ssh-copy-id $elsa_as
	ssh-copy-id $anna_as
	ssh-copy-id $belle_as
	chmod 700 $HOME/.ssh
	chmod 600 ~/.ssh/id_rsa
	echo
	echo "Set ssh config completely."
fi
echo

# Add File: git-repository, git-members
#echo "Install git-repository"
#cp -p bin/git-repository /usr/bin/git-repository # create/url/list
#chmod 755 /usr/bin/git-repository
#echo "Install git-members"
#cp -p bin/git-members /usr/bin/git-members # add/remove/list
#chmod 755 /usr/bin/git-members

# Fail2ban setting [root]
# (from: https://www.linode.com/docs/security/using-fail2ban-for-security)
read -p "Setup Fail2ban [nead root]? [Y/n] " ans_f2b
if [[ $ans_f2b =~ ^[yY]*$ ]]; then
	read -p "Enter your email to receive fail2ban message: " email
	sudo systemctl start fail2ban
	sudo systemctl enable fail2ban
	sudo systemctl start sendmail
	sudo systemctl enable sendmail
	sudo mkdir -p /var/run/fail2ban
	if ! [[ $email = "" ]]; then
		sudo sed -i "s/\(bantime  = \)600$/\136000/g" /etc/fail2ban/jail.conf
		sudo sed -i "s/\(destemail \+= \).*$/\1$email/g" /etc/fail2ban/jail.conf
		sudo sed -i "s/\(sender \+= \).*$/\1sendmail -t $email/g" /etc/fail2ban/jail.conf
	fi
	echo "Fail2ban set completely."
fi
echo

# Samba settings [root]
read -p "Setup Samba [need root]? [Y/n] " ans_smb
if [[ $ans_smb =~ ^[yY]*$ ]]; then
	sudo yum update -y ; sudo yum upgrade -y
	sudo yum install -y samba samba-client samba-common
	sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.sample
	sudo cp rc/smb.conf /etc/samba/smb.conf
	sudo ulimit -n 16384
	sudo systemctl enable smb nmb
	sudo systemctl restart smb nmb
	sudo firewall-cmd --permanent --zone=public --add-service=samba
	sudo firewall-cmd –-reload
	echo
	read -p "Enter the smbuser you want to add: " smbuser
	smbpassword='imsmbpasswd'
	echo -e "$smbpassword\n$smbpassword" > smbp
	sudo smbpasswd -a $smbuser -s < smbp
	rm smbp
	echo
	echo "Samba set completely. [Default samba password: $smbpassword]"
	echo -e "Using:\n\t$ smbpasswd\n to change your samba password."
fi
echo

# NFS settings [root]
read -p "Setup NFS [need root]? [Y/n] " ans_nfs
if [[ $ans_nfs =~ ^[yY]*$ ]]; then
	ip="140.114.89.64"
	nfs_folder="/var/nfsshare"
	read -p "Enter your nfs server ip [default: $ip]: " ans_ip
	read -p "Enter your nfs folder position [default: $nfs_folder]" ans_nfsfolder
	ip=${ans_ip:-$ip}
	nfs_folder=${ans_nfsfolder:-$nfs_folder}
	sudo yum install -y nfs-utils
	sudo mkdir $nfs_folder
	sudo chmod -R 777 $nfs_folder
	sudo chmod 666 /etc/exports
	client_ip=$ip
	while [[ $client_ip =~ ^[0-9]{,3}\.[0-9]{,3}\.[0-9]{,3}\.[0-9]{,3}$ ]]; do
		read -p "Enter your nfs client ip (xxx.xxx.xxx.xxx): [empty to exit] " client_ip
		if ! [[ $client_ip =~ ^$ ]]; then
			sudo echo "$nfs_folder $client_ip(rw,sync,no_root_squash,no_all_squash)" >> /etc/exports
		fi
	done
	sudo chmod 644 /etc/exports
	sudo systemctl enable rpcbind nfs-server nfs-lock nfs-idmap
	sudo systemctl restart rpcbind nfs-server nfs-lock nfs-idmap
	sudo firewall-cmd --permanent --zone=public --add-service=nfs
	sudo firewall-cmd –-reload
	echo
	echo "Set NFS completely."
	echo "Use \`sudo mount.nfs $ip:$nfs_folder <client_dir>\` to mount NFS folder to your client directory."
fi
echo

# Install Anaconda
read -p "Install Anaconda? [Y/n] " ans_conda
if [[ $ans_conda =~ ^[yY]*$ ]]; then
	wget https://repo.continuum.io/archive/Anaconda3-4.3.1-Linux-x86_64.sh
	bash Anaconda3-4.3.1-Linux-x86_64.sh
	rm Anaconda3-4.3.1-Linux-x86_64.sh
	conda update conda
	echo
	echo "Use the command to setup your environment:"
	echo "   $ conda create -n <yourenvname> python=<x.x> anaconda"
	echo "Or you can find more usage over here: https://uoa-eresearch.github.io/eresearch-cookbook/recipe/2014/11/20/conda/"
fi
echo

# Done
echo "Done!"
