# Busybox utils

Set of something like coreutils but with busybox.

Motivation is that on Synology DSM there are no some utils like less. 
And the idea is the following: we can bring statically linked [busybox](https://manpages.ubuntu.com/manpages/noble/man1/busybox.1.html)
and call commands from it.

It can be used outside of Synology DSM of course. Any Linux is supported.

Supported CPU architectures:

  * arm64
  * x86_64

## Installation

```shell
mkdir ~/opt
cd ~/opt
git clone git@github.com:andre487/busybox-utils.git
~/opt/busybox-utils/dev/setup.sh
```

If you want you can do setup without setup.sh script:

```shell
echo 'export PATH="$PATH:/var/services/homes/<your username>/opt/busybox-utils"' >>~/.your-rc-file
```

## Provided utils

This repository provided these utils for Synology DSM:

  *  ar
  *  bzcat
  *  bzip2
  *  less
  *  lzcat
  *  lzma
  *  lzop
  *  mkpasswd
  *  nc
  *  start-stop-daemon
  *  unlzma
