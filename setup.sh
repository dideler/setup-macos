#!/usr/bin/env bash -xe

if [[ "$(uname)" != "Darwin" ]]; then
  echo 'This setup only runs on OS X machines'
  exit 1
fi

xcode-select -p 1>/dev/null || xcode-select --install # Install Command Line Tools if not yet installed.

mkdir -p ~/github

# Cloning with HTTPS to avoid SSH setup. You may want to change the remote URL to SSH later.
git clone https://github.com/dideler/dotfiles.git ~/github/dideler/dotfiles
pushd ~/github/dideler/dotfiles
  bash link_dotfiles -f
popd

git clone https://github.com/dideler/setup-osx.git ~/github/dideler/setup-osx
pushd ~/github/dideler/setup-osx
  # TODO: Some of these can probably run in parallel. And maybe use nohup?
  bash settings/osx-defaults \
  && bash package-managers/homebrew \
  && bash package-managers/npm \
  && bash package-managers/gems \
  && bash languages/ruby \
  && bash languages/node \
  && bash shells/fish
popd
