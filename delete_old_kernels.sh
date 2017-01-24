#!/bin/sh
# Borrowed from the user Malte Skoruppa on askubuntu.com (http://askubuntu.com/questions/401581/bash-one-liner-to-delete-only-old-kernels)
echo sudo dpkg -l linux-{image,headers}-* | awk '/^ii/{print $2}' | egrep '[0-9]+\.[0-9]+\.[0-9]+' | grep -v $(uname -r) | xargs sudo apt-get -y purge
