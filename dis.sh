post() {
  local text="$1"
  git commit --allow-empty --quiet --message "$text"
  return $?
}

help() {
  echo " usage: dis <command>"
  echo
  echo "available commands:"
  echo
  echo "help         display this help text"
  echo "post <text>  post text"
}
