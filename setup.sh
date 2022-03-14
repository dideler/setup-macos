#!/usr/bin/env bash -e

if [[ "$(uname)" != "Darwin" ]]; then
  echo 'This setup only runs on Mac machines'
  exit 1
fi

for shellrc in ~/.bash_profile ~/.bashrc ~/.zshrc; do
  touch "${shellrc}"
done

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

# Verify host key to prevent MITM attack
echo "== GitHub's SSH key fingerprints (compare when connecting to host) =="
curl -sSL https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/githubs-ssh-key-fingerprints | grep --only-matching "<li><code>SHA256.*</li>" | sed 's/<[^>]*>//g'
ssh -T git@github.com

mkdir -p ~/github.com

rm -rf ~/github.com/dideler/dotfiles
git clone git@github.com:dideler/dotfiles.git ~/github.com/dideler/dotfiles
pushd ~/github.com/dideler/dotfiles
  bash link_dotfiles -f
popd

rm -rf ~/github.com/dideler/setup-macos
git clone git@github.com:dideler/setup-macos.git ~/github.com/dideler/setup-macos
pushd ~/github.com/dideler/setup-macos
  source utils.sh && sudo_once "Password required for certain installs..."
  bash settings/sudo-touch
  bash settings/os-defaults
  bash package-managers/softwareupdate
  bash package-managers/homebrew
  bash package-managers/asdf
  bash languages/node
  bash languages/ruby
  bash languages/python
  bash languages/elixir
  bash languages/go
  bash shells/fish
popd

echo "All done!"
