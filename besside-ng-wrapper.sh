#!/usr/bin/env bash

set -x
#set -e

export LANG="C"

test -r config \
	&& source config

usage () {
	cat <<! 1>&2
Usage: $0 <start|stop|status> ;-)
!
	exit 1
}
start () {
	# set random vendor MAC of the same kind
	macchanger -a $if

	# WLAN-Adapter in den monitor mode schalten
	airmon-ng start $if
	trap "$0 -i $mon stop" 0 1 2 3 15

	# WPA-Handshakes aufzeichnen
	daemonize -e $log -o $log -c $dir -l $besside_ng_pid -p $besside_ng_pid -u root /usr/sbin/besside-ng -vvv $mon

	# Log verfolgen
	tail -f ./besside.log $log
}
stop () {
	# Den monitor mode wieder abschalten
	airmon-ng stop $mon
	pkill -F $besside_ng_pid
	macchanger --permanent $if
}
status () {
	tail $log
}

dir="." # "/tmp/$(basename "$(pwd)")"
mkdir -p $dir && cd $dir
pwd

besside_ng_pid="besside-ng.pid"
log="`basename "$0"`.log"

# check write permissions amongst other things
touch $dir $besside_ng_pid $log

# Interface und entsprechendes Gateway
if=${if:-`nmcli -t connection show $con | sed -n -E "/^GENERAL\.DEVICES:/s///p"`}

TEMP=$(getopt -o 'hi:m:' --long 'help,interface:monitor:' -n "$0" -- "$@")

if [ $? -ne 0 ]; then
	usage
	echo 'Terminating...' >&2
	exit 1
fi

# Note the quotes around "$TEMP": they are essential!
eval set -- "$TEMP"
unset TEMP

while true; do
	case "$1" in
		'-h'|'--help')
			echo 'Option -h, --help'
			shift 1
			usage
			exit
		;;
		'-i'|'--interface')
			echo "Option -i, --interface; argument '$2'"
			if="$2"
			shift 2
			continue
		;;
		'-m'|'--monitor')
			echo "Option -m, --monitor; argument '$2'"
			mon="$2"
			shift 2
			continue
		;;
		'--')
			shift
			break
		;;
		*)
			echo 'Internal error!' >&2
			exit 1
		;;
	esac
done

#echo 'Remaining arguments:'
#for arg; do
#	echo "--> '$arg'"
#done

if="${if:-wlan0}"
mon="${mon:-${if}mon}"

if [ ! "$if" ]; then
	echo "Konnte Interface nicht ermitteln :-(" 1>&2
	exit 1
else
	echo "Interface $if ermittelt :-)"
fi

case "$1" in
	start)
		start
	;;
	stop)
		stop
	;;
	status)
		status
	;;
	*)
		usage
	;;
esac

