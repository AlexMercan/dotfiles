#!/bin/sh

# Swaylock: https://github.com/mortie/swaylock-effects

if [ $# -ne 1 ]; then
    echo "Usage: $0 {grace}"
    exit 1
fi

GRACE=$1

swaylock \
	--screenshot \
	--clock \
    --timestr="%H:%M:%S" \
    --datestr="%A, %d/%m/%Y" \
	--indicator \
	--indicator-radius 100 \
	--indicator-thickness 7 \
	--effect-blur 7x5 \
	--effect-vignette 0.5:0.5 \
	--ring-color bb00cc \
	--key-hl-color 880033 \
	--line-color 00000000 \
	--inside-color 00000088 \
	--separator-color 00000000 \
	--grace $GRACE \
	--fade-in 0.2
