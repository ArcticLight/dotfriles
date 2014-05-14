#!/bin/bash
function apt {
  # Max wrote this one. I haven't touched it yet
  # TODO: make it check if the apt install worked correctly.
  echo "Installing packages using APT."
  echo "---------- -------- ----- ---"
  echo "Updating APT indexes..."
  apt-get update 1>&2
  echo "Running apt-get upgrade (to bring you up to date)..."
  echo "(THIS COULD TAKE A LONG TIME, PLEASE BE PATIENT)"
  apt-get -y upgrade 1>&2
  echo "Now installing git, zsh, and vim..."
  apt-get -y install git zsh vim 1>&2
  echo "Done!"
}

function brew {
  echo "Installing packages using Homebrew."
  echo "---------- -------- ----- --------"
  if [ $(which brew) == "" ] then;
    echo "Homebrew is not installed. Installing..."
    if [ $(ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)") -eq 0 ] then;
      echo "Homebrew installed successfully."
    else echo "Homebrew install failed!"
    return 1
  fi
  echo "Updating Homebrew. This could take a moment..."
  brew upgrade 1>&2
  
}
