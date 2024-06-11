#!/bin/bash

sleep 1

killall -q flameshot

while pgrep -x flameshot >/dev/null; do sleep 1; done

flameshot
