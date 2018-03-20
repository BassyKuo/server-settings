#!/bin/bash
clear
echo "================== Git-Server Setup =================="
## Git Config Setting
git config --system core.editor vim
git config --system merge.tool vimdiff
git config --system color.status auto
git config --system color.branch auto
git config --system color.interactive auto
git config --system color.diff auto
## Remember Password
#git config --system credential.helper cache #keep passwd 900sec
#git config --system credential.helper 'cache --timeout 1600' #1hr
#git config --system credential.helper store #store in file
## NOTICE!! use 'store' will write password as plain-code in .git-credentials

## Create 'git' group
test `getent group git` || groupadd git
#if [ `getent group git` ]; then :
#	# return 0 (group exists)
#else
#	# return 1 (group not exist)
#	groupadd git
#fi

## Create /var/git/
if [ -d "/var/git" ]; then :
else
	mkdir /var/git
	chgrp git /var/git
	chmod g+rwx /var/git
fi

path=/var/git
hostname="[hostname]"
account="[gituser]"
repo="[repository]"
url="ssh://[gituser]@[hostname]/var/git/[reporsitory].git/"

#####################################
echo "Add Git Member (empty to skip)"
#####################################
while read -p "[user_account]: " account
	do
		# Skip
		test "${account}" = "" && ( echo "no add member"; break )
		echo "here"
		# User_account is nonempty
		if [ `getent passwd ${account}` ]; then
			# return 0 (account exists)
			usermod -a -G git ${account}
			echo "\n'${account}' joins to Git group."
			break
		else
			# return 1 (account not exist)
			echo "Invalid account. Please try again."
		fi
	done
echo ""

#####################################
echo "Create/Choose Git Repository (empty to skip)"
#####################################
while read -p "[repo_name]: " repo 
	do
		# Skip
		test "${repo}" = "" && break
		# Repo_name is nonempty
		## repository exists
		if [ -d "${path}/${repo}.git" ]; then
			echo -n "'${repo}' exists."
			read -p "'Are you sure you wanna choose? [y/N] " ans
				# Choose this repository: yes or no
				if [ "${ans}" = "y" ] || [ "${ans}" = "Y" ]; then
					break
				else
					echo "Please create or choose Git repository."
				fi
		## repository does not exist
		else
			mkdir ${path}/${repo}.git
			cd ${path}/${repo}.git
			git --bare init > /dev/null
			chgrp -R git ${path}/${repo}.git
			chmod -R g+rwx ${path}/${repo}.git
			break
		fi
	done
echo ""

#####################################
if [ "${repo}" = "" ]; then
	test "${account}" = "" && echo -n "Nothing to change. "
	echo "Thanks for using."
else
	test "${account}" = "" && account="[gituser]"
	echo "Successes!\n"
	echo "Now you can go back to your workspace and remote url:"
	url="ssh://${account}@${hostname}${path}/${repo}.git/"
	echo "  '${url}'"
	echo "to use the remote repository. For example:"
	echo "$ git remote add origin ${url}"
fi
#####################################
echo "\nFor more iniformation of 'git',"
echo "please try 'git --help', 'git help <command>'"
echo "or visit the website: <https://git-scm.com/> "
unset path repo account ans url hostname
