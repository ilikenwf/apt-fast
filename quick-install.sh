#!/bin/bash
sudo apt-get install -y aria2
if ! [[ -f /usr/bin/apt-fast ]]; then
  sudo curl --compressed -sLo /usr/bin/apt-fast https://github.com/ilikenwf/apt-fast/raw/master/apt-fast
  sudo curl --compressed -sLo /etc/apt-fast.conf https://github.com/ilikenwf/apt-fast/raw/master/apt-fast.conf
  sudo chmod +x /usr/bin/apt-fast
fi
