#!/bin/bash
echo "Updating APT indexes..."
apt-get update > ~/.dotfriles/apt-update-log.log
echo "Running apt-get upgrade (to bring you up to date)..."
echo "(THIS COULD TAKE A LONG TIME, PLEASE BE PATIENT)"
apt-get -y upgrade > ~/.dotfriles/apt-upgrade-log.log
echo "Now installing git, zsh, and vim..."
apt-get -y install git zsh vim > ~/.dotfriles/apt-install-log.log
echo "Done!"
