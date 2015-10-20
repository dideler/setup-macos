#!/usr/bin/env bash -xe

mkdir -p ~/github
git clone git@github.com:dideler/setup-osx.git ~/github/setup-osx

pushd ~/github/setup-osx
  source osx-defaults
popd
