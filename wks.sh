#!/bin/bash

# fetch i3 workspaces and returns the json

i3-msg --socket "/run/user/1000/i3/$(ls -t /run/user/1000/i3/ | awk '{print $1}' | grep ipc | head -n 1)" -t get_workspaces