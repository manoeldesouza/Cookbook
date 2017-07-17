#!/bin/bash

echo "
      Script: Arch Linux (2017-05) Recipe (for Inspiron 13 - 7353)
      Author: Manoel de Souza
      E-Mail: msouza.rj@gmail.com      
     Version: 3.0.0
        Date: 07-Jul-2017
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



# Cookbook download
# -----------------------
cd ~/Downloads
git clone https://github.com/manoeldesouza/cookbook



# Network temporary setup
# -----------------------
wifi-menu -o



# Terminal font
# -----------------------
pacman -Syu terminus-font
setfont ter-v16n


# Closest Mirror
# -----------------------
pacman -S reflector rsync
reflector --latest 20 --country 'Brazil'  --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist



# Disk setup
# -----------------------
sgdisk --zap /dev/sda
sgdisk --new 0:0:+512M --typecode 0:ef00  --change-name 0:"EFI System" /dev/sda 
sgdisk --new 0:0:0     --typecode 0:8300  --change-name 0:"Linux Root" /dev/sda 
sgdisk --print /dev/sda

mkfs.fat -F32 -n BOOT /dev/sda1
mkfs.ext4 /dev/sda2

mount /dev/sda2 /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot

fallocate -l 8G /swapfile
dd if=/dev/zero of=/swapfile bs=1M count=512
chmod 600 /swapfile
nano /etc/sysctl.d/99-sysctl.conf
 vm.swappiness=10
mkswap /swapfile
swapon /swapfile



# Basic system installation
# -----------------------
pacstrap -i /mnt base base-devel
genfstab -U /mnt >> /mnt/etc/fstab

nano /mnt/etc/fstab
# /dev/sda2  none swap defaults 0 0
# add discard to /



# Timezone setup
# -----------------------
timedatectl set-ntp true
timedatectl set-timezone Brazil/East
ln -sf /usr/share/zoneinfo/Brazil/East /etc/localtime
hwclock --systohc --utc
date



# Locale setup
# -----------------------
nano /etc/locale.gen
# Uncomment   pt_BR.UTF-8

locale-gen
echo LANG=pt_BR.UTF-8 > /etc/locale.conf
export LANG=pt_BR.UTF-8

localectl set-keymap --no-convert br-latin1-us  
localectl set-locale LANG="pt_BR.UTF-8"



# Font setup
# -----------------------
pacman -S terminus-font
setfont ter-v16n

echo "
FONT=ter-v16n
" >  /etc/vconsole.conf



# Network setup
# -----------------------
hostnamectl set-hostname Inspiron
nano /etc/hostname
nano /etc/hosts
# 127.0.0.1     localhost.localdomain   localhost Inspiron
# 127.0.1.1     localhost.localdomain   Inspiron

# systemctl enable dhcpcd@"your eth device name".service
#systemctl enable dhcpcd@wlp1s0.service
systemctl enable systemd-networkd
systemctl enable systemd-resolved
systemctl enable systemd-timesyncd

pacman -S iw wpa_supplicant 
systemctl enable wpa_supplicant@wlp1s0.service

echo '
[Match]
Name=en*

[Network]
DHCP=ipv4

' > /etc/systemd/network/en.network

echo '
[Match]
Name=wl*

[Network]
DHCP=ipv4

' > /etc/systemd/network/wl.network



# LTS Kernel setup
# -----------------------
pacman -S linux-lts linux-lts-headers


	
# Initial ramdisk 
# -----------------------
mkinitcpio -p linux



# Boot loader installation
# -----------------------
arch-chroot /mnt

bootctl install

echo "
default arch
timeout 4
editor 0
" > /boot/loader/loader.conf

echo "
title Arch Linux
linux /vmlinuz-linux-lts
initrd /intramfs-linux-lts.img
options root=/dev/sda2 rw
" > /boot/loader/entries/arch.conf



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



# Terminal utilities
# -----------------------
pacman -S mc vim lynx elinks gdisk hdparm tmux bash-completion ntfs-3g


reboot


