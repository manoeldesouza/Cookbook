


# Basic preparation
# -----------------------
sudo apt install git
git clone https://github.com/manoeldesouza/cookbook
sudo apt-get update && sudo apt-get upgrade -y



# Additional repositories
# -----------------------
sudo apt-add-repository -y ppa:webupd8team/brackets
sudo apt-add-repository -y ppa:moka/daily
sudo apt-add-repository -y ppa:snwh/pulp
sudo apt-add-repository -y ppa:numix/ppa
sudo apt-add-repository -y ppa:noobslab/icons
sudo apt-add-repository -y ppa:noobslab/themes
sudo add-apt-repository -y ppa:teejee2008/ppa
sudo add-apt-repository -y ppa:danielrichter2007/grub-customizer
sudo add-apt-repository -y ppa:dawidd0811/neofetch
sudo add-apt-repository -y ppa:webupd8team/terminix
sudo add-apt-repository -y ppa:haecker-felix/gradio-daily
sudo add-apt-repository ppa:viktor-krivak/pycharm



# Basic applications
# -----------------------
sudo apt-get install -y gparted mc git build-essential linux-headers-generic linux-headers-$(uname -r) dkms fuse exfat-fuse exfat-utils ubuntu-restricted-extras software-properties-common smartmontools hddtemp tasksel htop lynx-cur terminator gddrescue htop tmux elinks vim emacs neofetch tilix ppa-purge gdebi-core




# Terminal customization
# -----------------------
echo "
neofetch
" >> ~/.bashrc

sudo apt-get install -y python-pip python-setuptools
sudo pip install git+git://github.com/Lokaltog/powerline
wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
sudo mv PowerlineSymbols.otf /usr/share/fonts/X11/misc
sudo fc-cache -vf
sudo mv 10-powerline-symbols.conf /etc/fonts/conf.d/
echo '
#export TERM=”screen-256color”
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. /usr/local/lib/python2.7/dist-packages/powerline/bindings/bash/powerline.sh
' >> ~/.bashrc



# Terminal customization
# -----------------------
sudo apt-get install -y unace p7zip-rar sharutils rar arj lunzip lzip cabextract p7zip unrar xz-utils

sudo apt-get install -y moc



# Network tools
# -----------------------
sudo apt-get install -y aircrack-ng dsniff driftnet etherwake wireshark iptraf traceroute inetutils-tools



# Server tools
# -----------------------
sudo apt-get install -y openssh-server nfs-common



# Virtualization tools
# -----------------------
sudo apt-get install -y qemu-system qemu-kvm libvirt-bin ubuntu-vm-builder bridge-utils libswitch-perl qemu-utils virt-viewer gir1.2-spice-client-gtk-3.0 virtualbox virtualbox-qt virt-manager
sudo adduser `id -un` libvirtd
sudo adduser `id -un` kvm
sudo adduser `id -un` vboxusers
sudo systemctl enable libvirtd
sudo systemctl start libvirtd


# Dektop applications
# -----------------------
sudo apt-get install -y geany inkscape stellarium cheese shutter rhythmbox scribus blender darktable gnome-music shotwell digikam dia cups-pdf evolution chromium-browser gimp tomahawk musique pitivi ttf-mscorefonts-installer gradio



# WPS Office
# -----------------------
#	http://wps-community.org/downloads

wget http://ftp.us.debian.org/debian/pool/main/libp/libpng/libpng12-0_1.2.50-2+deb8u3_amd64.deb
wget http://kdl.cc.ksosoft.com/wps-community/download/fonts/wps-office-fonts_1.0_all.deb
wget http://kdl.cc.ksosoft.com/wps-community/download/a21/wps-office_10.1.0.5672~a21_amd64.deb

sudo gdebi libpng12-0_1.2.50-2+deb8u3_amd64.deb 
sudo gdebi wps-office_10.1.0.5672~a21_amd64.deb
sudo gdebi wps-office-fonts_1.0_all.deb

wget https://www.dropbox.com/s/lfy4hvq95ilwyw5/wps_symbol_fonts.zip
extract to ~/.fonts

sudo mkdir -p /usr/share/fonts/wps-office
cd /usr/share/fonts/wps-office
sudo git clone https://github.com/udoyen/wps-fonts
#sudo wget https://dl.dropboxusercontent.com/u/31525164/wps_symbol_fonts.zip
#sudo unzip wps_symbol_fonts.zip
sudo fc-cache -vf
cd ~/Downloads/



# Gnome Games
# -----------------------
sudo apt-get install -y gbrainy gnome-games gnome-chess



# Desktop customization
# -----------------------
sudo apt-get install -y numix-icon-theme numix-icon-theme-circle numix-icon-theme-square numix-gtk-theme moka-icon-theme faba-icon-theme faba-mono-icons paper-icon-theme paper-gtk-theme paper-cursor-theme faenza-icon-theme faience-icon-theme arc-theme arc-icons



# Programming tools
# -----------------------
sudo apt-get install -y perl-doc libdbd-mysql-perl mysql-workbench bluefish brackets 

sudo apt-get install -y python-pip python-dev ipython ipython3 python-setuptools python3-setuptools python-virtualenv python3-virtualenv python3-pip python3-dev libxml2-dev libxslt-dev libffi-dev libssl-dev libxml2-dev libxslt1-dev libjpeg8-dev zlib1g-dev linuxbrew-wrapper python3-tk python-tk virtualenv 

#	http://ubuntuhandbook.org/index.php/2017/06/install-pycharm-professional-ubuntu-16-04-17-04/
sudo apt install -y pycharm


