#!/bin/bash

verify() {
  local text="$1"
  [ -z "$text" ] && echo "there's an easier way to be silent" && exit 1
  [ $(echo -n "$text" |wc -c) -gt 140 ] && echo "too long a post" && exit 1
}

post() {
  local text="$1"
  local timestamp="$(date)"
  local user="$(git config user.name) <$(git config user.email)>"
  local transmission="$(echo -en "$timestamp, $user\n\n$text")"
  git commit --allow-empty -m"$transmission"
}

verify "$@" || exit 1
post "$@"
