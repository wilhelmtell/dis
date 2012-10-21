source $SCRIPT_DIRECTORY/error.sh

# the function arguments for each of the verify functions below takes as
# arguments the "$@" that came from the commandline

verify_text() {
  local text="$2"
  if [ $(echo -n "$text" |wc -c) -gt 140 ]; then
    error "too long a post text"
  fi
  return $?
}

verify_post_command() {
  local text="$2"
  if [ -n "$text" ]; then
    verify_text "$@"
  else
    error "no text specified"
  fi
  return $?
}

verify_help_command() {
  local extra_argument="$2"
  if [ -n "$2" ]; then
    error "unrecognized extra argument"
  fi
  return $?
}

verify_sup_command() {
  local extra_argument="$2"
  if [ -n "$2" ]; then
    error "unrecognized extra argument"
  fi
  return $?
}

verify_command() {
  local cmd="$1"
  if [ -z "$cmd" ]; then
    error "no command given"
  elif [ $cmd = "post" ]; then
    verify_post_command "$@"
  elif [ $cmd = "help" ]; then
    verify_help_command "$@"
  elif [ $cmd = "sup" ]; then
    verify_sup_command "$@"
  else
    error "unrecognized command"
  fi
  return $?
}

verify() {
  verify_command "$@"
  return $?
}
