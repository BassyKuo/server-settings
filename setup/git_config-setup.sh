#!/bin/bash

# Usage: 
#	bash git_config-setup.sh <github_email> <github_name>

email=${1:-"aaammmyyy27@gmail.com"}
name=${2:-"BassyKuo"}

git config --global user.email $email
git config --global user.name $name
git config --global alias.ci commit
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.st status
