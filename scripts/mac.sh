# clone dotfiles
git clone https://github.com/wangsongiam/dotfiles.git

# karabiner
## install karabiner mannually permission needed
[ -d ~/.config/karabiner ] && mv ~/.config/karabiner ~/.config/karabiner_old
ln -s ~/dotfiles/karabiner ~/.config/karabiner

# hammerspoon
## install hammerspoon manually permission needed
[ -d ~/.hammerspoon ] && mv ~/.hammerspoon ~/.hammerspoon_old
ln -s ~/dotfiles/.hammerspoon ~/.hammerspoon

# alfred
## download and get preference from gist
sudo spctl --master-disable


# brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" 

# chrome brew tap caskroom/cask 
brew search google 
brew search google-chrome
brew tap homebrew/cask-versions
brew cask install google-chrome
brew cask install google-chrome-canary


# rust
curl https://sh.rustup.rs -sSf | sh

# utils
brew install \
htop \
cmake \
neovim \
go \
zsh \
wget \
hub \
reattach-to-user-namespace \
fzf \
ripgrep \





# source code pro
brew tap homebrew/cask-fonts && brew cask install font-source-code-pro

# nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash

# node
nvm install 10


# pyenv
brew install readline xz zlib
brew install the_silver_searcher

sudo installer -pkg /Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_macOS_10.14.pkg -target /

curl https://pyenv.run | bash
pyenv install 2.7.14
pyenv install 2.7.15
pyenv install 3.6.5
pyenv install 3.6.6

pyenv virtualenv 2.7.14 neovim2
pyenv virtualenv 3.6.5 neovim3

pyenv virtualenv 2.7.14 neovim2
pyenv virtualenv 3.6.5 neovim3
pyenv activate neovim2
pip install neovim
pip install flake8
pyenv which python  # Note the path
pyenv activate neovim3
pip install neovim

pyenv global 2.7.14 3.6.6

# alacritty
brew cask install alacritty
[ -d ~/.config/alacritty ] && mv ~/.config/alacritty ~/.config/alacritty_old
ln -s ~/dotfiles/alacritty ~/.config/alacritty

# nvim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
## install plugins inside of nvim


# zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)" # zplugin

rm ~/.zshrc ~/.zprofile
ln -s ~/dotfiles/zsh ~/zsh
ln -s ~/dotfiles/zsh/.zshrc ~/.zshrc

source ~/.zplugin/bin/zplugin.zsh
zsh

## zsh for mojave
sudo sh -c "echo $(which zsh) >> /etc/shells"
chsh -s $(which zsh)


# emux
brew install https://raw.githubusercontent.com/Homebrew/homebrew-core/9d2ab46c92cc88470b1c54f5da2d0a1595188533/Formula/tmux.rb # tmux 2.8
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf


# vscode
