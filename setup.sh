#!/usr/bin/env bash -xe

if [[ "$(uname)" != "Darwin" ]]; then
  echo 'This setup only runs on OS X machines'
  exit 1
fi

# Install Command Line Tools if not yet installed.
xcode-select -p 1>/dev/null || xcode-select --install

# Set up SSH key if none exists
if [[ ! -f ~/.ssh/id_rsa ]]; then
  ssh-keygen -t rsa -b 4096 -C "ideler.dennis@gmail.com"
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/id_rsa
  pbcopy < ~/.ssh/id_rsa.pub
  read -p "Add copied SSH key to https://github.com/settings/keys then press Enter to continue..."
fi

mkdir -p ~/github

rm -rf ~/github/dideler/dotfiles
git clone https://github.com/dideler/dotfiles.git ~/github/dideler/dotfiles # HTTPS clone avoids SSH setup.
pushd ~/github/dideler/dotfiles
  bash link_dotfiles -f
popd

rm -rf ~/github/dideler/setup-macos
git clone git@github.com:dideler/setup-macos.git ~/github/dideler/setup-macos
pushd ~/github/dideler/setup-macos
  # TODO: Some of these can probably run in parallel. And maybe use nohup?
  bash settings/os-defaults \
  && bash package-managers/homebrew \
  && bash package-managers/npm \
  && bash languages/node \
  && bash languages/ruby \
  && bash package-managers/gems \
  && bash languages/python3 \
  && bash shells/fish
popd
