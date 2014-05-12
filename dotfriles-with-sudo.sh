#!/bin/bash
echo "Updating APT indexes..."
apt-get update 1> /dev/null
echo "Running apt-get upgrade (to bring you up to date)..."
apt-get -y upgrade 1> /dev/null
echo "Now installing git, zsh, and vim..."
apt-get -y install git zsh vim 1> /dev/null
echo "Done!"
