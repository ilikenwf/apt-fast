#!/bin/bash
sudo apt-get update
sudo apt-get install -y aria2
if ! [[ -f /usr/bin/apt-fast ]]; then
  sudo wget https://raw.githubusercontent.com/ilikenwf/apt-fast/master/apt-fast -O /usr/bin/apt-fast
  sudo chmod +x /usr/bin/apt-fast
  sudo wget https://raw.githubusercontent.com/ilikenwf/apt-fast/master/apt-fast.conf -O /etc/apt-fast.conf
fi
