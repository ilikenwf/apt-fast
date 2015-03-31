<!---
apt-fast v1.8
Use this just like aptitude or apt-get for faster package downloading.

Copyright: 2008-2012 Matt Parnell, http://www.mattparnell.com
Improvements, maintenance, revisions - 2012 Dominique Lasserre

You may distribute this file under the terms of the GNU General
Public License as published by the Free Software Foundation; either
version 3 of the License, or (at your option) any later version.
-->

apt-fast 1.8
============
apt-fast is a shellscript wrapper for apt-get and aptitude that can drastically improve apt download times by downloading packages in parallel, with multiple connections per package.

Setup/Install
-------------

#### Ubuntu 14.04 and later versions

```
sudo add-apt-repository ppa:saiarcot895/myppa
sudo apt-get update
sudo apt-get -y install apt-fast
```

#### Ubuntu 11.04~13.10 (out of date)

```
sudo add-apt-repository ppa:apt-fast/stable
sudo apt-get update
sudo apt-get -y install apt-fast
```

### Ubuntu PPA ###
You can use the Ubuntu PPA to get a graphical configuration file setup and automatic updates, for details see:

* [ppa:saiarcot895/myppa(for Ubuntu 14.04 and later versions)](https://launchpad.net/~saiarcot895/+archive/ubuntu/myppa)
* [ppa:apt-fast/stable(out of date, for Ubuntu 11.04~13.10)](https://code.launchpad.net/~apt-fast/+archive/stable)

Some distros, such as PCLinuxOS include apt-fast in their repos.

### Manual ###
A manual install can be performed as such:

    cp apt-fast /usr/bin/
    chmod +x /usr/bin/apt-fast
    cp apt-fast.conf /etc

You need to have [aria2c](http://aria2.sourceforge.net/) installed:

    apt-get install aria2

Then simply run apt-fast instead of apt-get or aptitude.

### Multiple mirrors ###
Adding multiple mirrors will further speed up downloads and distribute load, be sure to add mirrors near to your location.
Official mirror lists:

* Debian: http://www.debian.org/mirror/list
* Ubuntu: https://launchpad.net/ubuntu/+archivemirrors

Then add them to whitespace and comma separated list in config file, e.g.:

```
MIRRORS=( 'http://ftp.debian.org/debian, http://ftp2.de.debian.org/debian, http://ftp.de.debian.org/debian, ftp://ftp.uni-kl.de/debian' )
```

```
MIRRORS=( 'http://archive.ubuntu.com/ubuntu, http://de.archive.ubuntu.com/ubuntu, http://ftp.halifax.rwth-aachen.de/ubuntu, http://ftp.uni-kl.de/pub/linux/ubuntu, http://mirror.informatik.uni-mannheim.de/pub/linux/distributions/ubuntu/' )
```

*NOTE:* To use any mirrors you may have in sources.list or sources.list.d you will need to add them to the apt-fast.conf mirror list.

### Autocompletion ###
#### Bash ####
    cp completions/bash/apt-fast /etc/bash_completion.d/
    chown root:root /etc/bash_completion.d/apt-fast
    . /etc/bash_completion

#### Zsh ####
    cp completions/zsh/_apt-fast /usr/share/zsh/functions/Completion/Debian/
    chown root:root /usr/share/zsh/functions/Completion/Debian/_apt-fast
    source /usr/share/zsh/functions/Completion/Debian/_apt-fast

### Man page installation ###
    cp ./man/apt-fast.8 /usr/share/man/man8
    gzip -f9 /usr/share/man/man8/apt-fast.8
    cp ./man/apt-fast.conf.5 /usr/share/man/man5
    gzip -f9 /usr/share/man/man5/apt-fast.conf.5

License
-------
Consider apt-fast and all of its derivatives licensed under the GNU GPLv3+.

Copyright: 2008-2012 Matt Parnell, http://www.mattparnell.com
Improvements, maintenance, revisions - 2012 Dominique Lasserre


Special thanks
--------------
 * Travis/travisn000 - support for complex apt-get commands
 * [Alan Hoffmeister](https://github.com/alanhoff) - aria2c support
 * Abhishek Sharma - aria2c with proxy support
 * Luca Marchetti - improvements on the locking system and downloader execution
 * Richard Klien - Autocompletion, Download Size Checking (made for on ubuntu, untested on other distros)
 * Patrick Kramer Ruiz - suggestions
 * Sergio Silva - test to see if axel is installed, root detection/sudo autorun, lock file check/creation
 * Waldemar {BOB}{Burnfaker} Wetzel - lockfile improvements, separate config file
 * maclarke - locking improvements
