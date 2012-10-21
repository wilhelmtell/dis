post() {
  local text="$1"
  git commit --allow-empty --quiet -m"$text"
  return $?
}
