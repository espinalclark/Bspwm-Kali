# ＢＳＰＷＭ  ＫＡＬＩ

*Este proyecto contiene mi entorno gráfico completo basado en **BSPWM** para Kali Linux.*

![menu](assets/bspwm.jpeg)
![extra](assets/extra.jpeg)
![extra2](assets/extra2.jpeg)

## Menu
![menu](assets/menu.jpeg)

## Wallpapers
![wallpaper1](assets/wallpaper1.jpeg)
![wallpaper2](assets/wallpaper2.jpeg)
![wallpaper3](assets/wallpaper3.jpeg)
![wallpaper4](assets/wallpaper4.jpeg)
![wallpaper5](assets/wallpaper5.jpeg)
![wallpaper6](assets/wallpaper6.jpeg)
## Instalacion 
```bash
- git clone https://github.com/espinalclark/Bspwm-Kali.git
- cd Bspwm-Kali
- chmod +x setup.sh
- ./setup.sh
```

## Estructura
```
config
├── bin                       <-- Scripts
│   ├── ethernet_status.sh
│   ├── htb_status.sh
│   ├── htb_target.sh
│   └── target
├── bspwm
│   ├── bspwmrc               
│   └── scripts
│       └── bspwm_resize
├── hack.sh
├── kitty
│   ├── color.ini
│   ├── colors-kitty.conf
│   ├── colors.conf
│   └── kitty.conf
├── picom
│   └── picom.conf
├── polybar
│   ├── colors.ini
│   ├── fonts
│   ├── launch.sh
│   ├── scripts
│   │   ├── launcher
│   │   └── themes
│   │       ├── colors.rasi
│   ├── shapes
│   │   ├── bars.ini
│   │   ├── 
├── sxhkd
│   └── sxhkdrc                        <-- Atajos de teclados
├── volumen.py                         <-- Script para volumen
└── vpnhtb.sh                          <-- Script para vpn status
```

## Atajos de teclados
```
# Terminal

super + Return → Abrir kitty

# Launcher

super + d → Abrir rofi (menú de aplicaciones)

# Recargar SXHKD

super + Escape → Recargar configuración

# Salir / Reiniciar BSPWM

super + alt + q → Salir

super + alt + r → Reiniciar

# Cerrar ventanas

super + w → Cerrar ventana

super + shift + w → Forzar cierre

# Layouts

super + m → Alternar entre tiled / monocle

# Mover ventanas

super + g → Cambiar la ventana actual por la más grande

super + y → Mover marcada al preseleccionado más reciente

# Cambiar estado de ventana

super + t → Tiled

super + shift + t → Pseudo-tiled

super + s → Floating

super + f → Fullscreen

# Flags

super + ctrl + m → Marked

super + ctrl + x → Locked

super + ctrl + y → Sticky

super + ctrl + z → Private

# Foco y Navegación
Mover foco / Intercambiar

super + Left/Down/Up/Right → Mover foco

super + shift + Left/Down/Up/Right → Intercambiar ventanas

# Saltos lógicos

super + p → Parent

super + b → Brother

super + , → Primera

super + . → Segunda

# Ciclo en el escritorio

super + c → Siguiente ventana

super + shift + c → Anterior ventana

Cambiar de escritorio

super + [ → Escritorio anterior

super + ] → Escritorio siguiente

# Ultimo foco

super + grave (`) → Última ventana

super + Tab → Último escritorio

# Historial

super + o → Ventana más vieja

super + i → Ventana más nueva

# Ir / Enviar a escritorio

super + 1-9,0 → Ir a escritorio

super + shift + 1-9,0 → Enviar ventana

# Preselección
Dirección

super + ctrl + alt + flechas → Preseleccionar dirección

# Tamaño

super + ctrl + 1-9 → Ratio 0.X

# Cancelar preselección

super + ctrl + alt + space → Cancelar nodo

super + ctrl + shift + space → Cancelar todo en el escritorio

# Mover / Redimensionar
Mover ventana flotante

super + ctrl + flechas → Mover flotante

Redimensionar (script personalizado)

alt + super + flechas → Resize personalizado (bspwm_resize)

#Atajos personalizados Aplicaciones

super + shift + f → Firefox

super + shift + b → Burp Suite

ctrl + shift + p → BurpSuite Pro

#Pantalla

ctrl + alt + l → Bloquear (i3lock-fancy)

Audio (pamixer)

ctrl + shift + Up → Subir volumen

ctrl + shift + Down → Bajar volumen

ctrl + shift + m → Mute / Unmute

#Screenshots

Print → Captura completa

ctrl + Print → Captura guiada (flameshot)

```
## Adicional
- dar permisos de ejecucion  a los scripts de bin
- poner alias a los scripts en .zshrc

