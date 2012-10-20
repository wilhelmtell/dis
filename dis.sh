#!/bin/bash

verify_command() {
  local cmd="$1"
  [ -z "$cmd" ] && echo "empty command" && return 1
  [ $cmd != "post" ] && {
    echo "unrecognized command" && return 1
  }
  return 0
}

verify_text() {
  local text="$1"
  [ -z "$text" ] && echo "there's an easier way to be silent" && return 1
  [ $(echo -n "$text" |wc -c) -gt 140 ] && echo "too long a post" && return 1
  return 0
}

verify_argument_count() {
  [ $# -ne 2 ] && echo "command or text not given" && return 1
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
  local timestamp="$(date)"
  local user="$(git config user.name) <$(git config user.email)>"
  local transmission="$(echo -en "$timestamp, $user\n\n$text")"
  git commit --allow-empty -m"$transmission"
  return $?
}

verify "$@" || exit 1
$1 "$@"
