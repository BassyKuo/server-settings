#!/bin/zsh

if which tput > /dev/null ; then
    COLORS=`tput colors`
    REVERSE=`tput smso`; OFFREVERSE=`tput rmso`
    BOLD=`tput bold`
    RED=`tput setaf 1`
    GREEN=`tput setaf 2`
    YELLOW=`tput setaf 3`
    RESET=`tput sgr0`
fi

echo "Setiing zsh theme ..."

# Theme: Theunraveler (custom)
echo "$BOLD$YELLOW>> Theunraveler$RESET"
cp ../rc/.oh-my-zsh/themes/theunraveler.zsh-theme ~/.oh-my-zsh/themes/

# Theme: Powerlevel9k
echo "$BOLD$YELLOW>> Powerlevel9k$RESET"
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k


# Setup zshrc
echo "$BOLD${RED}Setup zshrc ...$RESET"
cp ../rc/.zshrc ~/
