<!---
apt-fast v1.9
Use this just like aptitude or apt-get for faster package downloading.

Copyright: 2008-2012 Matt Parnell, http://www.mattparnell.com
Improvements, maintenance, revisions - 2012, 2017-2019 Dominique Lasserre

You may distribute this file under the terms of the GNU General
Public License as published by the Free Software Foundation; either
version 3 of the License, or (at your option) any later version.
-->

apt-fast 1.9
============
apt-fast is a shellscript wrapper for apt-get and aptitude that can drastically improve apt download times by downloading packages in parallel, with multiple connections per package.

## Table of Contents

- [Installation](#installation)
  - [Ubuntu PPA](#ubuntu-ppa)
  - [Debian and derivates](#debian-and-derivates)
  - [Interaction-free installation](#interaction-free-installation)
  - [Quick install](#quick-install)
  - [Manual](#manual)
  - [Autocompletion](#autocompletion)
    - [Bash](#bash)
    - [Zsh](#zsh)
    - [Fish](#fish)
  - [Man page installation](#man-page-installation)
- [Configuration](#configuration)
  - [Package manager](#package-manager)
  - [Confirmation dialog](#confirmation-dialog)
  - [Multiple mirrors](#multiple-mirrors)
  - [Maximum connections](#maximum-connections)
  - [Maximum connections per server](#maximum-connections-per-server)
  - [Maximum connections per file](#maximum-connections-per-file)
  - [File split size](#file-split-size)
  - [Piece selection algorithm](#piece-selection-algorithm)
  - [Downloadmanager file](#downloadmanager-file)
  - [Downloadmanager command](#downloadmanager-command)
    - [Proxy](#proxy)
  - [Download folder](#download-folder)
  - [APT archives cache](#apt-archives-cache)
  - [Verbose output](#verbose-output)
  - [Colors](#colors)
- [License](#license)
- [Special thanks](#special-thanks)

Installation
------------

```sh
sudo add-apt-repository ppa:apt-fast/stable
sudo apt-get update
sudo apt-get -y install apt-fast
```

### Ubuntu PPA ###
You can use the Ubuntu PPA to get a graphical configuration file setup and automatic updates, for details see:

* [ppa:apt-fast/stable](https://code.launchpad.net/~apt-fast/+archive/stable)


### Debian and derivates ###
Some distros, such as PCLinuxOS include apt-fast in their repositories. However if not included like in Debian or Kali Linux, then the PPA can be manually added by creating a new file `/etc/apt/sources.list.d/apt-fast.list`:

```
deb http://ppa.launchpad.net/apt-fast/stable/ubuntu bionic main 
deb-src http://ppa.launchpad.net/apt-fast/stable/ubuntu bionic main
```

To install apt-fast execute following commands as root:
```bash
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A2166B8DE8BDC3367D1901C11EE2FF37CA8DA16B
apt-get update
apt-get install apt-fast
```

Note that the PPA version ``bionic`` might need to be updated with the recent Ubuntu LTS codename to stay up-to-date.


### Interaction-free installation ###
To install apt-fast without interaction execute the following commands as root after adding the package sources to the sources.list:

```bash
DEBIAN_FRONTEND=noninteractive apt-get install -y apt-fast
```

To update specific configuration values use the debconf command line interface as root, e.g.:

```bash
echo debconf apt-fast/maxdownloads string 16 | debconf-set-selections
echo debconf apt-fast/dlflag boolean true | debconf-set-selections
echo debconf apt-fast/aptmanager string apt-get | debconf-set-selections
```


### Quick install ###
You can quickly install `apt-fast` by running:

```bash
/bin/bash -c "$(curl -sL https://git.io/vokNn)"
```

### Manual ###
A manual install can be performed as such:

```sh
cp apt-fast /usr/local/sbin/
chmod +x /usr/local/sbin/apt-fast
cp apt-fast.conf /etc
```

You need to have [aria2c](http://aria2.sourceforge.net/) installed:

```sh
apt-get install aria2
```

Then simply run apt-fast instead of apt-get or aptitude.


### Autocompletion ###
#### Bash ####

```sh
cp completions/bash/apt-fast /etc/bash_completion.d/
chown root:root /etc/bash_completion.d/apt-fast
. /etc/bash_completion
```

#### Zsh ####

```sh
cp completions/zsh/_apt-fast /usr/share/zsh/functions/Completion/Debian/
chown root:root /usr/share/zsh/functions/Completion/Debian/_apt-fast
source /usr/share/zsh/functions/Completion/Debian/_apt-fast
```

#### Fish ####

```fish
cp completions/fish/apt-fast.fish /etc/fish/conf.d/completions/
chown root:root /etc/fish/conf.d/completions/apt-fast.fish
source /etc/fish/conf.d/completions/apt-fast.fish
```

### Man page installation ###

```sh
mkdir -p /usr/local/share/man/man8/
cp ./man/apt-fast.8 /usr/local/share/man/man8
gzip -f9 /usr/local/share/man/man8/apt-fast.8
mkdir -p /usr/local/share/man/man5/
cp ./man/apt-fast.conf.5 /usr/local/share/man/man5
gzip -f9 /usr/local/share/man/man5/apt-fast.conf.5
```

Configuration
-------------
The apt-fast configuration file is located at: `/etc/apt-fast.conf`


### Package manager ###
```sh
_APTMGR=apt-get
```
Change package manager used for installation. Supported are apt-get, aptitude, apt.


### Confirmation dialog ###
```sh
DOWNLOADBEFORE=true
```
To suppress apt-fast confirmation dialog and download packages directly set this to any value. To ask for confirmation, leave empty. This options doesn't affect package manager confirmation.


### Multiple mirrors ###
Adding multiple mirrors will further speed up downloads and distribute load, be sure to add mirrors near to your location.
Official mirror lists:

* Debian: http://www.debian.org/mirror/list
* Ubuntu: https://launchpad.net/ubuntu/+archivemirrors

Then add them to whitespace and comma separated list in config file, e.g.:

```sh
MIRRORS=( 'http://deb.debian.org/debian','http://ftp.debian.org/debian, http://ftp2.de.debian.org/debian, http://ftp.de.debian.org/debian, ftp://ftp.uni-kl.de/debian' )
```

```sh
MIRRORS=( 'http://archive.ubuntu.com/ubuntu, http://de.archive.ubuntu.com/ubuntu, http://ftp.halifax.rwth-aachen.de/ubuntu, http://ftp.uni-kl.de/pub/linux/ubuntu, http://mirror.informatik.uni-mannheim.de/pub/linux/distributions/ubuntu/' )
```

*NOTE:* To use any mirrors you may have in sources.list or sources.list.d you will need to add them to the apt-fast.conf mirror list as well!


### Maximum connections ###
```sh
_MAXNUM=5
```
Set to maximum number of connections aria2c uses.


### Maximum connections per server ###
```sh
_MAXCONPERSRV=10
```
Set to maximum number of connections per server aria2c uses.


### Maximum connections per file ###
```sh
_SPLITCON=8
```
Set to maximum number of connections per file aria2c uses.


### File split size ###
```sh
_MINSPLITSZ=1M
```
Set to size of each split piece. Possible values: 1M-1024M


### Piece selection algorithm ###
```sh
_PIECEALGO=default
```
Set to piece selection algorithm to use. Possible values: default, inorder, geom


### Downloadmanager file ###
```sh
DLLIST='/tmp/apt-fast.list'
```
Location of aria2c input file, used to download the packages with options and checksums.


### Downloadmanager command ###
```sh
_DOWNLOADER='aria2c --no-conf -c -j ${_MAXNUM} -x ${_MAXCONPERSRV} -s ${_SPLITCON} -i ${DLLIST} --min-split-size=${_MINSPLITSZ} --stream-piece-selector=${_PIECEALGO} --connect-timeout=600 --timeout=600 -m0'
```
Change the download manager or add additional options to aria2c.

#### Proxy ####
apt-fast uses APT's proxy settings (`Acquire::http::proxy`, `Acquire::https::proxy`, `Acquire::ftp::proxy`) and if those are not available, the environment settings (`http_proxy`, `https_proxy`, `ftp_proxy`). Refer to APT's or the system's documentation.


### Download folder ###
```sh
DLDIR='/var/cache/apt/apt-fast'
```
Directory where apt-fast (temporarily) downloads the packages.


### APT archives cache ###
```sh
APTCACHE='/var/cache/apt/archives'
```
Directory where apt-get and aptitude download packages.


### Verbose output ###
```sh
VERBOSE_OUTPUT=y
```
Show aria2 download file instead of package listing before download confirmation. Unset to show package listing.


### Colors ###
```sh
cGreen='\e[0;32m'
cRed='\e[0;31m'
cBlue='\e[0;34m'
endColor='\e[0m' 
```
Terminal colors used for dialogs. Refer to [ANSI Escape sequences](http://ascii-table.com/ansi-escape-sequences.php) for a list of possible values. Disabled when not using terminal.


License
-------
Consider apt-fast and all of its derivatives licensed under the GNU GPLv3+.

Copyright: 2008-2012 Matt Parnell, http://www.mattparnell.com

Improvements, maintenance, revisions - 2012, 2017-2019 Dominique Lasserre


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
