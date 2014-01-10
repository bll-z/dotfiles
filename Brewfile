# Make sure we’re using the latest Homebrew
update

# Upgrade any already-installed formulae
upgrade

# Install GNU core utilities (those that come with OS X are outdated)
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
install coreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
install findutils
# Install Bash 4
install bash

# Install wget with IRI support
install wget --enable-iri

# Install more recent versions of some OS X tools
install vim --override-system-vi
tap homebrew/dupes
install homebrew/dupes/grep
tap josegonzalez/homebrew-php
install php55

# install a few python essentials
install python --with-brewed-openssl
install python3 --with-brewed-openssl

# install mysql
install mysql
# install mongo
install mongo
install elasticsearch
# Install other useful binaries
install git
install ack
install pigz
install rename
install tree
install webkit2png


# Remove outdated versions from the cellar
cleanup
