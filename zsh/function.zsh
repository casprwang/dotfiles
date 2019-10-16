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
        sudo mount -o retrans=3,deadtimeout=8 truenas.sd.tusimple.ai:/mnt/tank/scratch /mnt/truenas/scratch
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
