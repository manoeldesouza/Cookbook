#!/bin/bash

echo "
      Script: Arch Linux (2017-05) Recipe (for Inspiron 13 - 7353)
      Author: Manoel de Souza
      E-Mail: msouza.rj@gmail.com      
     Version: 2.0.0
        Date: 06-May-2017
"

#	https://wiki.archlinux.org/index.php/Installation_guide
#	http://lifehacker.com/5680453/build-a-killer-customized-arch-linux-installation-and-learn-all-about-linux-in-the-process
#	https://www.ostechnix.com/install-arch-linux-latest-version/
#	https://www.ostechnix.com/arch-linux-2016-post-installation/

#	https://turlucode.com/arch-linux-install-guide-step-1-basic-installation/
#	http://turlucode.com/arch-linux-install-guide-step-2-desktop-environment-installation/#GNOME

#	http://turlucode.com/arch-linux-install-guide-step-2-desktop-environment-installation/
#	https://ramsdenj.com/2016/06/23/arch-linux-on-zfs-part-1-embed-zfs-in-archiso.html
#	https://ramsdenj.com/2016/06/23/arch-linux-on-zfs-part-2-installation.html
#	https://wiki.archlinux.org/index.php/Installing_Arch_Linux_on_ZFS
#	https://wiki.archlinux.org/index.php/systemd-boot




echo "
First Step: Basic bootstrap installation
===========================================================================================================
"

echo "
1.1 Keys:
"

loadkeys br-latin1-us
wget https://github.com/manoeldesouza/cookbook/Inspiron-Arch.sh



echo "
1.2 Network:
"

ping www.yahoo.com
wifi-menu -o

pacman -Syu reflector rsync

reflector -c BR > /etc/pacman.d/mirrorlist



echo "
1.3 Disk partitions setup:
"

sgdisk --zap /dev/sda
#sgdisk --clear /dev/sda

sgdisk --new 0:0:+512M --typecode 0:ef00  --change-name 0:"EFI System" /dev/sda 
sgdisk --new 0:0:+8G   --typecode 0:8200  --change-name 0:"Linux Swap" /dev/sda 
sgdisk --new 0:0:0     --typecode 0:8300  --change-name 0:"Linux Root" /dev/sda 

sgdisk --print /dev/sda

#gdisk /dev/sda
 # o (clear)
 # n 
 # GUID EF00
#gdisk -l /dev/sda



echo "
1.4 filesystem setup:
"

mkfs.fat -F32 -n BOOT /dev/sda1

mkswap -L  swap /dev/sda2
swapon /dev/sda2
swapon -s
free -h

mkfs.ext4 /dev/sda3


mount /dev/sda3 /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot



echo "
1.5 Basic installation:
"

pacstrap /mnt base base-devel

genfstab -U /mnt >> /mnt/etc/fstab

nano /mnt/etc/fstab
# /dev/sda2  none swap defaults 0 0
# add discard to /

arch-chroot /mnt




echo "
Second Step: Boot loader and basic utilities
===========================================================================================================
"

echo "
2.1 Bootloader (Systemd) installation:
"

bootctl install

echo "
default arch
timeout 4
editor 0
" > /boot/loader/loader.conf

echo "
title Arch Linux
linux /vmlinuz-linux
initrd /intramfs-linux.img
options root=/dev/sda3 rw
" > /boot/loader/entries/arch.conf



echo "
2.2 System installation:
"

pacman -S terminus-font
setfont ter-v16n

echo "
FONT=ter-v16n
" >  /etc/vconsole.conf


# Core utilities
# -----------------------
pacman -S git wget reflector mc vim lynx elinks gdisk hdparm tmux bash-completion
 
reflector -c BR > /etc/pacman.d/mirrorlist 
nano /etc/pacman.d/mirrorlist
# uncomment Multilib



echo "
2.3 System configuration:
"

# Locale setup
# -----------------------
nano /etc/locale.gen
# Uncomment   pt_BR.UTF-8

locale-gen
echo LANG=pt_BR.UTF-8 > /etc/locale.conf
export LANG=pt_BR.UTF-8

