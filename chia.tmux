#!/bin/bash
#
# chia.tmux
#
# (c) Stephen Bates, 2021
#
# A tmux script to setup my favourite chia command line
# environment. Includes panes for htop, iostat, df and more.

SESSION=${SESSION:-chia-metrics}
CHIA_HOME=${CHIA_HOME:-/home/batesste/.chia/mainnet/}
ODIR=${ODIR:-/mnt/chia/plots}
tmux -2 new-session -d -s $SESSION

# Setup windows
tmux new-window -t $SESSION:1 -n 'Chia'
tmux split-window -h -p 50
tmux select-pane -t 0
tmux send-keys "htop" C-m
tmux split-window -v -p 50
tmux select-pane -t 1
tmux send-keys "tail -F ${CHIA_HOME}log/debug.log" C-m
tmux split-window -v -p 50
tmux select-pane -t 3
tmux split-window -v -p 50
tmux select-pane -t 4
tmux send-keys "iostat -md 2 /dev/nvme0n1 /dev/nvme1n1" C-m
tmux split-window -v -p 50
tmux select-pane -t 5
tmux send-keys "watch -n2 \"df -h / /mnt/chia/tmp ${ODIR}\"" C-m

# Set default window
tmux select-window -t $SESSION:1
tmux select-pane -t 3

# Attach to session
tmux -2 attach-session -t $SESSION
