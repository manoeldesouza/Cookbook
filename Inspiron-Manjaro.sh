



# Basic preparation
# -----------------------
sudo pacman -Syu
sudo pacman -S git
yaourt -S gnome-shell-extension-pixel-saver gnome-shell-extension-mediaplayer-git gnome-shell-extension-arch-update
yaourt -S gnome-shell-extension-topicons-plus-git
sudo pacman -S gparted mc git wget dkms fuse exfat-utils smartmontools hddtemp htop lynx terminator tmux tilix elinks dconf-editor



# Console setup
# -----------------------
echo "Adding Powerline..."
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



# Gnome Desktop setup
# -----------------------
sudo pacman -S ttf-dejavu ttf-droid
yaourt -S fontconfig-ttf-ms-fonts

yaourt -S gnome-shell-extension-pixel-saver gnome-shell-extension-mediaplayer-git gnome-shell-extension-arch-update
yaourt -S gnome-shell-extension-topicons-plus-git

sudo pacman -S faenza-icon-theme faience-icon-theme arc-gtk-theme arc-icon-theme 
yaourt -S mint-y-theme moka-icon-theme faba-icon-theme paper-icon-theme paper-gtk-theme-git

sudo nano /usr/share/themes/Arc/index.theme
# [Icon Theme]
# Name=Arc
# Inherits=Moka,Adwaita,gnome,hicolor
# Comment=Arc Icon theme

yaourt -S iio-sensor-proxy
yaourt -S mintstick-git


# Applications installation
# -----------------------
sudo pacman -S chromium geany inkscape stellarium cheese rhythmbox scribus blender docky shotwell digikam dia cups-pdf evolution bluefish gimp darktable gnome-music conky conky-manager vlc filezilla epiphany geary gnome-multi-writer simple-scan dropbox eog gparted totem youtube-dl octave

yaourt -S wps-office ttf-wps-fonts
yaourt -S entangle gradio mysql-workbench
yaourt -S tilix



# Servers installation
# -----------------------
sudo pacman -S openssh

#	https://wiki.archlinux.org/index.php/MySQL
yaourt -S mysql
sudo mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
sudo systemctl start mariadb
sudo systemctl enable mariadb
mysql_secure_installation
	CREATE USER 'manoel'@'localhost' IDENTIFIED BY 'some_pass';
	GRANT ALL PRIVILEGES ON mydb.* TO 'manoel'@'localhost';
	FLUSH PRIVILEGES;
	quit
	

# i3 Window Manager installation
# -----------------------
sudo pacman -S i3 i3-manjaro



# Programming
# -----------------------
sudo pip install virtualenv
sudo pacman -S python-setuptools
sudo pacman -S python-wheel
sudo pacman -S python-virtualenv

yaourt -S sublime-text-dev
yaourt -S brackets
yaourt -S pycharm-community

sudo pacman -S python-django
yaourt -S django-docs
yaourt -S python-mysqlclient



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

sudo mkdir /usr/local/MATLAB
sudo mkdir /usr/local/MATLAB/R2016b
sudo chown -R manoel:users /usr/local/MATLAB

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



# Data Science Tools: Anaconda
# -----------------------
wget https://repo.continuum.io/archive/Anaconda3-4.3.1-Linux-x86_64.sh
chmod ugo+x Anaconda3-4.3.1-Linux-x86_64.sh
./Anaconda3-4.3.1-Linux-x86_64.sh

sudo curl https://upload.wikimedia.org/wikipedia/en/c/cd/Anaconda_Logo.png -o /usr/share/icons/anaconda.png
sudo echo '
#!/usr/bin/env xdg-open
[Desktop Entry]
Type=Application
Icon=/usr/share/icons/anaconda.png
Name=Anaconda Navigator
Comment=Anaconda Navigator
Exec=anaconda-navigator
Categories=Development;
MimeType=text/x-anaconda;
' >  /usr/share/applications/anaconda.desktop
