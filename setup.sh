#!/usr/bin/env bash -xe

if [[ "$(uname)" != "Darwin" ]]; then
  echo 'This setup only runs on OS X machines'
  exit 1
fi

xcode-select --install # Command Line Tools

mkdir -p ~/github
git clone git@github.com:dideler/setup-osx.git ~/github/setup-osx

pushd ~/github/setup-osx
  # TODO: Some of these can probably run parallel in child processes.
  source settings/osx-defaults
  source package-managers/homebrew
  source languages/ruby
  source package-managers/npm
  source package-managers/gems
  # TODO: Consider creating directories like homebrew/, ruby/, node/ instead
popd
