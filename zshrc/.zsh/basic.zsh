export PATH=${PATH}:/usr/local/opt/gettext/bin
# source ~/.bin/tmuxinator.zsh
export PATH=$PATH:/usr/local/go/bin
export TERM=screen-256color
export PATH="$PATH:`yarn global bin`"
export GOPATH=$HOME/gocode
export VSCODE_TSJS=1
PATH=$PATH:/usr/local/bin

# in case tmux not working again
# sudo it
# sudo sysctl -w kern.tty.ptmx_max=256
#
autoload -U promptinit; promptinit
prompt pure
source /Users/wangsong/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export PATH="$PATH:$HOME/.yarn/bin"


# for docker info below
# https://docs.docker.com/compose/completion/
fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit -i

# for node projects
export PATH=$PATH:./node_modules/.bin


function gi() { curl -L -s https://www.gitignore.io/api/$@ ;} >> .gitignore

export NVIM_TUI_ENABLE_CURSOR_SHAPE=1
