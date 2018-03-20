#!/bin/bash

# ---[ show system colors: 8 colors / 256 colors
function show_colors {
    for i in $(seq 0 $(tput colors) ) ; do tput setaf $i ; echo -n -e "$i\t" ; done ; tput setaf 15 ; echo
}

# ---[ add del/trash command
TRASH_DIR=$HOME/.trash
test -d $TRASH_DIR || mkdir $TRASH_DIR
function del {
    mv $@ $TRASH_DIR
}
function trash {
    case $1 in
        del)
            read -p 'Are you sure to empty ~/.trash ? [Y/n] ' ans
            case $ans in
                Y*|y*)
                    rm -r $TRASH_DIR/*
                    ;;
                *)
                    ;;
            esac
            ;;
        ls|list)
            shift
            ls $@ $TRASH_DIR
            ;;
        ll)
            shift
            ls -alt $@ $TRASH_DIR
            ;;
        la)
            shift
            ls -a $@ $TRASH_DIR
            ;;
        l)
            shift
            ls -CF $@ $TRASH_DIR
            ;;
        *)
            PROG=$(echo $0 | awk -F'/' '{print $NF}')
            TAB=$(echo -e '\t')
            printf "%s\n" "Usage: $PROG del"
            printf "%s\n" "       $PROG {ls,ll,la,l}"
            echo ""
            format="%s\t%s\n"
            ( \
            printf $format "del" "Empty $TRASH_DIR"
            printf $format "ls|list" "List $TRASH_DIR"
            printf $format "ll" "ls -alt $TRASH_DIR"
            printf $format "la" "ls -a $TRASH_DIR"
            printf $format "l" "ls -CF $TRASH_DIR"
            ) | column -t -s"$TAB" | awk '{print "   "$0}'
            echo ""
            unset format PROG TAB
            ;;
    esac
}

# ---[ add git info
function git_branch {
	ref=$(git symbolic-ref HEAD 2> /dev/null) || return;
	echo "("${ref#refs/heads/}") ";
}
function git_since_last_commit {
	now=`date +%s`;
	last_commit=$(git log --pretty=format:%at -1 2> /dev/null) || return;
	seconds_since_last_commit=$((now-last_commit));
	minutes_since_last_commit=$((seconds_since_last_commit/60));
	hours_since_last_commit=$((minutes_since_last_commit/60));
	minutes_since_last_commit=$((minutes_since_last_commit%60));
	echo "${hours_since_last_commit}h ${minutes_since_last_commit}m "
}
git_info=$(echo -e "\e[1;35m$(git_branch)\e[0;35m$(git_since_last_commit)\e[0m")
#PS1="$(echo $PS1 | sed s'/ *\([#\$]\+\) *$/ ${git_info}\1 /'g)"     # git_info() from ~/.bash_aliases

# ---[ show hdd_status.log
function show_hdd_health {
    log=$1
    REVERSE=`tput smso`; OFFREVERSE=`tput rmso`
    BOLD=`tput bold`
    RED=`tput setaf 1`
    YELLOW=`tput setaf 3`
    if [ `tput colors` -ne 8 ]; then
        GREEN=`tput setaf 10`
    else
        GREEN=`tput setaf 2`
    fi
    RESET=`tput sgr0`
    echo 
    cat $log | \
        sed "s/\(=== .* ===\)/$BOLD$YELLOW\1$RESET/g" | \
        sed "s/\(PASSED\)/$GREEN\1$RESET/g" | \
        sed "s/\(FAIL.*\)/$BOLD$RED\1$RESET/g"
}
#show_hdd_health /home/hdd_status.log


# ---[ other aliases
#alias matlab='/usr/local/R2017a/bin/matlab -nojvm -nodisplay -nosplash'
