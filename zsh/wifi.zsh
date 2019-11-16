# scripts to switch between wifi and ethernet, also switch open config and
# local configurations

SSH_DIR=$HOME/.ssh
GIF_CONFIG_FILE=$HOME/.gitconfig


wifi () {
    [ -z "$1" ] && { echo "need one argument "; return 1 }
    [ "$1" = "off" ] && {
        citadel
        echo "using Citadel"
    }
    [ "$1" = "on" ] && {
        github
        echo "using Github"
    }
}


citadel () {
    networksetup -setairportpower en0 off > /dev/null
    [ -f "$GIF_CONFIG_FILE" ] || [ -L "$GIF_CONFIG_FILE" ] && rm $GIF_CONFIG_FILE
    [ -d "$SSH_DIR" ] && rm -r $SSH_DIR
    ln -s $HOME/.gitconfig_dump $HOME/.gitconfig
    ln -s $HOME/.ssh_dump $HOME/.ssh
    cat $HOME/.yarnrc_dump > $HOME/.yarnrc
    cat $HOME/.npmrc_dump > $HOME/.npmrc
    cat $HOME/.pip/pip.conf-dump > $HOME/.pip/pip.conf
}


github() {
    networksetup -setairportpower en0 on > /dev/null
    [ -f "$GIF_CONFIG_FILE" ] || [ -L "$GIF_CONFIG_FILE" ] && rm $GIF_CONFIG_FILE
    [ -d "$HOME/.ssh" ] && rm -r $HOME/.ssh
    ln -s $HOME/.gitconfig_open $HOME/.gitconfig
    ln -s $HOME/.ssh_open $HOME/.ssh
    rm $HOME/.yarnrc
    rm $HOME/.npmrc
    rm $HOME/.pip/pip.conf
}
