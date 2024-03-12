#!/bin/bash

set -euo pipefail

LOCAL_BIN=$HOME/.local/bin
export PATH=$PATH:$LOCAL_BIN

mkdir -p "$LOCAL_BIN"

[ -d /usr/local/bin ] || sudo mkdir -p /usr/local/bin

which chezmoi >/dev/null 2>&1 || sudo sh -c "$(curl -fsLS get.chezmoi.io)" -- -b /usr/local/bin

if [ ! -d "$HOME/.local/share/chezmoi" ]; then
	chezmoi init --apply https://github.com/B3RR10/dotfiles.git --promptDefaults
else
	chezmoi init --promptDefaults
	chezmoi update --force
fi
