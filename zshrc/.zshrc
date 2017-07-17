source ~/.zsh/fzf.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# OPAM configuration
. /Users/wangsong/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

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
