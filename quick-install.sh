#!/bin/bash
sudo apt-get install -y aria2 git
if ! [[ -f /usr/bin/apt-fast ]]; then
  git clone https://github.com/changbiao/apt-fast /tmp/apt-fast
  sudo cp /tmp/apt-fast/apt-fast /usr/bin
  sudo chmod +x /usr/bin/apt-fast
  sudo cp /tmp/apt-fast/apt-fast.conf /etc
fi
