#!/usr/bin/env bash
# Date: 2024-12-18

set -x
set -e

apt install daemonize macchanger aircrack-ng wordlists ieee-data
gunzip /usr/share/wordlists/rockyou.txt.gz # entpacken

