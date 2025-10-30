#!/usr/bin/sh
# Zeigt wie oft ein Kanal benutzt wird und die Kanalnummer
nmcli --get-values CHAN device wifi list --rescan yes \
	| sort | uniq -c | sort -n -k 2

