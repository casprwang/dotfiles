#!/usr/bin/env bash

# touch .bash_profile
# vim .bash_profile

mkdir dotfiles
mv .vim dotfiles/
mv .vimrc dotfiles/.vim
ln -s ~/dotfiles/.vim ~/.vim
ln -s ~/dotfiles/.vim/.vimrc ~/.vimrc
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
