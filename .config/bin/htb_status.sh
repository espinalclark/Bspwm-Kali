#!/bin/sh
# vpn_status.sh
# Muestra la IP de la VPN y diferencia HTB vs TryHackMe con iconos Nerd Font

# --------- CONFIG (ajusta glyphs y subredes si quieres) ----------
HTB_ICON=""        # icono HTB (cámbialo por el glyph que uses)
THM_ICON="爵"        # icono TryHackMe
VPN_ICON=""        # icono fallback VPN
DISCONNECTED_TEXT=" Sin conexión"

# Si quieres detectar por subred, añade aquí los prefijos (sin CIDR),
# por ejemplo HTB_SUBNETS="10.10 10.11"  (se busca prefijo "10.10." al inicio)
HTB_SUBNETS=""   # ej: "10.10 10.11"
THM_SUBNETS=""   # ej: "10.9"

# Colores estilo polybar (opcional)
PREF_COLOR="%{F#a486dd}"
TEXT_COLOR="%{F#FFFFFF}"
RESET="%{u-}"
# ------------------------------------------------------------------

# Obtener primera interfaz VPN disponible (tun*, utun*, wg*, tap*, vpn*)
get_vpn_iface() {
    ip -o link show 2>/dev/null | awk -F': ' '
      BEGIN {IGNORECASE=1}
      $2 ~ /^(tun|utun|wg|tap|vpn)/ { print $2; exit }
    '
}

# Obtener IPv4 de interfaz
get_ip() {
    iface="$1"
    ip -4 addr show "$iface" 2>/dev/null | awk '/inet / {print $2}' | cut -d/ -f1
}

# Detectar servicio por procesos (openvpn, wg-quick, etc.)
detect_by_process() {
    # openvpn command lines
    if pgrep -a openvpn >/dev/null 2>&1; then
        if pgrep -a openvpn | tr '[:upper:]' '[:lower:]' | grep -E 'htb|hackthebox' >/dev/null 2>&1; then
            echo "htb" && return
        fi
        if pgrep -a openvpn | tr '[:upper:]' '[:lower:]' | grep -E 'tryhackme|tryhack|thm' >/dev/null 2>&1; then
            echo "thm" && return
        fi
    fi

    # wg-quick (wireguard) command lines
    if pgrep -a wg-quick >/dev/null 2>&1; then
        if pgrep -a wg-quick | tr '[:upper:]' '[:lower:]' | grep -E 'htb|hackthebox' >/dev/null 2>&1; then
            echo "htb" && return
        fi
        if pgrep -a wg-quick | tr '[:upper:]' '[:lower:]' | grep -E 'tryhackme|tryhack|thm' >/dev/null 2>&1; then
            echo "thm" && return
        fi
    fi

    echo ""
}

# Detectar por nombres de archivos de configuración (.ovpn, .conf, .json wg)
detect_by_files() {
    # /etc/openvpn, ~/.openvpn, /etc/wireguard
    if ls /etc/openvpn/* 2>/dev/null | tr '[:upper:]' '[:lower:]' | grep -E 'htb|hackthebox' >/dev/null 2>&1; then
        echo "htb" && return
    fi
    if ls /etc/openvpn/* 2>/dev/null | tr '[:upper:]' '[:lower:]' | grep -E 'tryhackme|tryhack|thm' >/dev/null 2>&1; then
        echo "thm" && return
    fi
    if ls ~/.openvpn/* 2>/dev/null | tr '[:upper:]' '[:lower:]' | grep -E 'htb|hackthebox' >/dev/null 2>&1; then
        echo "htb" && return
    fi
    if ls ~/.openvpn/* 2>/dev/null | tr '[:upper:]' '[:lower:]' | grep -E 'tryhackme|tryhack|thm' >/dev/null 2>&1; then
        echo "thm" && return
    fi

    # wireguard config filenames
    if ls /etc/wireguard/* 2>/dev/null | tr '[:upper:]' '[:lower:]' | grep -E 'htb|hackthebox' >/dev/null 2>&1; then
        echo "htb" && return
    fi
    if ls /etc/wireguard/* 2>/dev/null | tr '[:upper:]' '[:lower:]' | grep -E 'tryhackme|tryhack|thm' >/dev/null 2>&1; then
        echo "thm" && return
    fi

    echo ""
}

# Detectar por /etc/resolv.conf (dominios añadidos por la VPN)
detect_by_resolv() {
    if grep -Ei 'hackthebox|htb' /etc/resolv.conf >/dev/null 2>&1; then
        echo "htb" && return
    fi
    if grep -Ei 'tryhackme|thm' /etc/resolv.conf >/dev/null 2>&1; then
        echo "thm" && return
    fi
    echo ""
}

# Detectar por rango de IP (si el usuario configuró HTB_SUBNETS/THM_SUBNETS arriba)
detect_by_subnet() {
    ip="$1"
    [ -z "$ip" ] && { echo ""; return; }
    for p in $HTB_SUBNETS; do
        case "$ip" in
            $p.*) echo "htb" && return ;;
        esac
    done
    for p in $THM_SUBNETS; do
        case "$ip" in
            $p.*) echo "thm" && return ;;
        esac
    done
    echo ""
}

# MAIN
VPN_IF=$(get_vpn_iface)

if [ -z "$VPN_IF" ]; then
    # No hay interfaz VPN -> no imprimimos IP (usuario pidió mostrar solo VPN)
    # Puedes cambiar la línea siguiente para mostrar "Sin conexión" si prefieres.
    echo "${PREF_COLOR}${TEXT_COLOR}${DISCONNECTED_TEXT}${RESET}"
    exit 0
fi

VPN_IP=$(get_ip "$VPN_IF")

# Intentar detectar servicio por varias heurísticas en orden
SERVICE=""
SERVICE=$(detect_by_process)
[ -z "$SERVICE" ] && SERVICE=$(detect_by_files)
[ -z "$SERVICE" ] && SERVICE=$(detect_by_resolv)
[ -z "$SERVICE" ] && SERVICE=$(detect_by_subnet "$VPN_IP")

# Output final (icono y IP)
case "$SERVICE" in
    htb)
        echo "${PREF_COLOR}${HTB_ICON} ${TEXT_COLOR}${VPN_IP:-(sin ip)}${RESET}"
        ;;
    thm)
        echo "${PREF_COLOR}${THM_ICON} ${TEXT_COLOR}${VPN_IP:-(sin ip)}${RESET}"
        ;;
    *)
        echo "${PREF_COLOR}${VPN_ICON} ${TEXT_COLOR}${VPN_IP:-(sin ip)}${RESET}"
        ;;
esac

exit 0

