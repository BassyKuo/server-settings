#!/bin/bash

### [ REFERENCE ] ###
# https://github.com/tpope/vim-pathogen

if which tput > /dev/null ; then
    COLORS=`tput colors`
    REVERSE=`tput smso`; OFFREVERSE=`tput rmso`
    BOLD=`tput bold`
    RED=`tput setaf 1`
    GREEN=`tput setaf 2`
    YELLOW=`tput setaf 3`
    RESET=`tput sgr0`
fi

echo "Setting pathogen.vim ...."
test -e $HOME/.vim/autoload/pathogen.vim && rm $HOME/.vim/autoload/pathogen.vim
mkdir -p $HOME/.vim/autoload $HOME/.vim/bundle $HOME/.vim/colors
curl -LSso $HOME/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# --- [ PLUGIN SETUP
# http://vimawesome.com/

echo "Install Plugins ...."
# Plugin: Sensible
echo "$BOLD$YELLOW>> Sensible$RESET"
cd $HOME/.vim/bundle/
git clone https://github.com/tpope/vim-sensible.git

# Plugin: Taglist
echo "$BOLD$YELLOW>> Taglist$RESET"
cd $HOME/.vim/bundle/
git clone https://github.com/vim-scripts/taglist.vim

# Plugin: NERDTree
echo "$BOLD$YELLOW>> NERDTree$RESET"
cd $HOME/.vim/bundle/
git clone https://github.com/jistr/vim-nerdtree-tabs

# Plugin: NERDCommenter
echo "$BOLD$YELLOW>> NERDCommenter$RESET"
cd $HOME/.vim/bundle/
git clone https://github.com/ddollar/nerdcommenter

# Plugin: CheckSyntax
echo "$BOLD$YELLOW>> CheckSyntax$RESET"
cd $HOME/.vim/bundle/
git clone https://github.com/tomtom/checksyntax_vim

# Plugin: Multiple selection
echo "$BOLD$YELLOW>> Multiple-cursors$RESET"
cd $HOME/.vim/bundle
git clone https://github.com/terryma/vim-multiple-cursors

# --- [ COLORSCHEME SETUP
# http://vimcolors.com/

echo "Install Colorscheme...."
# Colorscheme: Onehalf theme
echo "$BOLD$YELLOW>> Onehalf$RESET"
cd $HOME/.vim/bundle
git clone https://github.com/sonph/onehalf
cp $HOME/.vim/bundle/onehalf/vim/colors/onehalfdark.vim $HOME/.vim/colors/

# Colorscheme: Afterglow theme
echo "$BOLD$YELLOW>> Afterglow$RESET"
cd $HOME/.vim/bundle
git clone https://github.com/danilo-augusto/vim-afterglow
# patch
f="vim-afterglow/colors/afterglow.vim"
if which sw_vers > /dev/null; then
    # For MacOs
    mv $f $f.orig
    sed $'32i\
        let s:darkgreen = "788951"\n' $f.orig | \
    sed 's/\(pythonInclude.*\)s:green\(.*\)italic/\1s:darkgreen\2/g' | \
    sed 's/\(pythonFunction.*\)italic/\1/g' > $f
else
    # For Linux
    sed -i 32i'let s:darkgreen = "788951"' $f
    sed -i s'/\(pythonInclude.*\)s:green\(.*\)italic/\1s:darkgreen\2/'g $f
    sed -i s'/\(pythonFunction.*\)italic/\1/'g $f
fi

# Colorscheme: Dracula theme
echo "$BOLD$YELLOW>> Dracula$RESET"
cd $HOME/.vim/bundle
git clone --recursive https://github.com/dracula/vim.git dracula-theme

# Colorscheme: Dark_eyes theme
echo "$BOLD$YELLOW>> Dark_eyes$RESET"
cd $HOME/.vim/bundle
git clone --recursive https://github.com/bf4/vim-dark_eyes.git vim-dark_eyes

echo "Done!"
