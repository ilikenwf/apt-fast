#!/bin/sh
set -e

if [ -n "$EUID" ]; then userid="$EUID"; else userid="$(id -u)"; fi

run_cmd() {
  [ "$userid" -ne 0 ] && set -- sudo "$@"
  "$@"
}
apt_fast_url='https://raw.githubusercontent.com/ilikenwf/apt-fast/master'

if [ "$userid" -ne 0 ]; then
  type sudo >/dev/null 2>&1 || { echo "sudo not installed, change into root context" >&2; exit 1; }
fi

if ! type aria2c >/dev/null 2>&1; then
  run_cmd apt-get update
  run_cmd apt-get install -y aria2
fi

run_cmd wget "$apt_fast_url"/apt-fast -O /usr/local/sbin/apt-fast
run_cmd chmod +x /usr/local/sbin/apt-fast
if [ ! -f /etc/apt-fast.conf ]; then
  run_cmd wget "$apt_fast_url"/apt-fast.conf -O /etc/apt-fast.conf
fi