localectl set-keymap --no-convert br-latin1-us  
localectl set-locale LANG="pt_BR.UTF-8"

#setxkbmap -model pc104 -layout us_intl
#echo '
#setxkbmap -model pc104 -layout us_intl
#' >> nano ~/.bashrc


# Timezone setup
# -----------------------
timedatectl set-ntp true
ln -sf /usr/share/zoneinfo/Brazil/East /etc/localtime
hwclock --systohc --utc
date



# Network setup
# -----------------------
hostnamectl set-hostname Inspiron

nano /etc/hosts
# 127.0.1.1     localhost.localdomain   Inspiron

sudo pacman -S iw wireless_tools wpa_supplicant wpa_actiond dialog
sudo pacman -S ifplugd

wifi-menu -o

echo "
Description='J5create Lan / USB interface'
Interface=enp0s20f0u2u4
Connection=ethernet
IP=dhcp
" > /etc/netctl/ethernet-dhcp

echo "
Description='Andrdoid Tethering'
Interface=enp0s020f0u1
Connection=ethernet
IP=dhcp
" > /etc/netctl/android-dhcp

sudo netctl list
sudo netctl start ethernet-dhcp
sudo netctl start android-dhcp



# Services setup
# -----------------------
#systemctl enable sshd.service
#systemctl enable NetworkManager.service
#systemctl enable wpa_supplicant.service
#systemctl enable bluetooth.service
#systemctl disable dhcpcd.service




echo "
2.4 Root & User configuration:
"

# Root setup
# -----------------------
passwd 
gpasswd -a `id -un` network
EDITOR=nano visudo 
# %wheel ALL


# User setup
# -----------------------
useradd -m -g users -G wheel -s /bin/bash manoel
passwd manoel

exit 
umount -R /mnt
reboot




echo "
Third Step: First Boot
===========================================================================================================
"

# Cookbook download
# -----------------------
mkdir ~/Downloads
cd ~/Downloads
#git clone https://github.com/erikdubois/archcinnamon
#git clone https://github.com/erikdubois/Aureola
git clone https://github.com/manoeldesouza/Cookbook



# Compression Utilities
# -----------------------
pacman -S p7zip unace unrar zip unzip sharutils uudeview arj cabextract file-roller



# AUR setup
# -----------------------
sudo nano /etc/pacman.conf

[archlinuxfr]
SigLevel = Never
Server = http://repo.archlinux.fr/$arch

sudo pacman -Sy yaourt customizepkg rsync



# Xorg setup
# -----------------------
sudo pacman -S xorg-server xorg-xinit 
#xorg-server-utils
sudo pacman -S mesa 
sudo pacman -S xorg-twm xorg-xclock xterm
sudo pacman -S xf86-video-intel lib32-intel-dri lib32-mesa lib32-libgl



# Audio setup
# -----------------------
sudo pacman -S alsa-utils pulseaudio
sudo pacman -S alsa-oss alsa-lib
sudo reboot

amixer sset Master unmute
speaker-test -c 2
sudo pacman -S moc



# Gnome setup
# -----------------------
sudo pacman -S gnome gnome-extra
sudo pacman -S gnome-initial-setup
sudo pacman -S gnome-shell-extensions
yaourt -S gnome-shell-extension-openweather-git gnome-shell-extension-pixel-saver gnome-shell-extension-mediaplayer-git gnome-shell-user-themes

sudo pacman -S faenza-icon-theme faience-icon-theme arc-gtk-theme arc-icon-theme 
yaourt -S mint-x-theme mint-y-theme moka-icon-theme faba-icon-theme paper-icon-theme paper-gtk-theme-git

echo "
exec gnome-session
#exec i3
" > ~/.xinitrc



# Codecs installation
# -----------------------
sudo pacman -S gstreamer gst-libav gst-plugins-base gst-plugins-good gst-plugins-bad gst-plugins-ugly
sudo pacman -S a52dec faac faad2 flac jasper lame libdca libdv libmad libmpeg2 libtheora libvorbis libxv wavpack x264 xvidcore 




echo "
Forth Step: Gnome Desktop
===========================================================================================================
"

startx



