# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    color_mode=$(tput colors)
    else
	color_prompt=
	color_mode=
    fi
fi


# If this is an xterm set the title to user@host:dir
#case "$TERM" in
#xterm*|rxvt*)
#    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
#    ;;
#*)
#    ;;
#esac
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=yes'
    alias dir='dir --color=yes'
    alias vdir='vdir --color=yes'

    alias grep='grep --color=yes'
    alias fgrep='fgrep --color=yes'
    alias egrep='egrep --color=yes'
fi

# some more ls aliases
alias ll='ls -alt'
alias la='ls -A'
#alias ls='ls -A'
alias l='ls -CF'

alias vi='vim'
alias h='history | tail -10'
alias j='jobs'
alias rm='rm -i'

# Add an "alert" alias for long running commands. Use like so:
#    sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history | tail -n1 | sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"' 

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
#if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
#    . /etc/bash_completion
#fi


# Prompt
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
#git_info=$(echo -e "\e[1;35m$(git_branch)\e[0;35m$(git_since_last_commit)\e[0m")
IP=$(curl http://checkip.amazonaws.com/ 2> /dev/null)
if [ "$color_prompt" = yes ]; then
    if [ "$color_mode" = 256 ]; then
        PS1='\[\e[38;5;226m\]\u\[\e[38;5;208m\][\h-${IP}]:\[\e[0m\]\[\e[0;38;5;87m\]\w\[\e[0m\] \[\e[1;35m\]$(git_branch)\[\e[0;35m\]$(git_since_last_commit)\[\e[0m\]\$ '
    else
        PS1='\[\e[0;33m\]\u\[\e[0;32m\][\h:${IP}]:\[\e[0;36m\]\w\[\e[0m\] \[\e[1;35m\]$(git_branch)\[\e[0;35m\]$(git_since_last_commit)\[\e[0m\]\$ '
    fi
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt color_mode
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------

# Search First-matching History Command"
bind '"\x1b\x5b\x41":history-search-backward'
bind '"\x1b\x5b\x42":history-search-forward'

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib

# added cuda path
export PATH=/usr/local/cuda/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
# added $HOME/bin
export PATH="$PATH:$HOME/bin:$HOME/.local/bin"
