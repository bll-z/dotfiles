#!/usr/bin/env bash
cd "$(dirname "${BASH_SOURCE}")"
git pull origin master
function doIt() {
    if [ -e ~/.zshrc ]
        then
        echo 'ignoring user files'
        rsync --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" \
            --exclude "README.md" --exclude "LICENSE-MIT.txt" \
            --exclude "install-dependencies.sh" \
            --exclude ".zshrc" \
            --exclude ".osx" -av --no-perms . ~
        else
        echo 'fresh install'
        rsync --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" \
            --exclude "README.md" --exclude "LICENSE-MIT.txt" \
            --exclude "install-dependencies.sh" -av --no-perms . ~
    fi
    source ~/.bash_profile
    brew tap Homebrew/brewdler
    brew update
    brew brewdle
    brew upgrade
    brew cask alfred link
    brew cleanup
    syspip install --upgrade pip
    syspip install --upgrade setuptools
    syspip install -r  requirements.txt
    npm install -g bower
    npm install -g protractor
    npm install -g karma
    gem install bundler
    gem install compass
    source ~/.bash_profile
}
if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt
	fi
fi
unset doIt
