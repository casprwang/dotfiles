pouptmux() {
    width=${2:-80%}
    height=${2:-80%}
    session_name=$(tmux list-panes -t "$TMUX_PANE" -F '#S' | head -n1)
    window_index=$(tmux display-message -p '#I')
    popup_name="${session_name}_${window_index}"
    if [[ "$(tmux display-message -p -F "#{session_name}")" == _* ]];then
        tmux detach-client
    else
        p_session_name="_${popup_name}"
        tmux popup -d '#{pane_current_path}' -xC -yC -w$width -h$height -K -E -R "tmux attach -t ${p_session_name} || tmux new -s ${p_session_name}"
    fi
}
