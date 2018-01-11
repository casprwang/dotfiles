# go new
gn () {
        mkdir "$1"
        cd "$1"
        nvim main.go
}

# git new
gitnew() {
        git init
        echo '# first touch' > README.md
        git add .
        git commit -m "first touch"
        git remote add origin $1
        git push -u origin master
}

# git setup
gitsetup() {
        git init
        git remote add origin $1
        git pull --rebase origin master
        git add .
        git commit -m "🎉 rebase"
        git push origin master
}

# quick git add+commit+push
gitpush() {
        git add .
        git commit -am "$*"
        git push origin master
}

gitcm() {
        git add .
        git commit -am "$*"
}


source_zsh() {
  source ~/.zshrc
  source ~/.zprofile
  echo 'all the zsh files are sourced!'
}


# mkdir and cd into it
mkcdir ()
{
        mkdir -p -- "$1" &&
                cd -P -- "$1"
}
