source $SCRIPT_DIRECTORY/error.sh

# the function arguments for each of the verify functions below takes as
# arguments the "$@" that came from the commandline

length() {
  local text="$1"
  echo -n "$text" |wc -c
  return 0
}

check_text_length() {
  local text_length="$1"
  [ $text_length -le 140 ]
  return $?
}

verify_post_command() {
  local text="$2"
  local text_length=$(length "$text")
  if ! check_text_length $text_length; then
    error "$text_length characters; too long a post text"
  fi
  return $?
}

verify_help_command() {
  local extra_argument="$2"
  if [ -n "$2" ]; then
    error "help command takes no other arguments"
  fi
  return $?
}

verify_wut_command() {
  local extra_argument="$2"
  if [ -n "$2" ]; then
    error "wut command takes no other agruments"
  fi
  return $?
}

verify_init_command() {
  local name="$2"
  local about="$3"
  local about_length=$(length "$about")
  if [ -z "$name" ]; then
    error "no name specified"
  elif ! check_text_length "$about_length"; then
    error "$about_length characters; too long an about text"
  fi
  return $?
}

verify_publish_command() {
  local text="$2"
  local text_length=$(length "$text")
  if ! check_text_length "$text_length"; then
    error "$text_length characters; too long a post text to publish"
  fi
  return $?
}

verify_fetch_command() {
  shift
  local users="$@"
  for user in $users; do
    git remote |grep "^$user$" >/dev/null || {
      error "unknown user $user. did you forget to track it first?"
      return 1
    }
  done
  return $?
}

verify_track_command() {
  local user="$2"
  local server="$3"
  if [ -z "$user" ]; then
    error "no user specified to track"
  elif [ -z "$server" ]; then
    error "no server specified to track"
  fi
  return $?
}

verify_command() {
  local cmd="$1"
  if [ -z "$cmd" ]; then error "no command given"
  elif [ $cmd = "post" ]; then verify_post_command "$@"
  elif [ $cmd = "help" ]; then verify_help_command "$@"
  elif [ $cmd = "wut" ]; then verify_wut_command "$@"
  elif [ $cmd = "init" ]; then verify_init_command "$@"
  elif [ $cmd = "fetch" ]; then verify_fetch_command "$@"
  elif [ $cmd = "track" ]; then verify_track_command "$@"
  elif [ $cmd = "publish" ]; then verify_publish_command "$@"
  else error "unrecognized command, \"$cmd\""
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
