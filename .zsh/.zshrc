fpath+=~/.zfunc

export NVIM_TUI_ENABLE_CURSOR_SHAPE=1
export NVM_LAZY_LOAD=true

PROFILE_STARTUP=false
if [[ "$PROFILE_STARTUP" == true ]]; then
    # http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
    PS4=$'%D{%M%S%.} %N:%i> '
    exec 3>&2 2>$HOME/tmp/startlog.$$
    setopt xtrace prompt_subst
fi
# Entirety of my startup file... then
if [[ "$PROFILE_STARTUP" == true ]]; then
    unsetopt xtrace
    exec 2>&3 3>&-
fi

# no duplications in search result
setopt hist_ignore_dups

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


source ~/.zsh/fzf.zsh

### Added by Zplugin's installer
source '/Users/song/.zplugin/bin/zplugin.zsh'
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin
### End of Zplugin's installer chunk

## Load the pure theme, with zsh-async that's bundled with it
zplugin ice pick"async.zsh" src"pure.zsh"; zplugin light sindresorhus/pure

# zplugin ice as"command" pick"${ZPLGM[HOME_DIR]}/cmd/bin/git-*" make"PREFIX=${ZPLGM[HOME_DIR]}/cmd"
# zplugin light tj/git-extras

zplugin ice silent wait"1" # 1 second after prompt
zplugin light zdharma/fast-syntax-highlighting
zplugin light lukechilds/zsh-nvm

zplugin ice silent wait'1' atload'_zsh_autosuggest_start'
zplugin light zsh-users/zsh-autosuggestions
