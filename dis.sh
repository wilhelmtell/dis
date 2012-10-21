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
  return 0
}

sup() {
  git log --pretty="%Cblue%an%Creset, %C(white)%ar%Creset%n%w(50,1,1)%B"
  return $?
}
