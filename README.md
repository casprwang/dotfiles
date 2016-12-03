# This collection includes the dotfiles of neovim zsh, vim, tmux, atom and code.

[neovim](https://cloud.githubusercontent.com/assets/19645990/20860136/0498f136-b93f-11e6-9887-f4ead14078ce.gif)
[neovim](https://cloud.githubusercontent.com/assets/19645990/20860150/42b74904-b93f-11e6-9073-5a9ca39e09dc.gif)]

## files
* neovim [init.vim](https://github.com/wangsongiam/dotfiles/blob/master/nvim/init.vim)
* vim [.tmux.conf](https://github.com/wangsongiam/dotfiles/blob/master/.tmux.conf)
* zsh [.zshrc](https://github.com/wangsongiam/dotfiles/blob/master/.zshrc)

![dotfile cast 1k
2](https://cloud.githubusercontent.com/assets/19645990/16610534/5f89bac0-438e-11e6-866f-342825f8ffd8.gif)

check out the

# For Installation

Terminal

    touch .bash_profile
    vim .bash_profile


    mkdir dotfiles
    mv .vim dotfiles/
    mv .vimrc dotfiles/.vim
    ln -s ~/dotfiles/.vim ~/.vim
    ln -s ~/dotfiles/.vim/.vimrc ~/.vimrc
    ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf

References

    https://github.com/Goles/Battery
    https://robots.thoughtbot.com/tmux-copy-paste-on-os-x-a-better-future
