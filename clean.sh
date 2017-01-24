#!/bin/bash
echo "Cleaning packages..."
sudo apt-get clean
sudo apt-get autoclean
sudo apt-get autoremove

# This is experimental, do not use.
#echo "Removing old kernels..."
#echo $(dpkg --list | grep linux-image | awk '{ print $2 }' | sort -V | sed -n '/'`uname -r`'/q;p') $(dpkg --list | grep linux-headers | awk '{ print $2 }' | sort -V | sed -n '/'"$(uname -r | sed "s/\([0-9.-]*\)-\([^0-9]\+\)/\1/")"'/q;p') | xargs sudo apt-get -y purge

echo "Removing old crash reports..."
sudo rm /var/crash/*

