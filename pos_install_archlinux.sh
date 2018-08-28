#!/bin/bash
# Script para fazer a configuração e instalação de programas, depois da instalação do archlinux.

# configurando horário
echo "[+] Mudando fuso horário para America/São Paulo."
ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
hwclock --systohc --utc

# Configurando idioma do sistema
echo "[+] Configurando idioma para Inglês"
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf

# Configurando teclado
echo "KEYMAP=br-abnt2" >> /etc/vconsole.conf
localectl set-x11-keymap br abnt2

# ================================================
# Instalação de programas 
# ================================================
# Básicos
pacman -S --noconfirm sudo intel-ucode zsh xf86-input-synaptics xorg xorg-xinit fluxbox lxdm xterm ntfs-3g ranger htop epdfview scrot cron xdg-user-dirs

# Rede
pacman -S --noconfirm wireless_tools wpa_actiond dialog network-manager-applet links

# Áudio/Video
pacman -S --noconfirm pavucontrol alsa-firmware alsa-utils alsa-plugins pulseaudio-alsa pulseaudio moc mpv vlc volmeicon

# Imagem
pacman -S --noconfirm nitrogen gimp inkscape

# Configurando o sudo
sed -i 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' >> /etc/sudoers

# Criando diretórios do usuário.
xdg-user-dirs-update

# Abilitando gerenciador de login.
systemctl enable lxdm.service

reboot