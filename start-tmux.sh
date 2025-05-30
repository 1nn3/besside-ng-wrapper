#!/usr/bin/env bash

set -x
set -e

export LANG="C"
export PATH=".:$PATH"

if=${1:wlan0}
session=wifi-hacking
tmux="tmux -f tmux.conf"

$tmux has-session -t $session
if [ $? -eq 0 ]; then
       echo "Session $session already exists. Attaching."
       sleep 1
       $tmux attach -t $session
       exit 0;
fi

$tmux new-session -d -s $session
$tmux new-window -t $session:0 
$tmux send-keys -t $session:0 "./besside-ng-wrapper.sh -i $if start" C-m
$tmux split-window  -h -t $session:0
$tmux send-keys -t $session:0 'tail -f ./besside.log | ./lsvendor' C-m
$tmux split-window  -v -t $session:0
$tmux send-keys -t $session:0 'cat README.txt' C-m
$tmux attach-session -t $session

