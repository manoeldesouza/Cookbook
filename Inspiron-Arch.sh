#!/bin/bash

echo "
      Script: Linux Mint 18 Recipe (for Inspiron 13 - 7353)
      Author: Manoel de Souza
      E-Mail: msouza.rj@gmail.com      
     Version: 1.0.0
        Date: 01-Mar-2017
"

cd ~/Downloads
sudo echo "Enter root password to start:"


echo "1.1 Preparation:"
#loadkeys br-abnt2
#systemctl start dhcpd
acman -Sy terminus-font git reflector
setfont ter-v16n
Pacman -S reflector
nano /etc/pacman.d/mirrorlist




echo "1.2 Disk setup:"

ls /sys/firmware/efi
ls /sys/firmware/efi/efivars
gdisk /dev/sda
 # o (clear)
 # n 
 # GUID EF00
gdisk -l /dev/sda

mkfs.fat -F32 -n BOOT /dev/sda1
mkfs.ext4 /dev/sda3
mkswap -L  swap /dev/sda2 && swapon /dev/sda2
swapon -s
free -h

mount /mnt /dev/sda3
mkdir /mnt/boot
mount /mnt/boot /dev/sda1


echo "1.3 System installation:"
pacstrap /mnt base base-devel
genfstab -U /mnt >> /mnt/etc/fstab
nano /mnt/etc/fstab
# /dev/sda2  none swap defaults 0 0
# add discard to /

arch-chroot /mnt


echo "1.4 Install bootloader (Systemd):"
bootctl install
cd /boot
cd loader
nano loader.conf
 # default arch
 # timeout 4
 # editor 0

cd entries
nano arch.conf
 # title Arch Linux
 # linux /vmlinuz-linux
 # initrd /intramfs-linux.img
 # options root=/dev/sda2 rw


echo "1.4 Install bootloader (grub - Not used):"
pacman -S grub os-prober efibootmgr
mkdir /boot/efi
mount /dev/sda2 /boot/efi

grub-install /dev/sda
grub-install --efi-directory=/boot/efi /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg


echo "1.5 System setup:"
pacman -S terminus-font
nano /etc/vconsole.conf
# FONT=ter-v16n

pacman -S git wget git reflector mc vim lynx 
reflector -c BR
nano /etc/pacman.d/mirrorlist
# uncomment Multilib

sudo pacman -S p7zip unace unrar zip unzip sharutils uudeview arj cabextract file-roller



nano /etc/locale.gen
locale-gen
echo LANG=pt_BR.UTF-8 > /etc/locale.conf
export LANG=pt_BR.UTF-8

nano /etc/modprobe.d/nobeep.conf
# prevent load of pcspkr module on boot
# blacklist pcspkr

mkinitcpio -p linux


echo "1.6 Timezone setup:"

timedatectl set-ntp true
ln -sf /usr/share/zoneinfo/Brazil/East /etc/localtime
hwclock --systohc --utc
date


echo "1.7 Network setup:"
hostnamectl set-hostname Inspiron

nano /etc/hosts
# 127.0.1.1     localhost.localdomain   Inspiron

pacman -S base-devel fakeroot jshon expac grep sed curl tmux bash-completion openssh linux-headers linux-lts linux-lts-headers wpa_supplicant wireless_tools networkmanager network-manager-applet iw wpa_supplicant wpa_actiond dialog

systemctl enable sshd.service
systemctl enable NetworkManager.service
systemctl enable wpa_supplicant.service
systemctl enable bluetooth.service
systemctl disable dhcpcd.service

cp /etc/netctl/examples/ethernet-dhcp /etc/netctl
nano /etc/netctl/ethernet-dhcp
netctl list
netctl start ethernet-dhcp
netctl enable ethernet-dhcp
wifi-menu -o


echo "1.8 Root & User management:"
passwd 
gpasswd -a `id -un` network
useradd -m -g users -G wheel -s /bin/bash manoel
passwd manoel
EDITOR=nano visudo 
# %wheel ALL

exit 
umount -R /mnt
reboot


