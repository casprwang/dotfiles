export THEME_FILE="/Users/songwang/.local/state/nvim/os_mode"
export FZF_OPTS_FILE="/Users/songwang/.local/state/nvim/fzf_opts"

fzf_light() {
  local color00='#fbf1c7'
  local color01='#ebdbb2'
  local color02='#d5c4a1'
  local color03='#bdae93'
  local color04='#665c54'
  local color05='#504945'
  local color06='#3c3836'
  local color07='#282828'
  local color08='#9d0006'
  local color09='#af3a03'
  local color0A='#b57614'
  local color0B='#79740e'
  local color0C='#427b58'
  local color0D='#076678'
  local color0E='#8f3f71'
  local color0F='#d65d0e'

  echo "--color=bg+:$color01,bg:$color00,spinner:$color0C,hl:$color0D""\
 --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C""\
 --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D"

  export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS""\
 --color=bg+:$color01,bg:$color00,spinner:$color0C,hl:$color0D""\
 --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C""\
 --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D"

}

# _gen_fzf_default_opts
# Scheme name: Gruvbox dark, medium
# Scheme system: base16
# Scheme author: Dawid Kurek (dawikur@gmail.com), morhetz (https://github.com/morhetz/gruvbox)
# Template author: Tinted Theming (https://github.com/tinted-theming)

fzf_dark() {
  local color00='#282828'
  local color01='#3c3836'
  local color02='#504945'
  local color03='#665c54'
  local color04='#bdae93'
  local color05='#d5c4a1'
  local color06='#ebdbb2'
  local color07='#fbf1c7'
  local color08='#fb4934'
  local color09='#fe8019'
  local color0A='#fabd2f'
  local color0B='#b8bb26'
  local color0C='#8ec07c'
  local color0D='#83a598'
  local color0E='#d3869b'
  local color0F='#d65d0e'
  echo "--color=bg+:$color01,bg:$color00,spinner:$color0C,hl:$color0D""\
 --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C""\
 --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D"

  export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS""\
 --color=bg+:$color01,bg:$color00,spinner:$color0C,hl:$color0D""\
 --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C""\
 --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D"
}

set_fzf_theme() {
  theme=$(defaults read -g AppleInterfaceStyle >/dev/null 2>&1)
  if [[ $theme = "Dark" ]]; then
    fzf_dark
  else
    fzf_light
  fi
}

set_fzf_theme >/dev/null 2>&1

# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

export FZF_ALT_C_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'tree -C {}'"

export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# export FZF_CTRL_T_COMMAND='command fre --sorted'
# export FZF_CTRL_T_OPTS='--tiebreak=index'