# Applications installation
# -----------------------
sudo pacman -S firefox flashplugin chromium geany inkscape stellarium cheese rhythmbox scribus blender docky shotwell digikam dia cups-pdf evolution bluefish gimp darktable gnome-music conky conky-manager vlc filezilla epiphany geary gnome-multi-writer simple-scan dropbox eog terminator transmission-cli transmission-gtk gparted libreoffice totem youtube-dl octave

yaourt -S pamac-aur
yaourt -S wps-office ttf-wps-fonts
yaourt -S brackets
yaourt -S entangle gradio mysql-workbench
yaourt -S tilix



# Powerline configuration
# -----------------------
sudo pacman -S python-pip python-setuptools
sudo pip install powerline-status
wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
sudo mv PowerlineSymbols.otf /usr/share/fonts/
sudo fc-cache -vf
sudo mv 10-powerline-symbols.conf /etc/fonts/conf.d/
echo '
#export TERM=”screen-256color”
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. /usr/lib/python3.6/site-packages/powerline/bindings/bash/powerline.sh
' >> ~/.bashrc



# Neofetch configuration
# -----------------------
yaourt -S neofetch
echo "
neofetch
" >> ~/.bashrc



# Warsaw installation (online banking)
# -----------------------

# Details:	http://www.vivaolinux.com.br/dica/Modulo-de-Seguranca-Warsaw-da-Caixa-no-Arch-Linux

yaourt -S warsaw
/usr/local/bin/warsaw/core
/usr/bin/warsaw/wsatspi

sudo systemctl start warsaw.service
sudo systemctl enable warsaw.service



# Servers installation
# -----------------------
sudo pacman -S openssh



# Virtualbox installation
# -----------------------
sudo pacman -S linux-headers
sudo pacman -S net-tools
sudo pacman -S virtualbox virtualbox-host-modules-arch virtualbox-guest-iso
sudo pacman -S virtualbox-ext-vnc

yaourt -S virtualbox-ext-oracle

sudo modprobe vboxdrv
sudo modprobe -a vboxnetadp vboxnetflt

sudo nano /etc/modules-load.d/virtualbox.conf
 vboxdrv
 vboxnetadp
 vboxnetflt
 vboxpci

sudo gpasswd -a $USER vboxusers
#sudo usermod -aG vboxusers `id -un`



# KVM installation
# -----------------------
sudo pacman -S firewalld
sudo pacman -S ebtables iptables 
sudo pacman -S inxi dmidecode gparted && sudo inxi -Fxm
sudo pacman -S qemu libvirt gnome-boxes virt-manager dnsmasq vde2 bridge-utils openbsd-netcat

sudo systemctl enable libvirtd.service
sudo systemctl start libvirtd.service

sudo usermod -aG libvirtd,kvm `id -un`

#sudo systemctl start libvirtd
#sudo systemctl enable libvirtd

#sudo gpasswd -a `id -un` kvm
#sudo gpasswd -a `id -un` libvirt



# Data Science Tools: Matlab
# -----------------------
# Install matlab: www.mathworks.com

# Details:	https://wiki.archlinux.org/index.php/matlab

sudo ln -s /usr/local/MATLAB/R2016b/bin/matlab /usr/local/bin
sudo curl https://upload.wikimedia.org/wikipedia/commons/2/21/Matlab_Logo.png -o /usr/share/icons/matlab.png
sudo echo '
#!/usr/bin/env xdg-open
[Desktop Entry]
Type=Application
Icon=/usr/share/icons/matlab.png
Name=MATLAB
Comment=Start MATLAB - The Language of Technical Computing
Exec=matlab -desktop
Categories=Development;
MimeType=text/x-matlab;
StartupWMClass=MATLAB R2016b - academic use
' >  /usr/share/applications/matlab.desktop

# OR:

yaourt -S matlab



# Data Science Tools: Anaconda
# -----------------------
wget https://repo.continuum.io/archive/Anaconda3-4.3.1-Linux-x86_64.sh
chmod ugo+x Anaconda3-4.3.1-Linux-x86_64.sh
./Anaconda3-4.3.1-Linux-x86_64.sh

