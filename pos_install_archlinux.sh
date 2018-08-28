#!/bin/bash
# Script para fazer a configuração e instalação de programas, depois da instalação do archlinux.

# configurando horário
ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
hwclock --systohc --utc

# Configurando idioma e teclado
echo "pt_BR.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=pt_BR.UTF-8" >> /etc/locale.conf
echo "KEYMAP=br-abnt2" >> /etc/vconsole.conf

# Configurar o teclado para o ambiente X
localectl set-x11-keymap br abnt2

# ================================================
# Instalação de programas 
# ================================================

# Básicos
pacman -S sudo intel-ucode zsh xf86-input-synaptics xorg xorg-xinit fluxbox lxdm xterm ntfs-3g ranger epdfview scrot cron

# Rede
pacman -S wireless_tools wpa_actiond dialog network-manager-applet links curl

# Áudio/Video
pacman -S pavucontrol alsa-firmware alsa-utils alsa-plugins pulseaudio-alsa pulseaudio moc mpv vlc 

# Configurando o sudo
sed -i 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' >> /etc/sudoes

# Abilitando gerenciador de exibição
systemctl enable lxdm.service

reboot