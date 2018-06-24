fpath+=~/.zfunc

export EDITOR=nvim

export NVM_LAZY_LOAD=true

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source ~/.zsh/fzf.zsh

### Added by Zplugin's installer
source '/Users/song/.zplugin/bin/zplugin.zsh'
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin
### End of Zplugin's installer chunk

zplugin light rupa/z
## Load the pure theme, with zsh-async that's bundled with it
zplugin ice pick"async.zsh" src"pure.zsh"; zplugin light sindresorhus/pure

zplugin ice silent wait"!0"
zplugin light zdharma/fast-syntax-highlighting
zplugin light lukechilds/zsh-nvm

zplugin ice silent wait'!0' atload'_zsh_autosuggest_start'
zplugin ice silent wait'!0' atload'load_pyenv'
zplugin light zsh-users/zsh-autosuggestions
zplugin load psprint/zsnapshot

# eval $(/mnt/truenas/scratch/brewery/bin/brewery --env)

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/song/Downloads/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/song/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/song/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/song/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

eval $(/Users/song/.brewery/bin/brewery --env)
