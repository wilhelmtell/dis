post() {
  local text="$1"
  if [ -n "$text" ]; then
    git commit --allow-empty --quiet --message "$text"
  else
    git commit --allow-empty --quiet --edit
  fi
  return $?
}

help() {
  echo " usage: dis <command>"
  echo
  echo "available commands:"
  echo
  echo "help"
  echo "init <name> [about]  initialize a dis account"
  echo "post [text]"
  echo "publish [text]       post text if given; then publish all texts"
  echo "wut                  read text snippets"
  echo "fetch [user [...]]   fetch new text snippets"
  echo "track <user> <at>    track a user"
  echo "about <user>         show biography of a user"
  echo "hi <text>            change biography text"
  return 0
}

hi() {
  local biography="$1"
  local name="$(git config user.name)"
  echo -n "$biography" >ABOUT &&
    git add ABOUT &&
    git commit --quiet --message "$name updated the biography text."
  return $?
}

about() {
  local user="$1"
  git --no-pager show "$user"/master:ABOUT
}

track() {
  local user="$1"
  local server="$2"
  git remote add "$user" "$server"
}

wut() {
  local format="%Cblue%ae%Creset, %C(white)%ar%Creset%n%w(50,1,1)%B"
  git log --pretty="$format" HEAD --remotes
  return $?
}

fetch() {
  local users="$@"
  [ -z "$users" ] && git fetch --quiet --all
  for user in $users; do
    git fetch --force --quiet "$user"
  done
}

setup_repository() {
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

setup_commit_handler() {
  local name="$1"
  cp .git/hooks/commit-msg{.sample,}
  cat <<EOF>.git/hooks/commit-msg
length=\$((\$(sed '/^#/ d' <"\$1" |wc -c) - 1))
[ \$length -le 140 ] || {
  echo "\$length characters; too long a post text." >&2
  exit 1
}
EOF
  return $?
}

init() {
  setup_repository "$@" &&
    setup_commit_handler "$@"
}

publish() {
  local text="$1"
  if [ -n "$text" ]; then
    post "$text"
  fi &&
    git push --quiet
  return $?
}
