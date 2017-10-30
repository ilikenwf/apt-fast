#!/bin/bash
sudo apt-get update
sudo apt-get install -y aria2
if ! [[ -f /usr/local/sbin/apt-fast ]]; then
  sudo wget https://raw.githubusercontent.com/ilikenwf/apt-fast/master/apt-fast -O /usr/local/sbin/apt-fast
  sudo chmod +x /usr/local/sbin/apt-fast
  sudo wget https://raw.githubusercontent.com/ilikenwf/apt-fast/master/apt-fast.conf -O /etc/apt-fast.conf
fi
