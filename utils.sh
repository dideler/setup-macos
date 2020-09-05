BOLD=$(tput bold)
RESET=$(tput sgr0)
BLACK=0 RED=1 GREEN=2 YELLOW=3 BLUE=4 MAGENTA=5 CYAN=6 WHITE=7
fg_color() { tput setaf "$1"; }
bg_color() { tput setab "$1"; }
print_bold() { echo -e "${BOLD}$(fg_color "$1")$(bg_color "$2")${*:3}${RESET}"; }

trap 'on_error $(basename $0) $LINENO' ERR

function log_info {
  echo -e "$(print_bold $GREEN $BLACK '[INFO]') $*"
}

function log_error {
  >&2 echo -e "$(print_bold $RED $YELLOW '[ERROR]') $*"
}

function on_error {
  log_error "$1 failed on line $2"
  if [[ $ERR_CONTEXT != "" ]]; then log_error "Context: $ERR_CONTEXT"; fi
}

function is_available {
  command -v "$1" >/dev/null
  return $?
}

function sudo_once {
  # Ask for password upfront.
  sudo -v

  # Repeatedly update cached credentials until script exits.
  while true; do sudo -v; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
}
