post() {
  local text="$1"
  git commit --allow-empty --quiet --message "$text"
  return $?
}
