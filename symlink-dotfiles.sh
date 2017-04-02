#!/bin/bash

dev="$HOME/Developer"
dotfiles="$dev/Song/dotfiles"

if [[ -d "$dotfiles" ]]; then
  echo "Symlinking dotfiles from $dotfiles"
else
  echo "$dotfiles does not exist"
  exit 1
fi

link() {
  from="$1"
  to="$2"
  echo "Linking '$from' to '$to'"
  rm -f "$to"
  ln -s "$from" "$to"
}

if [[ `uname` == 'Darwin' ]]; then
  link "$dotfiles/.vim/.vimrc" "$HOME/.vimrc"
fi
