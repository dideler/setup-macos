#!/usr/bin/env bash -e

if [[ "$(uname)" != "Darwin" ]]; then
  echo 'This setup only runs on Mac machines'
  exit 1
fi

# Install Command Line Tools if not yet installed.
xcode-select -p 1>/dev/null || xcode-select --install

# Set up SSH key if none exists
if [[ ! -f ~/.ssh/id_rsa ]]; then
  ssh-keygen -t rsa -b 4096 -C "ideler.dennis@gmail.com"
  eval "$(ssh-agent -s)"
  ssh-add -K ~/.ssh/id_rsa
  pbcopy < ~/.ssh/id_rsa.pub
  open https://github.com/settings/keys
  read -p "Copied public SSH key. Add to GitHub then press Enter to continue..."
fi

mkdir -p ~/github.com

rm -rf ~/github.com/dideler/dotfiles
git clone git@github.com:dideler/dotfiles.git ~/github.com/dideler/dotfiles
pushd ~/github.com/dideler/dotfiles
  bash link_dotfiles -f
popd

rm -rf ~/github.com/dideler/setup-macos
git clone git@github.com:dideler/setup-macos.git ~/github.com/dideler/setup-macos
pushd ~/github.com/dideler/setup-macos
  settings/os-defaults &
  package-managers/homebrew
  package-managers/asdf
  languages/node &
  languages/ruby &
  languages/python3 &
  shells/fish &
popd

wait && echo "All done!"
