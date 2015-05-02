#!/usr/bin/env bash

# set some variables
TOOLS_HOME=$HOME/Tools
VIRTUALENVS_HOME=$HOME/Virtualenvs

#create the bash profile
touch ~/.bash_profile

#unhide library
chflags nohidden $HOME/Library

# homebrew - should already be done
#ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
#brew install git
# copy the files
# run the bootstrap
./bootstrap.sh
cp -r init/Preferences.sublime-settings ~/Library/Application\ Support/Sublime\ Text*/Packages/User/Preferences.sublime-settings 2> /dev/null
# set bash4 and zsh to default terminal
echo "/usr/local/bin/bash" | sudo tee -a /etc/shells

# Create needed directories
mkdir $TOOLS_HOME/lib
mkdir -p $HOME/.pip/cache $VIRTUALENVS_HOME

# MySql
ln -sfv /usr/local/opt/mysql/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist

# get rid of the init script
rm -f ~/init_script.sh
