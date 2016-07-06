# This collection includes the configuration of vim, tmux and atom. 
[[ http://www.sheawong.com/wp-content/uploads/2013/08/keephatin.gif | height = 100px ]]


![shortcast of vim](http://i.imgur.com/gtoUll1.gifv | height =
800px)


#For Installation

Terminal

    touch .bash_profile
    vim .bash_profile
    https://github.com/Goles/Battery
    https://robots.thoughtbot.com/tmux-copy-paste-on-os-x-a-better-future

Then copy these codes in Terminal

    mkdir dotfiles 
    mv .vim dotfiles/ 
    mv .vimrc dotfiles/.vim
    ln -s ~/dotfiles/.vim ~/.vim 
    ln -s ~/dotfiles/.vim/.vimrc ~/.vimrc
    ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf

Then copy these codes in .bash\_profile in the home directory

    alias vimr="vim .vimrc"
    alias gs="git status"
    alias ga="git add ."
    alias gch="git checkout"
    alias gcm="git commit -m"
    alias gp="git push origin"
    alias gm="git merge"
    alias gb="git branch"
    alias ts="tmux source-file ~/.tmux.conf"
    alias t="tmux"

    # Setting PATH for Python 3.5
    # The orginal version is saved in .bash_profile.pysave
    PATH="/Library/Frameworks/Python.framework/Versions/3.5/bin:${PATH}"
    export PATH
