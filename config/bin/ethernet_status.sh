#!/bin/sh

# Detectar interfaz Ethernet y Wi-Fi (ajusta si tus nombres son distintos)
ETH_IF=$(ip link | awk -F: '/enp|eth/ {print $2; exit}' | tr -d ' ')
WIFI_IF=$(ip link | awk -F: '/wl/ {print $2; exit}' | tr -d ' ')

# Obtener IP de Ethernet y Wi-Fi
ETH_IP=$(ip addr show "$ETH_IF" 2>/dev/null | awk '/inet / {print $2}' | cut -d/ -f1)
WIFI_IP=$(ip addr show "$WIFI_IF" 2>/dev/null | awk '/inet / {print $2}' | cut -d/ -f1)

# Decidir cuál mostrar (Ethernet tiene prioridad)
if [ -n "$ETH_IP" ]; then
    IP="$ETH_IP"
    ICON=""  # ícono ethernet
elif [ -n "$WIFI_IP" ]; then
    IP="$WIFI_IP"
    ICON=""  # ícono wifi
else
    IP="Sin conexión"
    ICON=""
fi

# Salida con colores (polybar-style)
echo "%{F#a486dd}$ICON %{F#FFFFFF}$IP%{u-}"

