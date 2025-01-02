. "$HOME/.cargo/env"
# eval "$(atuin init zsh --disable-up-arrow)"
eval "$(~/.local/bin/mise activate zsh)"
eval "$(zoxide init zsh)"

source <(fzf --zsh)
export PATH="$PATH":~/bin

# Scheme name: Gruvbox light, medium
# Scheme system: base16
# Scheme author: Dawid Kurek (dawikur@gmail.com), morhetz (https://github.com/morhetz/gruvbox)
# Template author: Tinted Theming (https://github.com/tinted-theming)
