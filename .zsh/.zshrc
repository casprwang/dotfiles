fpath+=~/.zfunc

# OPAM configuration
. /Users/song/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

export NVIM_TUI_ENABLE_CURSOR_SHAPE=1

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


source /Users/song/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/fzf.zsh
