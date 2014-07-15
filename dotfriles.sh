#!/bin/bash

function brew-install() {
    echo "Installing packages using Homebrew."
    echo "---------- -------- ----- --------"
    if [ -z $(which brew) ] then;
        echo "Homebrew is not installed. Installing..."
        if [ -x which curl] then;
            echo "Installing Homebrew with"
            if [ $(ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)") -eq 0 ] then;
                echo "Homebrew installed successfully."
            else echo "Homebrew install failed!"
                return 1
            fi
        else echo "Can't install Homebrew, no curl"
            return 1
    fi
    echo "Updating Homebrew. This could take a moment..."
    brew upgrade 1>&2
    if [ -z "$1" ] then;
        echo "Install command was called with no argument, installing git, zsh, wget, and vim"
        if [ $(brew install git vim zsh wget) -eq 0 ] then;
            echo "Homebrew installed git, zsh, and vim successfully"
        else echo "Homebrew install failed!"
            return 1
        fi
    else
        echo "Installing $1"
        if [ $(brew install $1) -eq 0 ] then;
            echo "Homebrew installed $1 successfully"
        else echo "Homebrew install failed!"
            return 1
        fi
    fi
}

function apt-install() {
    if [ -x ~/.dotfriles/dotfriles-with-sudo.sh ] then;
        if [ -z $1 ] then;
            echo "Will now install GIT, ZSH, and VIM with Aptitude."
            sudo ~/.dotfriles/dotfriles-with-sudo.sh 2> ~/.dotfriles/install-log.log
        else
            echo "Will now install $1 with Aptitude"
            sudo ~/.dotfriles/dotfriles-with-sudo.sh $1 2> ~/.dotfriles/install-log.log
        fi
        if [ $? -ne 0 ]; then
            echo "ERROR! Something went wrong!"
            echo "Logs are available in your ~/.dotfriles/ directory."
            echo "Aborting!"
            exit
        fi
    else
        echo ".... Downloading latest DotFriles-sudo script ...."
        wget "https://raw.githubusercontent.com/ArcticLight/dotfriles/master/dotfriles-with-sudo.sh" -O - 2> /dev/null > ~/.dotfriles/dotfriles-with-sudo.sh
        chmod +x ~/.dotfriles/dotfriles-with-sudo.sh

        echo
        if [ -z $1 ] then;
            echo "Got the installer. Will now install GIT, ZSH, and VIM."
            sudo ~/.dotfriles/dotfriles-with-sudo.sh 2> ~/.dotfriles/install-log.log
        else
            echo "Got the installer. Will now install $1"
            sudo ~/.dotfriles/dotfriles-with-sudo.sh $1 2> ~/.dotfriles/install-log.log
        fi
        if [ $? -ne 0 ]; then
            echo "ERROR! Something went wrong!"
            echo "Logs are available in your ~/.dotfriles/ directory."
            echo "Aborting!"
            exit
        fi
}

function install() {
    if [ $OSTYPE == "linux"* ] then; # we are on a Linux machine...
        apt-install $1               # ...use the sudo install script for apt
    elif [ $OSTYPE == "darwin"* ] then;     # we are on a Mac...
        brew-install $1                     # ...use the Homebrew install script
    else
        echo "OS type not supported."
        # TODO: Support other OS types
    fi
}

echo "========================="
echo " .: : : DotFriles : : :."
echo "========================="
if [ $OSTYPE == "linux"* ] then
    echo "Sudo check. Please validate with sudo so I can install packages later."
    echo "(if you don't trust this script with your SUDO, you should"
    echo "either read through the script, or find a different way to manage"
    echo "your dotfiles!)"
    sudo echo ""
fi

install() # Install git so that we can git things

read -p "GitHub clone URL for YOUR dotfriles config: " repo
echo ""
echo "-=-=-=-=-=-=-=-"
echo "DOUBLE CHECK THIS INFO:"
echo "git clone url: $repo"
echo "-=-=-=-=-=-=-=-"
read -p "If this is correct, press ENTER. Otherwise, press Control-C now!"

echo "Alright, Begin!"
echo ""

if [ -e ~/.dotfriles/ ]; then
    echo ".dotfriles directory was found in HOME, time to clobber!"
    rm -rf ~/.dotfriles/ > /dev/null
    if [ $? -ne 0 ]; then
        echo "Can't get rid of ~/.dotfriles, are you the owner?"
        echo "Abort!"
        exit
    fi
    echo "Killed ~/.dotfriles, ready to make new."
fi

mkdir -p ~/.dotfriles
cd ~/.dotfriles


git clone $repo ~/.dotfriles/config/ &> ~/.dotfriles/git-log.log
if [ $? -ne 0 ]; then
    echo "ERROR! Git had a problem!"
    echo "Logs are available in your ~/.dotfriles/ directory."
    echo "Aborting!"
    exit
fi

for file in `ls -a ~/.dotfriles/config/`; do
    case "$file" in
        .)
            echo "Ignoring ."
            ;;
        ..)
            echo "Ignoring .."
            ;;
        .git)
            echo "Ignoring .git"
            ;;
        LICENSE)
            echo "Ignoring LICENSE"
            ;;
        README.md)
            echo "Ignoring README.md"
            ;;
        .gitignore)
            echo "Ignoring .gitignore"
            ;;
        packages.txt)
            echo "Found packages.txt, installing packages."
            while read package; do
                install(package)
            done < $file
            ;;
        sublime-text-2 | Sublime\ Text\ 2)
            echo "Found configs for SublimeText 2"
            filename=`basename $file`
            if [ $OSTYPE == "linux"* ] then; # we are on a Linux machine...
                echo "Linking SublimeText 2 configs for Linux"
                ln -s ~/.dotfriles/config/$filename ~/.config/$sublime-text-2
            elif [ $OSTYPE == "darwin"* ] then;     # we are on a Mac...
                echo "Linking SublimeText 2 configs for Mac OS X"
                ln -s ~/.dotfriles/config/$filename ~/Library/Application Support/Sublime\ Text\ 2
            else
                echo "OS type not supported."
                # TODO: Support other OS types
            fi
            ;;
       sublime-text-3 | Sublime\ Text\ 3)
            echo "Found configs for SublimeText 3"
            filename=`basename $file`
            if [ $OSTYPE == "linux"* ] then; # we are on a Linux machine...
                echo "Linking SublimeText 3 configs for Linux"
                ln -s ~/.dotfriles/config/$filename ~/.config/$sublime-text-3
            elif [ $OSTYPE == "darwin"* ] then;     # we are on a Mac...
                echo "Linking SublimeText 3 configs for Mac OS X"
                ln -s ~/.dotfriles/config/$filename ~/Library/Application Support/Sublime\ Text\ 3
            else
                echo "OS type not supported."
                # TODO: Support other OS types
            fi
            ;;
        *)
            filename=`basename $file`
            echo "Linking $filename -> ~/$filename"
            if [ -e ~/$filename ]; then
                echo "File exists, removing first..."
                rm -rf ~/$filename
                if [ $? -ne 0 ]; then
                    echo "Error: Couldn't remove ~/$filename, didn't link."
                fi
            fi
            ln -s ~/.dotfriles/config/$filename ~/$filename
            ;;
    esac
done
