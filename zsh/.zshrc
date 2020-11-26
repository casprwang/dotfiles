setopt auto_cd

# Path
source ~/zsh/path.zsh
export NVIM_COC_LOG_LEVEL=debug && export NVIM_COC_LOG_FILE=/tmp/coc.log

export TERM=screen-256color
export VSCODE_TSJS=1
# Neovim
export EDITOR=nvim

# History
export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
HISTFILE=~/.zsh_history     #Where to save history to disk
setopt appendhistory     #Append history to the history file (no overwriting)
setopt sharehistory      #Share history across terminals
setopt incappendhistory  #Immediately append to the history file, not just when a term is killed
setopt hist_ignore_dups

source ~/zsh/alias.zsh
source ~/zsh/tmux.zsh
source ~/zsh/keymap.zsh
source ~/zsh/function.zsh
source ~/zsh/github.zsh
# source ~/zsh/wifi.zsh
source ~/zsh/blue.zsh
source ~/zsh/aws.zsh
source ~/zsh/vi-mode.zsh
source ~/secrets.zsh
source ~/zsh/fzf.zsh

# Zplugin
source ~/.zinit/bin/zinit.zsh
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit light rupa/z
# Load the pure theme, with zsh-async library that's bundled with it.
zinit ice pick"async.zsh" src"pure.zsh"
zinit light sindresorhus/pure

# Binary release in archive, from GitHub-releases page.
# After automatic unpacking it provides program "fzf".
zinit ice from"gh-r" as"program"
zinit load junegunn/fzf-bin


# One other binary release, it needs renaming from `docker-compose-Linux-x86_64`.
# This is done by ice-mod `mv'{from} -> {to}'. There are multiple packages per
# single version, for OS X, Linux and Windows – so ice-mod `bpick' is used to
# select Linux package – in this case this is actually not needed, Zinit will
# grep operating system name and architecture automatically when there's no `bpick'.
zinit ice from"gh-r" as"program" mv"docker* -> docker-compose" bpick"*linux*"
zinit load docker/compose



zinit ice as"program" pick"bin/git-dsf"

zinit ice wait"2" lucid as"program" pick"bin/git-dsf"

zinit light zdharma/zsh-diff-so-fancy
zinit light zdharma/fast-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light lukechilds/zsh-better-npm-completion
zplugin ice silent wait'!0' atload'load_pyenv;'
zinit light neovim/neovim
zinit load psprint/zsnapshot

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
