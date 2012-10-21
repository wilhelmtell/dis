source $SCRIPT_DIRECTORY/error.sh

# the function arguments for each of the verify functions below takes as
# arguments the "$@" that came from the commandline

check_text_length() {
  local text="$1"
  [ $(echo -n "$text" |wc -c) -le 140 ]
  return $?
}

verify_post_command() {
  local text="$2"
  if [ -z "$text" ]; then
    error "no text specified"
  elif ! check_text_length "$text"; then
    error "too long a post text"
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

verify_init_command() {
  local name="$2"
  local about="$3"
  if [ -z "$name" ]; then
    error "no name specified"
  elif ! check_text_length "$about"; then
    error "too long an about text"
  fi
  return $?
}

verify_publish_command() {
  local text="$2"
  if ! check_text_length "$text"; then
    error "too long a post text to publish"
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
  elif [ $cmd = "init" ]; then
    verify_init_command "$@"
  elif [ $cmd = "publish" ]; then
    verify_publish_command "$@"
  else
    error "unrecognized command"
  fi
  return $?
}

verify_user() {
  local user="$(git config user.name)"
  if [ -z "$user" ]; then
    error "what's your name? try \"git config --global user.name 'Your Name'\""
  fi
  return $?
}

verify() {
  verify_user "$@" &&
    verify_command "$@"
  return $?
}
