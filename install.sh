#!/usr/bin/env bash

set -e

if [ ! -d /nix ]; then
  curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
fi

source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh

LINE="substituters = https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store https://cache.nixos.org/"
grep -xqF "$LINE" /etc/nix/nix.conf || echo "$LINE" | sudo tee -a /etc/nix/nix.conf
LINE="trusted-users = hjw"
grep -xqF "$LINE" /etc/nix/nix.conf || echo "$LINE" | sudo tee -a /etc/nix/nix.conf

sudo systemctl restart nix-daemon

if [ ! -d $HOME/.config/home-manager ]; then
  git clone https://github.com/kconf/nix-config.git $HOME/.config/home-manager
fi

nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install

home-manager switch
