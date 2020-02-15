gam() {
        git add .
        git commit -am "$*"
}


source_zsh() {
        source ~/.zshrc
        source ~/.zprofile
        echo 'all the zsh files are sourced!'
}



ts_mount() {
        sudo mount -o retrans=3,deadtimeout=8 truenas.sd.tusimple.ai:/mnt/tank/scratch /Users/songwang/mnt/truenas/scratch
        sudo mount -o retrans=3,deadtimeout=8 truenas.sd.tusimple.ai:/mnt/tank/datasets /mnt/truenas/datasets
        sudo mount -o retrans=3,deadtimeout=8 truenas.sd.tusimple.ai:/mnt/tank/rsync /mnt/truenas/rsync
        sudo mount -o retrans=3,deadtimeout=8 truenas.sd.tusimple.ai:/mnt/tank/upload /mnt/truenas/upload
        sudo mount -o retrans=3,deadtimeout=8 truenas.sd.tusimple.ai:/mnt/tank/datasets_addon /mnt/truenas/datasets_addon
}

load_pyenv(){
# python env
        export PYENV_ROOT="$HOME/.pyenv"
        export PATH="$PYENV_ROOT/bin:$PATH"
        eval "$(pyenv init -)"
        eval "$(pyenv virtualenv-init -)"
}

load_tspkg(){
        eval $(cd && .tspkg/bin/tsp --env)
}

cssh() {
        sshpass -p 'Hoboken123!@#Roo' ssh swang5@"$1"
}


sshc() {
    echo "test$1"
    sshpass -p "$CITADEL_PASSWORD" ssh "swang5@ld-dbn-grdev$1"
}

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'
