function is_available() {
  command -v "$1" >/dev/null
  return $?
}
