#!/bin/bash

echo "
      Script: Linux Mint 18 Recipe (for Inspiron 13 - 7353)
      Author: Manoel de Souza
      E-Mail: msouza.rj@gmail.com      
     Version: 1.0.0
        Date: 01-Mar-2017
"

'

https://wiki.archlinux.org/index.php/Installation_guide
http://lifehacker.com/5680453/build-a-killer-customized-arch-linux-installation-and-learn-all-about-linux-in-the-process
https://www.ostechnix.com/install-arch-linux-latest-version/
https://www.ostechnix.com/arch-linux-2016-post-installation/

https://turlucode.com/arch-linux-install-guide-step-1-basic-installation/
http://turlucode.com/arch-linux-install-guide-step-2-desktop-environment-installation/#GNOME

'


cd ~/Downloads
sudo echo "Enter root password to start:"


echo "1.1 Preparation:"
pacman -Sy terminus-font
setfont ter-v16n
wifi-menu -o


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

mount /dev/sda3 /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot


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


echo "1.4 Install bootloader (grub - Not tested):"
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

pacman -S git wget reflector mc vim lynx elinks
 
reflector -c BR > /etc/pacman.d/mirrorlist 
nano /etc/pacman.d/mirrorlist
# uncomment Multilib

sudo pacman -S p7zip unace unrar zip unzip sharutils uudeview arj cabextract file-roller



nano /etc/locale.gen
locale-gen
echo LANG=pt_BR.UTF-8 > /etc/locale.conf
export LANG=pt_BR.UTF-8

localectl set-keymap --no-convert br-latin1-us  

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

pacman -S base-devel fakeroot jshon expac grep sed curl tmux bash-completion openssh linux-headers linux-lts linux-lts-headers wireless_tools networkmanager network-manager-applet iw wpa_supplicant wpa_actiond dialog

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


systemctl enable dhcpcd@<INTERFACE>.service
systemctl enable netctl-auto@<INTERFACE>.service


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
#echo '
#setxkbmap -model pc104 -layout us_intl
#' >> nano ~/.bashrc


sudo nano /etc/pacman.conf

[archlinuxfr]
SigLevel = Never
Server = http://repo.archlinux.fr/$arch

sudo pacman -Sy yaourt customizepkg rsync


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

sudo pacman -S xorg-server xorg-xinit xorg-server-utils
sudo pacman -S mesa 
sudo pacman -S xorg-twm xorg-xclock xterm
sudo pacman -S xf86-video-intel lib32-intel-dri lib32-mesa lib32-libgl

sudo pacman -S alsa-utils pulseaudio
sudo pacman -S alsa-oss alsa-lib
amixer sset Master unmute
speaker-test -c 2

sudo pacman -S moc

sudo pacman -S gnome gnome-extra

sudo pacman -S firefox chromium geany inkscape stellarium cheese rhythmbox scribus blender docky shotwell digikam dia cups-pdf evolution bluefish gimp darktable gnome-music conky conky-manager vlc filezilla epiphany geary gnome-multi-writer simple-scan dropbox eog terminator transmission-cli transmission-gtk gparted libreoffice

sudo pacman -S hdparm


yaourt -S pamac-aur
yaourt -S wps-office ttf-wps-fonts
yaourt -S brackets
yaourt -S entangle gradio mysql-workbench

sudo pacman -S gnome-shell-extensions
yaourt -S gnome-shell-extension-openweather-git gnome-shell-extension-pixel-saver gnome-shell-extension-mediaplayer-git

sudo pacman -S faenza-icon-theme faience-icon-theme arc-gtk-theme arc-icon-theme 
yaourt -S mint-x-theme mint-y-theme moka-icon-theme faba-icon-theme paper-icon-theme paper-gtk-theme-git

sudo pacman -S cinnamon nemo-fileroller gnome-keyring

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

yaourt -S neofetch
echo "
neofetch
" >> ~/.bashrc

yaourt -S tilix

sudo pacman -S openssh


yaourt -S rstudio-desktop	


sudo pacman -S i3 i3-wm dmenu i3status i3lock i3blocks


sudo wifi-menu -o

sudo echo "
Description='A basic DHCP Android Tethering'
Interface=enp0s20f0u1
Connection=ethernet
IP=dhcp
" > /etc/netctl/Android

sudo netctl start Android
sudo netctl enable Android

sudo pacman -S ifplugd

sudo systemctl enable netctl-ifplugd@Android.service



sudo echo "
Description='A basic DHCP for J5 Ethernet adapter'
Interface=enp0s20f0u2u4
Connection=ethernet
IP=dhcp
" > /etc/netctl/J5-Ethernet

sudo netctl start J5-Ethernet
sudo netctl enable J5-Ethernet

sudo pacman -S ifplugd

sudo systemctl enable netctl-ifplugd@J5-Ethernet.service




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


sudo pacman -S virtualbox virtualbox-host-modules virtualbox-guest-iso
sudo gpasswd -a $USER vboxusers
yaourt -S virtualbox-extension-pack
sudo modprobe vboxdrv
sudo modprobe -a vboxnetadp vboxnetflt
sudo nano /etc/modules-load.d/virtualbox.conf
 vboxdrv
 vboxnetadp
 vboxnetflt

yaourt -S ttf-ms-fonts mint-x-theme mint-y-theme moka-icon-theme faba-icon-theme 

sudo pacman -S i3 dmenu






#  http://turlucode.com/arch-linux-install-guide-step-2-desktop-environment-installation/
#  https://ramsdenj.com/2016/06/23/arch-linux-on-zfs-part-1-embed-zfs-in-archiso.html
#  https://ramsdenj.com/2016/06/23/arch-linux-on-zfs-part-2-installation.html
#  https://wiki.archlinux.org/index.php/Installing_Arch_Linux_on_ZFS
#  https://wiki.archlinux.org/index.php/systemd-boot
