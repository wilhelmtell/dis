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
  echo "help                 display this help text"
  echo "init <name> [about]  initialize a dis account"
  echo "post <text>          post text"
  echo "publish [text]       publish posted texts"
  echo "wut                  read text snippets"
  return 0
}

wut() {
  git log --pretty="%Cblue%an%Creset, %C(white)%ar%Creset%n%w(50,1,1)%B"
  return $?
}

init() {
  local name="$1"
  local user="$(git config user.name)"
  local about="$2"
  git init --quiet "$name" &&
    echo -n "$about" >"$name"/ABOUT &&
    cd "$name" &&
    git add ABOUT &&
    git commit --quiet --message "$user joined dis"
  return $?
}

publish() {
  local text="$1"
  if [ -n "$text" ]; then
    post "$text"
  fi &&
    git push --quiet
  return $?
}