# -----------------------------------------------------------------------
# SYSTEM BOOTING FROM MAIN DISK
# -----------------------------------------------------------------------
localectl set-locale LANG="pt_BR.UTF-8"

setxkbmap -model pc104 -layout us_intl
echo '
setxkbmap -model pc104 -layout us_intl
' >> nano ~/.bashrc


sudo nano /etc/pacman.conf
[archlinuxfr]
SigLevel = Never
Server = http://repo.archlinux.fr/$arch
sudo pacman -Sy yaourt


mkdir ~/Downloads
cd ~/Downloads
#git clone https://github.com/erikdubois/archcinnamon
#git clone https://github.com/erikdubois/Aureola
git clone https://github.com/manoeldesouza/Cookbook

#sudo systemctl stop dhcpcd.service
#sudo systemctl start sshd.service
#sudo systemctl start wpa_supplicant.service
#sudo systemctl start NetworkManager.service
#sudo systemctl start bluetooth.service

sudo pacman -S xf86-input-libinput xorg-server xorg-xinit xorg-server-utils mesa 
sudo pacman -S xorg-twm xorg-xclock xterm
sudo pacman -S xf86-video-intel lib32-intel-dri lib32-mesa lib32-libgl

sudo pacman -S alsa-utils pulseaudio pulseaudio-bluetooth


#pacman -S nvidia nvidia-libgl xorg-xrandr nvidia-settings
#pacman -S xorg-xrandr

#sudo pacman -S pulseaudio pulseaudio-alsa pavucontrol alsa-utils alsa-plugins alsa-lib alsa-firmware


sudo pacman -S cinnamon nemo-fileroller gnome-keyring

# sudo pacman –S mdm-display-manager
# sudo systemctl start mdm-service
# sudo systemctl enable mdm-service

# sudo pacman –S mdm-display-manager
#sudo systemctl start gdm.service
#sudo systemctl enable gdm.service



#sudo pacman -S cups cups-pdf ghostscript gsfonts libcups hplip system-config-printer
#sudo systemctl enable org.cups.cupsd.service
#sudo systemctl start org.cups.cupsd.service


yaourt -S pamac-aur

sudo pacman -S gnome-terminal gedit gnome-system-monitor gnome-font-viewer gnome-screenshot galculator geary gparted net-tools gpick grsync hardinfo hddtemp hexchat htop nemo nemo-share nemo-fileroller noto-fonts gthumb evince gvfs-afc gvfs-goa gvfs-google gvfs-gphoto2 gvfs-mtp gvfs-nfs gvfs-smb jre7-openjdk

sudo pacman -S a52dec faac faad2 flac jasper lame libdca libdv libmad libmpeg2 libtheora libvorbis libxv wavpack x264 xvidcore 

sudo pacman -S gst-plugins-good gst-plugins-bad gst-plugins-base gst-plugins-ugly gstreamer

sudo pacman -S firefox flashplugin chromium clementine conky darktable dconf-editor filezilla galculator geany gimp gksu glances inkscape inxi lm_sensors lsb-release meld mlocate mpv notify-osd numlockx openshot plank polkit-gnome redshift ristretto sane screenfetch scrot shotwell simple-scan simplescreenrecorder smplayer sysstat terminator transmission-cli transmission-gtk tumbler variety vnstat unclutter libreoffice vlc rhythmbox dropbox smbclient samba

sudo pacman -S faenza-icon-theme faience-icon-theme arc-icon-theme arc-gtk-theme 


sudo pacman -S virtualbox virtualbox-host-modules virtualbox-guest-iso
sudo gpasswd -a $USER vboxusers
yaourt -S virtualbox-extension-pack
sudo modprobe vboxdrv
sudo modprobe -a vboxnetadp vboxnetflt
sudo nano /etc/modules-load.d/virtualbox.conf
 vboxdrv
 vboxnetadp
 vboxnetflt

yaourt -S ttf-ms-fonts 
yaourt -S mint-x-theme mint-y-theme moka-icon-theme faba-icon-theme 







#  http://turlucode.com/arch-linux-install-guide-step-2-desktop-environment-installation/


