echo 'You might need to change your default shell to zsh: `chsh -s /bin/zsh` (or `sudo vim /etc/passwd`)'

dir="$HOME/Developer/Song"
mkdir -p $dir
cd $dir
git clone --recursive https://github.com/wangsongiam/dotfiles.git
cd dotfiles

# sudo bash symlink-dotfiles.sh

# sudo bash symlink-dotfiles.sh#!/usr/bin/env bash

# touch .bash_profile
# vim .bash_profile

# mkdir dotfiles
# mv .vim dotfiles/
# mv .vimrc dotfiles/.vim
# ln -s ~/dotfiles/.vim ~/.vim
# ln -s ~/dotfiles/.vim/.vimrc ~/.vimrc
# ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
