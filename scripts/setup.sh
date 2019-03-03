#!/bin/sh

set -e
curl https://raw.githubusercontent.com/wangsongiam/dotfiles/master/.gitconfig > ~/.gitconfig

sudo wget -O /usr/local/bin/rmate https://raw.github.com/aurora/rmate/master/rmate
sudo chmod a+x /usr/local/bin/rmate
