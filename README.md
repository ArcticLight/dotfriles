dotfriles
=========

The idea is simple: Given a fresh installation of Ubuntu (or another Debian-like system) or Mac OS X, design a system which can take you from Zero to Zsh with a single command issued in a prompt.

This is a fork of @ArcticLight's dotfriles. The fork contains some additional features I've added for my own personal use, such as checking the OS and copying SublimeText 3 configs into the correct location based on OS. It may or may not work for your setup.

Additional features:
 - Copies SublimeText configurations into the Correct Place depending on whether you're on Linux or OS X
 - Installs all packages in ~/.dotfriles/packages.txt, using Homebrew on OS X and Aptitude on Linux
 - Checks the OS in support of the previous two functions.

### Project Goals:
- Simple: i.e. single command.
- Easy: Your dotfiles are kept in a single folder in the repo, which you can fiddle with to your heart's content. That folder's contents are then mirrored back to your HOME when you run from your fork of dotfriles
- Automated: You should be able to start up Dotfriles, go get a cup of coffee, and when you sit back down again your PC should have all your customizations how you like them.

### Setup:
 1. Make an empty dotfiles repo on Git, somewhere, it doesn't have to be GitHub but it can be.
 2. Copy your dotfiles from your first computer into that repo. Just the ones that you want to manage.
   3. (OPTIONAL) If you want Dotfriles to automatically install packages on your system, create a file called packages.txt in the repo and add a list of desired packages, one per line.
 4. Run dotfriles where you want those dotfiles to go. It's that easy!

### Usage:
just type `wget "https://raw.githubusercontent.com/ArcticLight/dotfriles/master/dotfriles.sh"`
to grab the script, run it,
and bam, you're ready to go!
