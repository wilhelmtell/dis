post() {
  local text="$1"
  git commit --allow-empty -m"$text"
  return $?
}
