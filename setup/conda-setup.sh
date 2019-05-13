#!/bin/bash

read -p "Install [A]naconda / [M]iniconda ? [A/m/n] " ans_conda
if [[ $ans_conda =~ ^[aA]*$ ]]; then
    curl -O https://repo.continuum.io/archive/Anaconda3-5.2.0-Linux-x86_64.sh
    bash Anaconda3-*.sh
    rm Anaconda3-*.sh
    conda_home=$HOME/anaconda3
elif [[ $ans_conda =~ ^[mM]+$ ]]; then
    curl -O https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
    bash Miniconda3-*.sh
    rm Miniconda3-*.sh
    sed -i'.bak' '/miniconda3/d' $HOME/.bash_profile
    echo ". $HOME/miniconda3/etc/profile.d/conda.sh" >> $HOME/.bash_profile
    rm $HOME/.bash_profile.bak
    conda_home=$HOME/miniconda3
fi
if [[ $ans_conda =~ ^[aAmM]*$ ]]; then
    $conda_home/bin/conda update conda
    echo "Use the command to setup your conda environment:"
    echo "   $ conda create -n <yourenvname> python=<x.x> anaconda"
    echo "Or you can find more usage over here: https://uoa-eresearch.github.io/eresearch-cookbook/recipe/2014/11/20/conda/"
    echo
    echo "Now you need to re-login to enable the conda service."
    echo "If you want to uninstall conda: "
    echo "   $ rm -r $conda_home"
    echo
fi
echo
