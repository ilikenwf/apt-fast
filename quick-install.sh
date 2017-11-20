#!/bin/bash
set -e

apt_fast_installation() {
  if ! dpkg-query --show aria2 >/dev/null 2>&1; then
    sudo apt-get update
    sudo apt-get install -y aria2
  fi

  wget https://raw.githubusercontent.com/ilikenwf/apt-fast/master/apt-fast -O /usr/local/sbin/apt-fast
  chmod +x /usr/local/sbin/apt-fast
  if ! [[ -f /etc/apt-fast.conf ]]; then
    wget https://raw.githubusercontent.com/ilikenwf/apt-fast/master/apt-fast.conf -O /etc/apt-fast.conf
  fi
}


if [[ "$EUID" -eq 0 ]]; then
  apt_fast_installation
else
  type sudo >/dev/null 2>&1 || { echo "sudo not installed, change into root context" >&2; exit 1; }

  DECL="$(declare -f apt_fast_installation)"
  sudo bash -c "$DECL; apt_fast_installation"
fi
