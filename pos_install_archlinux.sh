#!/bin/bash
# Script para fazer a configuração e instalação de programas, depois da instalação do archlinux.

echo -e "\033[32;1m[+] Configurando Fuso Horário para [\033[m \033[33;1mSão Paulo\033[m \033[32;1m]\033[m"
ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
hwclock --systohc --utc

echo -e "\033[32;1m[+] Configurando locale.gen para inglês [\033[m \033[33;1men_US.UTF-8\033[m \033[32;1m]\033[m"
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen

echo -e "\033[32;1m[+] Configurando LANG para inglês [\033[m \033[33;1men_US.UTF-8\033[m \033[32;1m]\033[m"
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "LANGUAGE=en_US" >> /etc/locale.conf
echo "LC_MESSAGES=en_US.UTF-8" >> /etc/locale.conf
echo "LC_TIME=pt_BR.UTF-8" >> /etc/locale.conf
echo "LC_MONETARY=pt_BR.UTF-8" >> /etc/locale.conf
echo "LC_NUMERIC=pt_BR.UTF-8" >> /etc/locale.conf

echo -e "\033[32;1m[+] Configurando Teclado para ABNT2 [\033[m \033[33;1mbr-abnt2\033[m \033[32;1m]\033[m"
echo "KEYMAP=br-abnt2" >> /etc/vconsole.conf
localectl set-x11-keymap br abnt2

echo 'Section “InputClass”' > /etc/X11/xorg.conf.d/10-evdev.conf
echo '    Identifier “evdev keyboard catchall”' >> /etc/X11/xorg.conf.d/10-evdev.conf
echo '    MatchIsKeyboard “on”' >> /etc/X11/xorg.conf.d/10-evdev.conf
echo '    MatchDevicePath “/dev/input/event*”' >> /etc/X11/xorg.conf.d/10-evdev.conf
echo '    Driver “evdev”' >> /etc/X11/xorg.conf.d/10-evdev.conf
echo '    Option “XkbLayout” “br”' >> /etc/X11/xorg.conf.d/10-evdev.conf
echo '    Option “XkbVariant” “abnt2"' >> /etc/X11/xorg.conf.d/10-evdev.conf
echo 'EndSection' >> /etc/X11/xorg.conf.d/10-evdev.conf

echo -e "\033[32;1m[+] Configurando modo de suspenção.\033[m"
echo "HandleLidSwitch=suspend" >> /etc/systemd/logind.conf
echo "HandleLidSwitchDocked=suspend" >> /etc/systemd/logind.conf

# ================================================
# Instalação de programas 
# ================================================
#
#	[ Sistema ]
#		intel-ucode xf86-input-synaptics xf86-video-nouveau cron xdg-user-dirs cups
#		ttf-dejavu noto-fonts ttf-liberation ttf-freefont ntfs-3g dkms
#
#	[ Interface ]
#		xorg xorg-xinit openbox lxdm compton gtk-engines gtk-chtheme gtk-engine-murrine
#
#	[ Áudio/Video ]
#		simplescreenrecorder pavucontrol alsa-firmware alsa-utils alsa-plugins pulseaudio-alsa
#		pulseaudio moc mpv vlc volmeicon audacity mpg123 openal fluidsynth
#
#	[ Acessórios ]
#		ranger epdfview xorg-xcalc vim anki xsane libreoffice
#
#	[ Imagens ]
#		(scrot giblib) feh nitrogen gimp inkscape imagemagick
#
#	[ Rede ]
#		wireless_tools wpa_actiond wpa_supplicant dialog network-manager-applet links firefox thunderbird
#		apache php tor chromium wget networkmanager
#
#	[ Pentest ]
#		john hashcat hydra findmyhash hping tcpdump proxychains nmap nikto aircrack-ng 
#		wifite reaver macchanger wireshark-cli wireshark-common wireshark-gtk
#
#	[ Gerenciar Sistema ]
#		xterm sudo htop sakura zsh (gparted dosfstools f2fs-tools btrfs-progs 
#		exfat-utils udftools gpart mtools) unzip unrar p7zip lxappearance virtualbox 
#		virtualbox-guest-dkms virtualbox-gues-iso
#
#	[ Opcional ]
#		ibus ibus-anthy

echo -e "\033[32;1m[+] Seleção e instalação de programas.\033[m"
pacman -S sudo intel-ucode zsh dkms xf86-video-nouveau xf86-input-synaptics xorg xorg-xinit openbox lxdm xterm sakura ntfs-3g ranger htop epdfview scrot giblib cron xdg-user-dirs xorg-xcalc virtualbox virtualbox-guest-dkms virtualbox-guest-iso simplescreenrecorder compton vim leafpad anki lxappearance gparted dosfstools f2fs-tools btrfs-progs exfat-utils udftools gpart mtools unzip unrar p7zip gtk-engines gtk-chtheme gtk-engine-murrine wine john hydra findmyhash hping tcpdump proxychains nmap nikto aircrack-ng macchanger wireshark-cli wireshark-common wireshark-gtk wireless_tools wpa_actiond wpa_supplicant dialog networkmanager network-manager-applet links firefox chromium thunderbird apache php tor wget xsane pavucontrol alsa-firmware alsa-utils alsa-plugins pulseaudio-alsa pulseaudio moc mpv vlc volumeicon audacity nitrogen gimp inkscape ttf-dejavu noto-fonts ttf-liberation ttf-freefont cups mpg123 openal

echo -e "\033[32;1m[+] Configurando SUDO.\033[m"
sed -i 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers

echo -e "\033[32;1m[+] Criando diretórios do usuário.\033[m"
xdg-user-dirs-update

# echo -e "\033[32;1m[+] Abilitando o LXDM na inicialização.\033[m"
# systemctl enable lxdm.service

echo -e "\033[32;1m[+] Abilitando o NetworkManager na inicialização.\033[m"
systemctl enable NetworkManager.service

echo -e "\033[32;1m[+] Criando usuário [\033[m \033[33;1mf9kill\033[m \033[32;1m]\033[m"
useradd -m -g users -G wheel,storage,power -s /bin/zsh f9kill
echo ""
echo -e "\033[32;1m[+] Informe a senha para o usuário f9kill.\033[m"
passwd f9kill

echo -e "\033[32;1m[+] Adicionando usuário f9kill para o grupo [\033[m \033[33;1mvboxusers\033[m 
\033[32;1m]\033[m"
gpasswd -a f9kill vboxusers

echo -e "\033[32;1m[+] Carregando modulo do virtualbox na inicialização.\033[m"
echo vboxdrv >> /etc/modules-load.d/virtualbox.conf

echo -e "\033[32;1m[+] Atualizar a base de dados dos módulos.\033[m"
depmod -a

echo -e "\033[32;1m[+] Carregando as configurações para o fluxbox do Github.\033[m"
git clone https://github.com/F9KILL/Configs.git
echo -e "\033[32;1m[+] Copiando as configurações para o diretório dos usuários..\033[m"
cp -R Configs/openbox ~/.config/
cp -R Configs/openbox /home/f9kill/.config/
chown f9kill:users -R /home/f9kill/.config/
#rm -rf Scripts
echo ""
echo -e "\033[31;1;5m[+]\033[m \033[31;1mREINICIE O SISTEMA.\033[m"
