# !/bin/sh
# apt-fast v0.03 by Matt Parnell http://www.mattparnell.com, GNU GPLv3
# Use this just like apt-get for faster package downloading.

###################################################################
# CONFIGURATION OPTIONS                                           #
###################################################################

# Download manager selection (choose one by uncommenting one 
# #_DOWNLOADER line

# aria2c:
#_DOWNLOADER='aria2c -c -j5 --input-file=/tmp/apt-fast.list --connect-timeout=600 --timeout=600 -m0'

# aria2c with a proxy (set username, proxy, ip and password!)
#_DOWNLOADER='aria2c -s 20 -j 10 --http-proxy=http://username:password@proxy_ip:proxy_port -i apt-fast.list'

# axel:
_DOWNLOADER='cat /tmp/apt-fast.list|xargs -l1 axel -a' # axel

###################################################################
# DO NOT EDIT BELOW THIS LINE UNLESS YOU KNOW WHAT YOU ARE DOING! #
###################################################################

# Check for proper priveliges
[ "`whoami`" = root ] || exec sudo "$0" "$@"

# Define our lock location
LCK_FILE=/var/lock/apt-fast.lck

if [ -f "${LCK_FILE}" ]; then
	echo "Either you stopped apt-fast in the middle of work or it's already running."
	echo "If you think apt-fast isn't running, you may delete /var/lock/apt-fast.lck and try again."
	exit 100
else
	touch $LCK_FILE
fi

# Make sure one of the download managers is enabled
[ -z "$_DOWNLOADER" ] && echo "You must configure apt-fast to use axel or aria2c" && exit 1;

# If the user entered arguments contain upgrade, install, or dist-upgrade
if echo "$@" | grep -q "upgrade\|install\|dist-upgrade"; then
  echo "Working...";

  # Go into the directory apt-get normally puts downloaded packages
  cd /var/cache/apt/archives/;

  # Have apt-get print the information, including the URI's to the packages
  # Strip out the URI's, and download the packages with Axel for speediness
  # I found this regex elsewhere, showing how to manually strip package URI's you may need...thanks to whoever wrote it
  apt-get -y --print-uris $@ | egrep -o -e "(ht|f)tp://[^\']+" > /tmp/apt-fast.list
  exec $_DOWNLOADER  

  # Install our downloaded packages
  apt-get $@;

  echo -e "\nDone! Verify that all packages were installed successfully. If errors are found, run apt-get clean as root and try again using apt-get directly.\n";

else
   apt-get $@;
fi

# Remove our lock

rm $LCK_FILE
