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
export PATH=$HOME/.local/share/mise/installs/erlang/27.2/erts-15.2/bin:$PATH
export PATH=$HOME/.local/share/mise/installs/elixir/1.18.1-otp-27/bin:$PATH
