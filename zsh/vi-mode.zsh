# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^g' edit-command-line

# vi mode
bindkey -v
export KEYTIMEOUT=1
