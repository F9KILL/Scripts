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

echo -e "\033[32;1m[+] Configurando KEYMAP para ABNT2 [\033[m \033[33;1mbr-abnt2\033[m \033[32;1m]\033[m"
echo "KEYMAP=br-abnt2" >> /etc/vconsole.conf
localectl set-x11-keymap br abnt2

echo -e "\033[32;1m[+] Configurando modo de suspenção.\033[m"
echo "HandleLidSwitch=suspend" >> /etc/systemd/logind.conf
echo "HandleLidSwitchDocked=suspend" >> /etc/systemd/logind.conf

# ================================================
# Instalação de programas 
# ================================================
#
#	[ Sistema ]
#		intel-ucode xf86-input-synaptics cron xdg-user-dirs cups cups-pdf 
#		ttf-dejavu noto-fonts ttf-liberation ttf-freefont ntfs-3g dkms
#
#	[ Interface]
#		xorg xorg-xinit fluxbox lxdm compton gtk-engines gtk-chtheme gtk-engine-murrine
#
#	[ Jogos ]
#		retroarch playonlinux wine
#
#	[ Áudio/Video ]
#		simplescreenrecorder pavucontrol alsa-firmware alsa-utils alsa-plugins pulseaudio-alsa
#		pulseaudio moc mpv vlc volmeicon audacity mpg123 openal fluidsynth
#
#	[ Acessórios ]
#		ranger epdfview xorg-xcalc vim leafpad anki xsane libreoffice
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
#		nvidia nvidia-settings opencl-nvidia ibus ibus-anthy

echo -e "\033[32;1m[+] Seleção e instalação de programas.\033[m"
pacman -S sudo intel-ucode zsh dkms xf86-input-synaptics xorg xorg-xinit fluxbox lxdm xterm sakura ntfs-3g ranger htop epdfview scrot giblib cron xdg-user-dirs xorg-xcalc virtualbox virtualbox-guest-dkms virtualbox-guest-iso simplescreenrecorder compton vim leafpad anki lxappearance gparted dosfstools f2fs-tools btrfs-progs exfat-utils udftools gpart mtools unzip unrar p7zip nvidia nvidia-settings opencl-nvidia gtk-engines gtk-chtheme john hashcat hydra findmyhash hping tcpdump proxychains nmap nikto aircrack-ng wifite reaver macchanger wireshark-cli wireshark-common wireshark-gtk wireless_tools wpa_actiond wpa_supplicant dialog networkmanager network-manager-applet links firefox thunderbird apache php tor chromium wget xsane pavucontrol alsa-firmware alsa-utils alsa-plugins pulseaudio-alsa pulseaudio moc mpv vlc volumeicon audacity nitrogen gimp inkscape retroarch playonlinux ttf-dejavu noto-fonts ttf-liberation ttf-freefont cups cups-pdf wine mpg123 openal ibus ibus-anthy

echo -e "\033[32;1m[+] Configurando SUDO.\033[m"
sed -i 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers

echo -e "\033[32;1m[+] Criando diretórios do usuário.\033[m"
xdg-user-dirs-update

echo -e "\033[32;1m[+] Abilitando o LXDM na inicialização.\033[m"
systemctl enable lxdm.service

echo -e "\033[32;1m[+] Abilitando o NetworkManager na inicialização.\033[m"
systemctl enable NetworkManager.service

echo -e "\033[32;1m[+] Criando usuário [\033[m \033[33;1mhv60t\033[m \033[32;1m]\033[m"
useradd -m -g users -G wheel,storage,power -s /bin/zsh hv60t
echo ""
echo -e "\033[32;1m[+] Informe a senha para o usuário hv60t.\033[m"
passwd hv60t

echo -e "\033[32;1m[+] Adicionando usuário hv60t para o grupo [\033[m \033[33;1mvboxusers\033[m \033[32;1m]\033[m"
gpasswd -a hv60t vboxusers

echo -e "\033[32;1m[+] Carregando modulo do virtualbox na inicialização.\033[m"
echo vboxdrv >> /etc/modules-load.d/virtualbox.conf

echo -e "\033[32;1m[+] Atualizar a base de dados dos módulos.\033[m"
depmod -a

echo -e "\033[32;1m[+] Carregando as configurações para o fluxbox do Github.\033[m"
git clone https://github.com/Hv60t/Configs.git
echo -e "\033[32;1m[+] Copiando as configurações para o diretório dos usuários..\033[m"
cp -R Configs/fluxbox ~/.fluxbox
cp -R Configs/fluxbox /home/hv60t/.fluxbox
chown hv60t:users -R /home/hv60t/.fluxbox
rm -rf Scripts
echo ""
echo -e "\033[31;1;5m[+]\033[m \033[31;1;5mREINICIE O SISTEMA.\033[m"
