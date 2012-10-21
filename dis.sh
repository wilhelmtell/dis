verify_command() {
  local cmd="$1"
  if [ -z "$cmd" ]; then
    echo "empty command" && return 1
  elif [ $cmd != "post" ]; then
    echo "unrecognized command" && return 1
  fi
  return 0
}

verify_text() {
  local text="$1"
  if [ -z "$text" ]; then
    echo "there's an easier way to be silent" && return 1
  elif [ $(echo -n "$text" |wc -c) -gt 140 ]; then
    echo "too long a post" && return 1
  fi
  return 0
}

verify_argument_count() {
  if [ $# -ne 2 ]; then
    echo "command or text not given" && return 1
  fi
  return 0
}

verify() {
  verify_argument_count "$@" || return 1
  verify_command "$1" || return 1
  verify_text "$2" || return 1
  return 0
}

post() {
  local text="$1"
  git commit --allow-empty -m"$text"
  return $?
}
