For Installation
================

Terminal

::

    touch .bash_profile
    vim .bash_profile

Then copy these codes in .bash\_profile

::

    mkdir dotfiles 
    mv .vim dotfiles/ 
    mv .vimrc dotfiles/.vim
    ln -s ~/dotfiles/.vim ~/.vim 
    ln -s ~/dotfiles/.vim/.vimrc ~/.vimrc
