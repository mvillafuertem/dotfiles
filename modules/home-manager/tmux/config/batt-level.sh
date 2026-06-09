#!/bin/sh
pmset -g batt | awk '/InternalBattery/ {gsub(/[^0-9].*$/, "", $3); print $3+0}'