# OR:
yaourt -S anaconda



# Data Science Tools: R Studio
# -----------------------
yaourt -S rstudio-desktop	



# i3 Window Manager installation
# -----------------------
sudo pacman -S i3 i3-wm dmenu i3status i3lock i3blocks




echo "
Fifth Step: Final configuration
===========================================================================================================
"

# 1. Firefox backspace
#	about:config
#	browser.backspace_action => 0
#
# Persist tabs


# 2. Fonts
#
#	Titles: Cantarell Bold 10
#	Interface: Cantarell Regular 9 
#	Documents: Sans Regular 9
#	Monospace: Monospace Regular 9
#
#	anti-aliasing-mode: rgba

















































#sudo systemctl stop dhcpcd.service
#sudo systemctl start sshd.service
#sudo systemctl start wpa_supplicant.service
#sudo systemctl start NetworkManager.service
#sudo systemctl start bluetooth.service

sudo wifi-menu -o

#sudo echo "
#Description='A basic DHCP Android Tethering'
#Interface=enp0s20f0u1
#Connection=ethernet
#IP=dhcp
#" > /etc/netctl/Android

#sudo netctl start Android
#sudo netctl enable Android

sudo pacman -S ifplugd

#sudo systemctl enable netctl-ifplugd@Android.service


# J5 Ethernet
sudo dhcpcd enp0s20f0u1u4

# Android Tethering
sudo dhcpcd enp0s20f0u2
	


#sudo echo "
#Description='A basic DHCP for J5 Ethernet adapter'
#Interface=enp0s20f0u2u4
#Connection=ethernet
#IP=dhcp
#" > /etc/netctl/J5-Ethernet

#sudo netctl start J5-Ethernet
#sudo netctl enable J5-Ethernet

#sudo pacman -S ifplugd

#sudo systemctl enable netctl-ifplugd@J5-Ethernet.service





#cp /etc/netctl/examples/ethernet-dhcp /etc/netctl
#nano /etc/netctl/ethernet-dhcp

#netctl enable ethernet-dhcp
wifi-menu -o

#systemctl enable dhcpcd@<INTERFACE>.service
#systemctl enable netctl-auto@<INTERFACE>.service

# sudo pacman –S mdm-display-manager
# sudo systemctl start mdm-service
# sudo systemctl enable mdm-service

# sudo pacman –S mdm-display-manager
#sudo systemctl start gdm.service
#sudo systemctl enable gdm.service



#sudo pacman -S cups cups-pdf ghostscript gsfonts libcups hplip system-config-printer
#sudo systemctl enable org.cups.cupsd.service
#sudo systemctl start org.cups.cupsd.service


sudo pacman -S gnome-terminal gedit gnome-system-monitor gnome-font-viewer gnome-screenshot galculator geary gparted net-tools gpick grsync hardinfo hddtemp hexchat htop nemo nemo-share nemo-fileroller noto-fonts gthumb evince gvfs-afc gvfs-goa gvfs-google gvfs-gphoto2 gvfs-mtp gvfs-nfs gvfs-smb jre7-openjdk

sudo pacman -S a52dec faac faad2 flac jasper lame libdca libdv libmad libmpeg2 libtheora libvorbis libxv wavpack x264 xvidcore 

sudo pacman -S gst-plugins-good gst-plugins-bad gst-plugins-base gst-plugins-ugly gstreamer

sudo pacman -S firefox flashplugin chromium clementine conky darktable dconf-editor filezilla galculator geany gimp gksu glances inkscape inxi lm_sensors lsb-release meld mlocate mpv notify-osd numlockx openshot plank polkit-gnome redshift ristretto sane screenfetch scrot shotwell simple-scan simplescreenrecorder smplayer sysstat terminator transmission-cli transmission-gtk tumbler variety vnstat unclutter libreoffice vlc rhythmbox dropbox smbclient samba eog

sudo pacman -S faenza-icon-theme faience-icon-theme arc-icon-theme arc-gtk-theme 




yaourt -S ttf-ms-fonts mint-x-theme mint-y-theme moka-icon-theme faba-icon-theme 









