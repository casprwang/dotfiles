fpath+=~/.zfunc

export NVIM_TUI_ENABLE_CURSOR_SHAPE=1
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
zplugin light zsh-users/zsh-autosuggestions
