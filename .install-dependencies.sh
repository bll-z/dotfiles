# link the dotfiles
ln -s $PWD ~

# set some variables
TOOLS_HOME=$HOME/Tools
VIRTUALENVS_HOME=$HOME/Virtualenvs

#unhide library
chflags nohidden $HOME/Library

# install xcode command line tools
xcode-select --install

# homebrew
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

# run the bootstrap
./bootstrap.sh

# set fish to default terminal
chsh -s /usr/local/bin/fish

# install virtual environment
pip install virtualenv

# Create needed directories
mkdir -p $TOOLS_HOME/lib/fish
mkdir -p $HOME/.pip/{cache,wheels} $VIRTUALENVS_HOME

# add some tools
# virtualenv wrapper
git clone git://github.com/justinmayer/virtualfish.git $TOOLS_HOME/lib/fish/virtualfish
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
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mongodb.plist
# ElasticSearch
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
postgres -D /usr/local/var/postgres
ln -sfv /usr/local/opt/postgresql/*.plist ~/Library/LaunchAgents
# MsSql - remove originals and symlink included
rm -f /usr/local/Cellar/freetds/0.91/etc/freetds.conf
rm -f /usr/local/Cellar/unixodbc/2.3.1/etc/odbc.ini
rm -f /usr/local/Cellar/unixodbc/2.3.1/etc/odbcini.ini
ln -s ~/dotfiles/db_files/mssql/freetds.conf /usr/local/Cellar/freetds/0.91/etc
ln -s ~/dotfiles/db_files/mssql/freetds.conf /usr/local/etc
ln -s ~/dotfiles/db_files/mssql/odbc.ini /usr/local/etc
ln -s ~/dotfiles/db_files/mssql/odbc.ini /usr/local/Cellar/unixodbc/2.3.1/etc/
ln -s ~/dotfiles/db_files/mssql/odbcini.ini /usr/local/etc
ln -s ~/dotfiles/db_files/mssql/odbcini.ini /usr/local/Cellar/unixodbc/2.3.1/etc/
