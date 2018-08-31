#!/bin/bash
# Script para fazer a configuração e instalação de programas, depois da instalação do archlinux.

# configurando horário
ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
hwclock --systohc --utc

# Configurando idioma do sistema para inglês.
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf

# Configurando teclado para ABNT2.
echo "KEYMAP=br-abnt2" >> /etc/vconsole.conf
localectl set-x11-keymap br abnt2

# Configuração modo de suspensão
echo "HandleLidSwitch=suspend" >> /etc/systemd/logind.conf
echo "HandleLidSwitchDocked=suspend" >> /etc/systemd/logind.conf

# ================================================
# Instalação de programas 
# ================================================
#
#	[ Sistema ]
#		intel-ucode xf86-input-synaptics cron xdg-user-dirs clang cups cups-pdf ttf-dejavu noto-fonts dina-font profont ttf-liberation ttf-freefont
#
#	[ Interface]
#		xorg xorg-xinit fluxbox lxdm compton gtk-engines gtk-chtheme gtk-engines-murrine
#
#	[ Jogos ]
#		retroarch playonlinux wine
#
#	[ Áudio/Video ]
#		simplescreenrecorder pavucontrol alsa-firmware alsa-utils alsa-plugins pulseaudio-alsa pulseaudio moc mpv vlc volmeicon audacity mpg123 (openal fluidsynth)
#
#	[ Acessórios ]
#		ranger epdfview xorg-xcalc vim leafpad anki xsane libreoffice
#
#	[ Imagens ]
#		(scrot giblib) feh nitrogen gimp inkscape imagemagick
#
#	[ Rede ]
#		wireless_tools wpa_actiond dialog network-manager-applet links firefox thunderbird apache php tor chromium wget
#
#	[ Pentest ]
#		john hashcat hydra findmyhash hping tcpdump proxychains nmap nikto aircrack-ng wifite reaver macchanger wireshark-cli wireshark-common wireshark-gtk
#
#	[ Gerenciar Sistema ]
#		xterm ntfs-3g sudo htop sakura zsh (gparted dosfstools f2fs-tools btrfs-progs exfat-utils udftools gpart mtools) unzip unrar p7zip lxappearance virtualbox virtualbox-guest-dkms virtualbox-gues-iso
#
#	[ Opcional ]
#		nvidia nvidia-settings opencl-nvidia ibus ibus-anthy

pacman -S --noconfirm sudo intel-ucode zsh xf86-input-synaptics xorg xorg-xinit fluxbox lxdm xterm sakura ntfs-3g ranger htop epdfview scrot giblib cron xdg-user-dirs xorg-xcalc virtualbox virtualbox-guest-dkms virtualbox-guest-iso simplescreenrecorder compton clang vim leafpad anki lxappearance gparted dosfstools f2fs-tools btrfs-progs exfat-utils udftools gpart mtools unzip unrar p7zip nvidia nvidia-settings opencl-nvidia gtk-engines gtk-chtheme john hashcat hydra findmyhash hping tcpdump proxychains nmap nikto aircrack-ng wifite reaver macchanger wireshark-cli wireshark-common wireshark-gtk wireless_tools wpa_actiond dialog network-manager-applet links firefox thunderbird apache php tor chromium wget xsane pavucontrol alsa-firmware alsa-utils alsa-plugins pulseaudio-alsa pulseaudio moc mpv vlc volmeicon audacity nitrogen gimp inkscape retroarch playonlinux ttf-dejavu noto-fonts dina-font profont ttf-liberation ttf-freefont cups cups-pdf wine mpg123 openal fluidsynth ibus ibus-anthy

# Configurando o sudo
sed -i 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' >> /etc/sudoers

# Criando diretórios do usuário.
xdg-user-dirs-update

# Abilitando gerenciador de login.
systemctl enable lxdm.service

# Criando usuário.
useradd -m -g users -G wheel,storage,power -s /bin/zsh hv60t
clear
echo "[+] Informe a senha para o novo usuário: "
passwd hv60t

# Adicionando usuário ao grupo virtualbox
gpasswd -a hv60t vboxusers

# Carregando modulo do virtualbox na inicialização.
echo vboxdrv >> /etc/modules-load.d/virtualbox.conf

# Atualizar a base de dados dos módulos.
depmod -a

# Corregando configurações do fluxbox
git clone https://github.com/Hv60t/Configs.git
rm -rf ~/.fluxbox
cp -R Configs/fluxbox ~/.fluxbox
rm -rf /home/hv60t/.fluxbox
cp -R Configs/fluxbox /home/hv60t/.fluxbox
rm -rf Configs
chwon hv60t:hv60t -R /home/hv60t/.fluxbox

# Reiniciando o sistema.
reboot
