source $SCRIPT_DIRECTORY/error.sh

verify_command() {
  local cmd="$1"
  if [ -z "$cmd" ]; then
    error "no command given"
  elif [ $cmd = "post" -a -z "$2" ]; then
    error "no text specified"
  elif [ $cmd != "post" ]; then
    error "unrecognized command"
  fi
  return $?
}

verify_text() {
  local text="$2"
  if [ -z "$text" ]; then
    error "there's an easier way to be silent"
  elif [ $(echo -n "$text" |wc -c) -gt 140 ]; then
    error "too long a post"
  fi
  return $?
}

verify() {
  verify_command "$@" &&
    verify_text "$@"
  return $?
}
