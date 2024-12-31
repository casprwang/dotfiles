source ~/zsh-defer/zsh-defer.plugin.zsh
source ~/.config/zsh/ui.zsh
source ~/.config/zsh/edit.zsh
source ~/.config/zsh/alias.zsh

#
zsh-defer source ~/.config/zsh/path.zsh

#
function zsh-autosuggestions() {
  source ~/zsh-autosuggestions/zsh-autosuggestions.zsh
  ZSH_AUTOSUGGEST_STRATEGY=completion
}
zsh-defer zsh-autosuggestions

# 
zsh-defer source ~/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

function zsh-completions () {
  fpath=(~/zsh-completions/src $fpath)
}
zsh-defer zsh-completions

#
zsh-defer source $HOME/.zsh-vi-mode/zsh-vi-mode.plugin.zsh
