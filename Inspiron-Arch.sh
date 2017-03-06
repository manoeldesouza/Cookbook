

loadkeys br-abnt2
systemctl start dhcpd

Pacman -Sy terminus-font git reflector
setfont ter-v16n

Pacman -Sy reflector
nano /etc/pacman.d/mirrorlist


# DISK

ls /sys/firmware/efi
ls /sys/firmware/efi/efivars

gdisk /dev/sda
# o (clear)
# n 
# GUID EF00
gdisk -l /dev/sda

mkfs.fat -F32 -n BOOT /dev/sda1
mkfs.ext4 /dev/sda2
mkswap -L  swap /dev/sda3 && swapon /dev/sda3
swapon -s
free -h

mount /mnt /dev/sda2
mkdir /mnt/boot
mount /mnt/boot /dev/sda1

pacstrap /mnt base base-devel

genfstab -U /mnt >> /mnt/etc/fstab
nano /mnt/etc/fstab
# /dev/sda2  none swap defaults 0 0

achroot /mnt


# BOOTLOADER (SYSTEMD)

bootctl install

cd /boot
ls -l

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


# BOOTLOADER (GRUB)
pacman -S grub os-prober efibootmgr
mkdir /boot/efi
mount /dev/sda2 /boot/efi

grub-install /dev/sda
grub-install --efi-directory=/boot/efi /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg




nano /etc/locale.gen
locale-gen

echo LANG=pt_BR.UTF-8 > /etc/locale.conf
export LANG=pt_BR.UTF-8

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

pacman –S net-tools
systemctl enable dhcpd
systemctl start dhcpd
systemctl status dhcpd
passwd
 

exit 
umount -R /mnt
reboot

# -----------------------------------------------------------------------

mkdir ~/Downloads

useradd -m -g users -G wheel -s /bin/bash manoel
passwd manoel

EDITOR=nano visudo 
# %wheel ALL


cp /etc/netctl/examples/ethernet-dhcp /etc/netctl
nano /etc/netctl/ethernet-dhcp
netctl list
netctl start ethernet-dhcp
netctl enable ethernet-dhcp


pacman -Sy dialog wpa_supplicant
wifi-menu -o

mkdir ~/Downloads
cd ~/Downloads
git clone https://github.com/erikdubois/archcinnamon
git clone https://github.com/manoeldesouza/Cookbook

sudo pacman -S terminus-font
nano /etc/vconsole.conf
# FONT=ter-v16n

sudo pacman -S git wget git reflector mc vim lynx base-devel fakeroot jshon expac grep sed curl tmux
sudo reflector -c BR
sudo nano /etc/pacman.d/mirrorlist

? yaourt packer 

sudo pacman -S p7zip unace unrar zip unzip sharutils uudeview arj cabextract file-roller



pacman -S alsa-utils pulseaudio pulseaudio-bluetooth
pacman -S xorg-server xorg-xinit xorg-server-utils xorg-twm xorg-xclock xterm
pacman -S mesa
#pacman -S nvidia nvidia-libgl xorg-xrandr nvidia-settings
pacman -S xorg-xrandr


sudo pacman -S pulseaudio pulseaudio-alsa pavucontrol alsa-utils alsa-plugins alsa-lib alsa-firmware
sudo pacman -S gst-plugins-good gst-plugins-bad gst-plugins-base gst-plugins-ugly gstreamer
sudo pacman -S xorg-server xorg-utils xorg-xinit xorg-twm xorg-xclock xorg-server-utils mesa xterm
sudo pacman -S xf86-video-intel 

sudo pacman -S cinnamon nemo-fileroller network-manager-applet


sudo pacman -S wpa_supplicant wireless_tools networkmanager network-manager-applet gnome-keyring
sudo systemctl enable NetworkManager.service
sudo systemctl enable wpa_supplicant.service
sudo systemctl disable dhcpcd.service
sudo systemctl stop dhcpcd.service
gpasswd -a `id -un` network
sudo systemctl start wpa_supplicant.service
sudo systemctl start NetworkManager.service
sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service


sudo pacman -S iw wpa_supplicant dialog network-manager-applet networkmanager
sudo pacman -S xf86-input-libinput
sudo systemctl enable NetworkManager.service
sudo systemctl enable gdm.service


sudo systemctl start NetworkManager
sudo systemctl enable NetworkManager

? sudo pacman –S mdm-display-manager
? sudo systemctl start mdm-service
? sudo systemctl enable mdm-service

sudo pacman -S cups cups-pdf ghostscript gsfonts libcups hplip system-config-printer
sudo systemctl enable org.cups.cupsd.service
sudo systemctl start org.cups.cupsd.service

sudo pacman -S gnome-terminal gedit gnome-system-monitor gnome-font-viewer gnome-screenshot galculator geary gparted net-tools gpick grsync hardinfo hddtemp hexchat htop nemo nemo-share nemo-fileroller noto-fonts
sudo pacman -S a52dec faac faad2 flac jasper lame libdca libdv libmad libmpeg2 libtheora libvorbis libxv wavpack x264 xvidcore gstreamer0.10-plugins


sudo pacman -S firefox flashplugin chromium audacious clementine conky darktable dconf-editor filezilla galculator geary gimp gksu glances inkscape inxi lm_sensors lsb-release meld mlocate mpv net-tools notify-osd numlockx openshot pinta plank polkit-gnome redshift ristretto sane screenfetch scrot shotwell simple-scan simplescreenrecorder smplayer sysstat terminator thunar transmission-cli transmission-gtk tumbler variety vnstat unclutter libreoffice

