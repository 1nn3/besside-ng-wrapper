#!/usr/bin/env sh

set -x
set -e

apt-get install curl macchanger aircrack-ng daemonize ieee-data tmux

# kali only
apt-get install wordlists
gunzip --keep /usr/share/wordlists/rockyou.txt.gz # entpacken
