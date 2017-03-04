



loadkeys br-abnt2
systemctl start dhcpd

Pacman -Sy terminus-font git reflector
setfont ter-v16n

Pacman -Sy reflector
nano /etc/pacman.d/mirrorlist



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

pacstrap /mnt base base-devel

genfstab -U /mnt >> /mnt/etc/fstab
nano /mnt/etc/fstab
# /dev/sda2  none swap defaults 0 0



achroot /mnt
bootctl install

cd /boot
ls -l

cd loader
nano loader.conf
# default arch
# timeout 4

cd entries
nano arch.conf
# title Arch Linux
# linux /vmlinuz-linux
# initrd /intramfs-linux.img
# option root=/dev/sda3 rw

nano /etc/locale.gen
locale-gen

echo LANG=pt_BR.UTF-8 > /etc/locale.conf
export LANG=pt_BR.UTF-8

nano /etc/vconsole.conf

nano /etc/modprobe.d/nobeep.conf
# prevent load of pcspkr module on boot
# blacklist pcspkr

mkinitcpio -p linux

timedatectl set-ntp true
ln -sf /usr/share/zoneinfo/Brazil/East /etc/localtime
hwclock --systohc --utc
date


echo Inspiron > /etc/hostname

nano /etc/hosts
# 127.0.1.1     localhost.localdomain   Inspiron

pacman –S net-tools unzip unrar p7zip 

systemctl enable dhcpd
systemctl start dhcpd
systemctl status dhcpd
passwd


useradd -m -g users -G wheel -s /bin/bash manoel
passwd manoel

EDITOR=nano visudo 
# %wheel ALL
 

exit 
umount -R /mnt
reboot


git clone https://github.com/erikdubois/archcinnamon

pacman -S alsa-utils pulseaudio
pacman -S xorg-server xorg-xinit xorg-utils xorg-server-utils mesa
pacman -S xf86-video-intel 
pacman -S xorg-twm xterm xorg-xclock Pacman -Sy terminus-font git reflector

pacman -S cinnamon nemo-fileroller

pacman –S mdm-display-manager
systemctl start mdm-service
systemctl enable mdm-service

pacman -S network-manager-applet
systemctl start NetworkManager
systemctl enable NetworkManager

pacman -S pulseaudio pulseaudio-alsa pavucontrol gnome-terminal gedit gnome-system-monitor
pacman -S firefox flashplugin vlc chromium pidgin skype deluge smplayer audacious qmmp gimp xfburn thunderbird

pacman -S a52dec faac faad2 flac jasper lame libdca libdv libmad libmpeg2 libtheora libvorbis libxv wavpack x264 xvidcore gstreamer0.10-plugins
pacman -S libreoffice

pacman -R package-to-remove



