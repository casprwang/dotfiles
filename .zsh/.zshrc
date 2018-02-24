fpath+=~/.zfunc

# # python env
# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"

export NVM_LAZY_LOAD=true

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source ~/.zsh/fzf.zsh

### Added by Zplugin's installer
source '/Users/song/.zplugin/bin/zplugin.zsh'
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin
### End of Zplugin's installer chunk

## Load the pure theme, with zsh-async that's bundled with it
zplugin ice pick"async.zsh" src"pure.zsh"; zplugin light sindresorhus/pure

zplugin ice silent wait"!0"
zplugin light zdharma/fast-syntax-highlighting
zplugin light lukechilds/zsh-nvm

zplugin ice silent wait'!0' atload'_zsh_autosuggest_start'
zplugin light rupa/z
zplugin light zsh-users/zsh-autosuggestions
zplugin load psprint/zsnapshot

eval $(/mnt/truenas/scratch/brewery/bin/brewery --env)

