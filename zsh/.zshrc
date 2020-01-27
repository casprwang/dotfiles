source ~/zsh/alias.zsh
source ~/zsh/keymap.zsh
source ~/zsh/function.zsh
source ~/zsh/github.zsh
source ~/zsh/wifi.zsh
source ~/zsh/aws.zsh
source ~/zsh/vi-mode.zsh
source ~/secrets.zsh
source ~/zsh/fzf.zsh

# Zplugin
source ~/.zplugin/bin/zplugin.zsh
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin
# End of Zplugin's installer chunk

zplugin light rupa/z
zplugin ice pick"async.zsh" src"pure.zsh"; zplugin light sindresorhus/pure
zplugin ice silent wait'!0' atload'load_pyenv;'
zplugin ice as"program" pick"bin/git-dsf"
zplugin light zdharma/zsh-diff-so-fancy
zplugin light zdharma/fast-syntax-highlighting
zplugin light lukechilds/zsh-nvm
zplugin light zsh-users/zsh-autosuggestions
zplugin load psprint/zsnapshot
