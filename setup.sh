#!/usr/bin/env bash -xe

if [[ "$(uname)" != "Darwin" ]]; then
  echo 'This setup only runs on OS X machines'
  exit 1
fi

mkdir -p ~/github
git clone git@github.com:dideler/setup-osx.git ~/github/setup-osx

pushd ~/github/setup-osx
  source osx-defaults
popd
