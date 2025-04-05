get_tmux_pane_optimal_width() {
  outer_width=$(tmux display-message -p "#{window_width}")
  if [[ $outer_width -gt 150 ]]; then
    echo "80%"
  else
    echo "95%"
  fi
}

pouptmux() {
  width=$(get_tmux_pane_optimal_width)
  height=${2:-80%}
  session_name=$(tmux list-panes -t "$TMUX_PANE" -F '#S' | head -n1)
  window_index=$(tmux display-message -p '#I')
  popup_name="${session_name}_${window_index}"
  if [[ "$(tmux display-message -p -F "#{session_name}")" == _* ]]; then
    tmux detach-client
  else
    p_session_name="_${popup_name}"
    tmux display-popup -d '#{pane_current_path}' -xC -yC -w$width -h$height -E "tmux attach -t ${p_session_name} || tmux new -s ${p_session_name}"
  fi
}

poptmuxgit() {
  width=$(get_tmux_pane_optimal_width)
  height=${2:-80%}
  session_name=$(tmux list-panes -t "$TMUX_PANE" -F '#S' | head -n1)
  window_index=$(tmux display-message -p '#I')
  popup_name="${session_name}_${window_index}"
  if [[ "$(tmux display-message -p -F "#{session_name}")" == _* ]]; then
    tmux detach-client
  else
    p_session_name="_${popup_name}_git"
    tmux display-popup -d '#{pane_current_path}' -xC -yC -w$width -h$height -E "tmux attach -t ${p_session_name} || tmux new -s ${p_session_name} lazygit && tmux set-option -t ${p_session_name} status off"
  fi
}

poptmuxyazi() {
  width=$(echo "95%")
  height=${2:-80%}
  session_name=$(tmux list-panes -t "$TMUX_PANE" -F '#S' | head -n1)
  window_index=$(tmux display-message -p '#I')
  popup_name="${session_name}_${window_index}"
  if [[ "$(tmux display-message -p -F "#{session_name}")" == _* ]]; then
    tmux detach-client
  else
    p_session_name="_${popup_name}_yazi"
    tmux display-popup -d '#{pane_current_path}' -xC -yC -w$width -h$height -E "tmux set-option -t ${p_session_name} status off && tmux attach -t ${p_session_name} || tmux new -s ${p_session_name} yazi"
  fi
}
