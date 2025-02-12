# cores that can't be deferred
source ~/zsh-defer/zsh-defer.plugin.zsh
source ~/.config/zsh/init.sh

# defer plugins
zsh-autosuggestions() {
  source ~/zsh-autosuggestions/zsh-autosuggestions.zsh
  ZSH_AUTOSUGGEST_STRATEGY=completion
}

zsh-completions() {
  fpath=(~/zsh-completions/src $fpath)
}

deferred() {
  zsh-autosuggestions
  source $HOME/.zsh-vi-mode/zsh-vi-mode.plugin.zsh
  source ~/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  source ~/.config/zsh/alias.sh
  source ~/.config/zsh/path.sh
  source ~/.config/zsh/functions.sh
  source ~/.config/zsh/fzf.sh
  zsh-completions
  export TERM=xterm-ghostty
}

zsh-defer deferred

function gi() { curl -sLw "\n" https://www.toptal.com/developers/gitignore/api/$@; }
