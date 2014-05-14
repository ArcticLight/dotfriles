#!/bin/bash
echo "========================="
echo " .: : : DotFriles : : :."
echo "========================="
echo "Sudo check. Please validate with sudo so I can install packages later."
echo "(if you don't trust this script with your SUDO, you should"
echo "either read through the script, or find a different way to manage"
echo "your dotfiles!)"
sudo echo ""
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


echo ".... Downloading latest DotFriles-sudo script ...."
mkdir -p ~/.dotfriles
cd ~/.dotfriles
wget "https://raw.githubusercontent.com/hawkw/dotfriles/master/dotfriles-with-sudo.sh" -O - 2> /dev/null > ~/.dotfriles/dotfriles-with-sudo.sh
chmod +x ~/.dotfriles/dotfriles-with-sudo.sh

echo
echo "Got the installer. Will now install GIT, ZSH, and VIM."
sudo ~/.dotfriles/dotfriles-with-sudo.sh 2> ~/.dotfriles/install-log.log
if [ $? -ne 0 ]; then
    echo "ERROR! Something went wrong!"
    echo "Logs are available in your ~/.dotfriles/ directory."
    echo "Aborting!"
    exit
fi

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
