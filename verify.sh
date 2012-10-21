source $SCRIPT_DIRECTORY/error.sh

verify_post_command() {
  local text="$2"
  if [ -z "$text" ]; then
    error "no text specified"
  fi
  return $?
}

verify_command() {
  local cmd="$1"
  if [ -z "$cmd" ]; then
    error "no command given"
  elif [ $cmd = "post" ]; then
    verify_post_command "$@"
  else
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
