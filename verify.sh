source $SCRIPT_DIRECTORY/error.sh

verify_command() {
  local cmd="$1"
  if [ -z "$cmd" ]; then
    error "empty command"
  elif [ $cmd != "post" ]; then
    error "unrecognized command"
  fi
  return $?
}

verify_text() {
  local text="$1"
  if [ -z "$text" ]; then
    error "there's an easier way to be silent"
  elif [ $(echo -n "$text" |wc -c) -gt 140 ]; then
    error "too long a post"
  fi
  return $?
}

verify_argument_count() {
  if [ $# -ne 2 ]; then
    error "command or text not given"
  fi
  return $?
}

verify() {
  verify_argument_count "$@" &&
    verify_command "$1" &&
    verify_text "$2" &&
  return $?
}

