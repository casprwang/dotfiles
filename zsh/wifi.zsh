# scripts to switch between wifi and ethernet, also switch open config and
# local configurations

SSH_DIR=$HOME/.ssh
GIF_CONFIG_FILE=$HOME/.gitconfig


# check if wifi is the first hardward port system using
is_wifi () {
    if [ -n "$(networksetup -listnetworkserviceorder | grep "(1)" | grep Wi-Fi)" ]; then
        true
    else
        false
    fi
}


check_network () {
    if [ -n "$(networksetup -listnetworkserviceorder | grep "(1)" | grep Wi-Fi)" ]; then
        echo "WiFi"
    else
        echo "Ethernet"
    fi
}


# toggle or setting wifi on and off
wifi () {
    [ -z "$1" ] && { echo "need one argument "; return 1 }
    if [ "$1" = "toggle" ]; then
        is_wifi
        if [ $? -eq 0 ]; then
            wifi off
        else
            wifi on
        fi
    else 
        [ "$1" = "off" ] && {
            _citadel
            echo "using Ethernet"
        }
        [ "$1" = "on" ] && {
            _github
            echo "using Wifi"
        }
    fi
}


_citadel () {
    networksetup -ordernetworkservices Ethernet Wi-Fi "iPhone USB" "Bluetooth PAN" "Thunderbolt Bridge" "Transocks"
    [ -f "$GIF_CONFIG_FILE" ] || [ -L "$GIF_CONFIG_FILE" ] && rm $GIF_CONFIG_FILE
    [ -d "$SSH_DIR" ] && rm -r $SSH_DIR
    ln -s $HOME/.gitconfig_dump $HOME/.gitconfig
    ln -s $HOME/.ssh_dump $HOME/.ssh
    cat $HOME/.yarnrc_dump > $HOME/.yarnrc
    cat $HOME/.npmrc_dump > $HOME/.npmrc
    cat $HOME/.pip/pip.conf-dump > $HOME/.pip/pip.conf
}


_github() {
    networksetup -ordernetworkservices Wi-Fi Ethernet "iPhone USB" "Bluetooth PAN" "Thunderbolt Bridge" "Transocks"
    [ -f "$GIF_CONFIG_FILE" ] || [ -L "$GIF_CONFIG_FILE" ] && rm $GIF_CONFIG_FILE
    [ -d "$HOME/.ssh" ] && rm -r $HOME/.ssh
    ln -s $HOME/.gitconfig_open $HOME/.gitconfig
    ln -s $HOME/.ssh_open $HOME/.ssh
    [ -f "$HOME/.yarnrc" ] && rm $HOME/.yarnrc
    [ -f "$HOME/.npmrc" ] && rm $HOME/.npmrc
    [ -f "$HOME/.pip/pip.conf" ] && rm $HOME/.pip/pip.conf
}
