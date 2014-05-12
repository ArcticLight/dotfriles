dotfriles
=========

The idea is simple: Given a fresh installation of Ubuntu (or another Debian-like system), design a system which can take you from Zero to Zsh with a single command issued in a prompt.

## Project Goals:
- Simple: i.e. single command.
- Easy: Your dotfiles are kept in a single folder in the repo, which you can fiddle with to your heart's content. That folder's contents are then mirrored back to your HOME when you run from your fork of dotfriles
- Automated: You should be able to start up Dotfriles, go get a cup of coffee, and when you sit back down again your PC should have all your customizations how you like them.

##Setup:
Step 1: Make an empty dotfiles repo on Git, somewhere, it doesn't have to be GitHub but it can be.

Step 2: Copy your dotfiles from your first computer into that repo. Just the ones that you want to manage.

Step 3: Run dotfriles where you want those dotfiles to go. It's that easy!

##Usage:
just type `wget "https://raw.githubusercontent.com/ArcticLight/dotfriles/master/dotfriles.sh"`
to grab the script, run it,
and bam, you're ready to go!
