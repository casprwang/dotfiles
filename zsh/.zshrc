# cores that can't be deferred
source ~/.config/zsh/init.sh

deferred() {
  source ~/.config/zsh/alias.sh
  source ~/.config/zsh/path.sh
  source ~/.config/zsh/functions.sh
  source ~/.config/zsh/fzf.sh
}

source ~/zsh-defer/zsh-defer.plugin.zsh

zsh-defer deferred

# defer path
zsh-defer source ~/.config/zsh/path.zsh

# defer plugins
zsh-autosuggestions() {
  source ~/zsh-autosuggestions/zsh-autosuggestions.zsh
  ZSH_AUTOSUGGEST_STRATEGY=completion
}
zsh-defer zsh-autosuggestions
zsh-defer source ~/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
zsh-completions() {
  fpath=(~/zsh-completions/src $fpath)
}
zsh-defer zsh-completions

#
zsh-defer source $HOME/.zsh-vi-mode/zsh-vi-mode.plugin.zsh
