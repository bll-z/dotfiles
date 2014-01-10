#!/usr/bin/env bash
# link the dotfiles
ln -s $PWD ~

# set some variables
TOOLS_HOME=$HOME/Tools
VIRTUALENVS_HOME=$HOME/Virtualenvs

#create the bash profile
touch ~/.bash_profile

#unhide library
chflags nohidden $HOME/Library

# install xcode command line tools
xcode-select --install

# homebrew
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
brew install git
# run the bootstrap
./bootstrap.sh

# set bash4 and zsh to default terminal
echo "/usr/local/bin/bash" | sudo tee -a /etc/shells
echo "/usr/local/bin/zsh" | sudo tee -a /etc/shells
chsh -s /usr/local/bin/zsh

# install virtual environment
syspip install virtualenv
syspip install pylint

# Create needed directories
#mkdir -p $TOOLS_HOME/lib/fish
mkdir -p $HOME/.pip/{cache,wheels} $VIRTUALENVS_HOME

# Spotify Control Script
#.alias
cd $TOOLS_HOME/lib
git clone git://github.com/dronir/SpotifyControl.git
# https://github.com/jeroenbegyn/VLCControl
# VLC Control Script
# .alias
cd $TOOLS_HOME/lib
git clone git://github.com/jeroenbegyn/VLCControl.git
# https://github.com/jamiew/git-friendly
# adds 'push', 'pull', 'branch [name]', and 'merge [name]' commands
# .path
bash < <( curl https://raw.github.com/jamiew/git-friendly/master/install.sh)
# Databases

# Mongo
ln -sfv /usr/local/opt/mongodb/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mongodb.plist
# ElasticSearch
ln -sfv /usr/local/opt/elasticsearch/*.plist ~/Library/LaunchAgents
launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.elasticsearch.plist
# Plus river plugin
git clone git://github.com/richardwilly98/elasticsearch-river-mongodb.git /usr/local/var/lib/elasticsearch/plugins
cd /usr/local/var/lib/elasticsearch/plugins/elasticsearch-river-mongodb
./install-local.sh
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.elasticsearch.plist

# MySql
ln -sfv /usr/local/opt/mysql/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist
# Postgres
initdb -D /usr/local/pgsql/data
ln -sfv /usr/local/opt/postgresql/*.plist ~/Library/LaunchAgents

# MsSql - remove originals and symlink included
brew install freetds --with-unixodbc #0.91
rm -f /usr/local/Cellar/freetds/0.91/etc/freetds.conf
rm -f /usr/local/Cellar/unixodbc/2.3.2/etc/odbc.ini
rm -f /usr/local/Cellar/unixodbc/2.3.2/etc/odbcini.ini
rm -f /usr/local/etc/odbc.ini
rm -f /usr/local/etc/odbcini.ini
ln -s ~/dotfiles/db_files/mssql/freetds.conf /usr/local/Cellar/freetds/0.91/etc
ln -s ~/dotfiles/db_files/mssql/freetds.conf /usr/local/etc
ln -s ~/dotfiles/db_files/mssql/odbc.ini /usr/local/etc
ln -s ~/dotfiles/db_files/mssql/odbc.ini /usr/local/Cellar/unixodbc/2.3.2/etc/
ln -s ~/dotfiles/db_files/mssql/odbcini.ini /usr/local/etc
ln -s ~/dotfiles/db_files/mssql/odbcini.ini /usr/local/Cellar/unixodbc/2.3.2/etc/
