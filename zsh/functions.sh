tmp() {
  # file_path = ~/tmp/tmp
  var=$1
  if [[ -z ${var} ]]; then
    nvim ~/tmp/tmp
  else
    nvim ~/tmp/tmp.${var}
  fi
}

function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}
