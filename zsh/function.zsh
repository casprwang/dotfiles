gam() {
        git add .
        git commit -am "$*"
}

gap() {
        git add .
        git commit -m "update"
        git push origin HEAD
}


function cdd() {
    cd $1
    ls
}

source_zsh() {
        source ~/.zshrc
        source ~/.zprofile
        echo 'all the zsh files are sourced!'
}


tmp_file() {
    if [ -z "$1" ]
    then
        vim ~/tmp/rand-files/$(openssl rand -base64 12)
    else
        vim ~/tmp/rand-files/$(openssl rand -base64 12)."$1"
    fi
}


load_pyenv(){
# python env
        export PYENV_ROOT="$HOME/.pyenv"
        export PATH="$PYENV_ROOT/bin:$PATH"
        eval "$(pyenv init -)"
        eval "$(pyenv virtualenv-init -)"
}

load_nvm() {
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
}

load_tspkg(){
        eval $(cd && .tspkg/bin/tsp --env)
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
