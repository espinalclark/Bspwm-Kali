#!/usr/bin/env bash

# mata instancias anteriores
killall -q polybar

# espera a que terminen
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# inicia barras
polybar top &
polybar bottom &

