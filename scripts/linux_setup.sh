#!/bin/sh

set -e
sudo apt-get install zsh
chsh -s /bin/zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"

echo "====================="
echo "1. Backup your config files. e.g. ~/.zshrc -> ~/.zshrc.backup"

# Require Vim with Lua
if [ -f "$HOME/.zshrc" ]; then
  echo "$file found."
  mv ~/.zshrc ~/.zshrc.backup
else
  echo "$file not found."
fi

echo "====================="
echo "2. Install"
