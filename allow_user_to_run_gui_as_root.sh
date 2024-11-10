#!/bin/sh

if [ "$1" = "-" ]; then
    xhost -si:localuser:root
else
    xhost si:localuser:root
fi
