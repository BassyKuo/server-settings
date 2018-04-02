#!/bin/bash
file1=$1
file2=$2
diff <(awk -F'/' '{print $1}' $file1 ) <(awk -F'/' '{print $1}' $file2 ) -y | \
    sed 1d | \
    awk -v format="%-50s %-50s\n" \
        'BEGIN {printf "\033[4m"format"\033[0m", "'$file1'", "'$file2'"}
         {if ($1 == ">")        printf "\033[32m"format"\033[0m","",$2;
          else if ($2 == "<")   printf "\033[33m"format"\033[0m",$1,"";
          else {if ($1 == $2)   ;# printf "\033[31m"format"\033[0m", $1, $2;
                else {$2=$3;    printf "\033[36m"format"\033[0m", $1, $2;}}}'
