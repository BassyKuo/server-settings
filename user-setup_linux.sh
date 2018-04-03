#!/bin/bash

#-----------------------------------------------------------
###             FOR GENERAL USERS EXECUTING              ###
#-----------------------------------------------------------
# Add File:
#   .bashrc
#   .vimrc
#   .ssh/config
#
# Pip install:
#   virtualenv numpy scipy nose opencv-python
#
# Setting:
#   git config
#   vim-plugins-setup
#   ssh/config
#   crontab
#   Anaconda
#
### Written by Bassy<aaammmyyy27@gmail.com> 2018/03/21 v.3.5.2

# Add File
echo "Add Files..."
read -p "$(echo -e "> selete rc/.bash* file to copy to $HOME/   (MULTI-SELECT)\n  1) .bash_profile\n  2) .bashrc\n  3) .bash_alises\n  [N] ")" ans_bash_file
[[ $ans_bash_file =~ ^[^123]*$ ]] && echo "Nothing to do."
[[ $ans_bash_file =~ [1]+ ]] && cp --backup=t -p rc/.bash_profile   $HOME/.bash_profile
[[ $ans_bash_file =~ [2]+ ]] && cp --backup=t -p rc/.bashrc         $HOME/.bashrc
[[ $ans_bash_file =~ [3]+ ]] && cp --backup=t -p rc/.bash_aliases   $HOME/.bash_aliases
read -p "> copy rc/.vimrc to $HOME/ ? [Y/n] " ans_vimrc
[[ $ans_vimrc =~ ^[yY]*$ ]] && cp --backup=t -p rc/.vimrc           $HOME/.vimrc
echo

# Vim Plugins setting
read -p "Add vim plugin? [Y/n] " ans_vim
if [[ $ans_vim =~ ^[yY]*$ ]]; then
    test -e setup/vim-plugins-setup.sh && bash setup/vim-plugins-setup.sh
    echo
    echo "Set vim-plugins completely."
fi
echo

# Install Anaconda
bash setup/conda-setup.sh

# Pip install
read -p "pip install packages with [C]onda-env or system-[U]ser-env? [C/u/n] " ans_pip
if [[ $ans_pip =~ ^[cC]*$ ]]; then
    read -p ">>> Name a new conda-env for python3: " conda_name
    conda create -n $conda_name python=3 anaconda
    source activate $conda_name
    pip install --upgrade pip
    pip install --upgrade -r __pip__/requirements.txt
    source deactivate
    echo "Install successfully! Now you can use these packages by launching the conda environment:"
    echo "   $ source activate $conda_name"
elif [[ $ans_pip =~ ^[uU]+$ ]]; then
    pip install --upgrade --user pip
    pip install --upgrade --user virtualenv
    pip install --upgrade --user -r __pip__/requirements.txt
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

# Add ssh/config
read -p "Add host configures in ~/.ssh/config [y] or copy the whole rc/.ssh/config [a]?    [Y/a/n] "    ans_4
if [[ $ans_4 =~ ^[yY]*$ ]] ; then
    mkdir -p $HOME/.ssh/
    while true; do
        read -p "Host ip (xxx.xxx.xxx.xxx) [empty to exit]: " host_ip
        if [[ $host_ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
            read -p "Host alias: " host_alias
            read -p "Host username: " host_username
            echo -e "Host $host_alias\n\tHostName $host_ip\n\tUser $host_username\n"     >> $HOME/.ssh/config
            read -p "Connect $host_alias without password? [Y/n] " ans_autossh
            if [[ $ans_autossh =~ ^[yY]*$ ]] ; then
                test -e $HOME/.ssh/id_rsa || ssh-keygen
                ssh-copy-id $host_ip
            fi
            echo
        else
            break
        fi
    done
elif [[ $ans_4 =~ ^[aA]+$ ]]; then
    mkdir -p $HOME/.ssh/
    #rsync -a rc/.ssh/config    $HOME/.ssh/config
    echo "**THIS FUNCTION IS DEPRECATED because of the sensitive file.**"
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

           #m h dom mon dow user    command
    cp rc/crontab $HOME/.crontab
    sed -i "s/\$USER/${USER}/g" $HOME/.crontab
    crontab $HOME/.crontab

    #sudo service cron restart
    echo "Crontable set completely."
fi
echo

# Done
source $HOME/.bash_profile
source $HOME/.bashrc
echo "Done!"
