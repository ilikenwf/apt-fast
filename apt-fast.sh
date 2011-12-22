#!/bin/sh
#apt-fast by Matt Parnell http://www.mattparnell.com
# Use this just like apt-get for faster package downloading. Make sure to have axel installed

#If the first user entered variable string contains apt-get, and the second string entered is either install or dist-upgrade
if echo "$1" | grep -q "[upgrade]" || echo "$2" | grep -q "[install]" || echo "$2" | grep -q "[dist-upgrade]"; then
  echo "Working...";
  #Go into the directory apt-get normally puts downloaded packages
  cd /var/cache/apt/archives/;
  #Have apt-get print the information, including the URI's to the packages
  apt-get -y --print-uris $1 $2 $3 $4 > debs.list;
  #Strip out the URI's, and download the packages with Axel for speediness
  egrep -o -e "(ht|f)tp://[^\']+" debs.list | xargs -l1 axel -a;
  #Perform the user's reqested action via apt-get 
  apt-get -y $1 $2 $3 $4;

  echo "Done! Make sure and check to see that the packages all were installed properly. If a package is erred, run sudo apt-get autoclean and try installing it again without the use of this script.";

elif echo "$1" | grep -q "[*]"; then
  apt-get $1;
else
  echo "Sorry, but you appear to be entering invalid options. You must use apt-get and one of apt-get's options in order to use this script.";
fi


