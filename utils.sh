BOLD=$(tput bold)
NORMAL=$(tput sgr0)
BLACK=0 RED=1 GREEN=2 YELLOW=3 BLUE=4 MAGENTA=5 CYAN=6 WHITE=7
font_colour() { tput setaf "$1"; }
colour_print() { echo -e "${BOLD}$(font_colour "$1")${*:2}${NORMAL}"; }

trap 'on_error $(basename $0) $LINENO' ERR

function log_info {
  echo -e "$(colour_print $GREEN '[INFO]') $*"
}

function log_error {
  >&2 echo -e "$(colour_print $RED '[ERROR]') $*"
}

function on_error {
  log_error "$1 failed on line $2"
  if [[ $ERR_CONTEXT != "" ]]; then log_error "Context: $ERR_CONTEXT"; fi
}

function is_available() {
  command -v "$1" >/dev/null
  return $?
}
