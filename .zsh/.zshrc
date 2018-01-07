fpath+=~/.zfunc
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

source ~/.zsh/fzf.zsh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# OPAM configuration
. /Users/song/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

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

# The following lines were added by compinstall
zstyle :compinstall filename '/Users/song/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
