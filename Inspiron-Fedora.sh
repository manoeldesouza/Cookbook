#!/bin/bash

echo "
      Script: Fedora (25) Recipe (for Inspiron 13 - 7353)
      Author: Manoel de Souza
      E-Mail: msouza.rj@gmail.com      
     Version: 1.0.0
        Date: 08-May-2017
"

'
Reference Links:

http://www.blogopcaolinux.com.br/2016/11/Guia-de-instalacao-do-Fedora-25-Workstation.html
http://www.blogopcaolinux.com.br/2016/11/Guia-de-pos-instalacao-do-Fedora-25-Workstation.html
https://www.tecmint.com/things-to-do-after-fedora-24-workstation-installation/
http://www.2daygeek.com/things-to-do-after-installing-fedora-25-workstation/
https://fedoramagazine.org/add-power-terminal-powerline/
http://www.blogopcaolinux.com.br/2016/09/instalando-oracle-java-jre-no-fedora.html
https://www.if-not-true-then-false.com/2010/install-virtualbox-with-yum-on-fedora-centos-red-hat-rhel/
http://www.fosslinux.com/919/install-wps-office-on-fedora.htm
https://code.visualstudio.com/docs/setup/linux
https://fedoramagazine.org/getting-started-i3-window-manager/
'


# Cookbook download
# -----------------------
cd ~/Downloads
git clone hhtps://github.com/manoeldesouza/cookbook



# Package Management
# -----------------------
sudo dnf install -y deltarpm
sudo dnf install -y nano
sudo dnf install -y yumex-dnf

su -c echo 'deltarpm=1' >> /etc/dnf/dnf.conf

sudo dnf update



# Core Utilities Management
# -----------------------
sudo dnf install -y p7zip p7zip-plugins lzip cabextract unrar unzip
sudo dnf install -y mc tmux bc

#sudo dnf install -y tilix
sudo dnf copr enable heikoada/terminix
sudo dnf install -y terminix gnome-terminal-nautilus


# RPM Fusion
# -----------------------
su -c 'dnf install http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm'
sudo rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-free-fedora-25

su -c 'dnf install http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm'
sudo rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-nonfree-fedora-25



# Codecs & Multimedia
# -----------------------
sudo dnf install gstreamer1-plugins-ugly gstreamer1-plugin-mpg123 mpg123-libs
sudo dnf install amrnb amrwb faad2 flac ffmpeg gpac-libs lame libfc14audiodecoder mencoder mplayer x264 x265 gstreamer-plugins-espeak gstreamer-plugins-fc gstreamer-rtsp gstreamer-plugins-good gstreamer-plugins-bad gstreamer-plugins-bad-free-extras gstreamer-plugins-bad-nonfree gstreamer-plugins-ugly gstreamer-ffmpeg gstreamer1-plugins-base gstreamer1-libav gstreamer1-plugins-bad-free-extras gstreamer1-plugins-bad-freeworld gstreamer1-plugins-base-tools gstreamer1-plugins-good-extras gstreamer1-plugins-ugly gstreamer1-plugins-bad-free gstreamer1-plugins-good

sudo rpm --import http://negativo17.org/repos/RPM-GPG-KEY-slaanesh
sudo dnf config-manager --add-repo=http://negativo17.org/repos/fedora-multimedia.repo
sudo dnf install -y libdvdcss

sudo dnf install -y vlc moc
sudo touch /etc/popt.d/empty_file



# Network & Internet
# -----------------------
sudo dnf install -y transmission chromium



# Development toolset
# -----------------------
sudo dnf groupinstall 'Development Tools'
sudo dnf groupinstall 'C Development Tools and Libraries'



# MySQL toolset
# -----------------------
sudo dnf install -y https://dev.mysql.com/get/mysql57-community-release-fc25-10.noarch.rpm
sudo dnf install -y mysql-workbench



# VisualStudio toolset
# -----------------------
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf check-update
sudo dnf install -y code



# Desktop customization
# -----------------------
sudo dnf install -y gnome-tweak-tool dconf-editor gtk3-devel

sudo dnf install -y arc-theme
git clone https://github.com/horst3180/arc-icon-theme --depth 1 && cd arc-icon-theme
./autogen.sh --prefix=/usr
sudo make install
cd ..

sudo dnf install -y gnome-shell-extension-media-player-indicator gnome-shell-extension-openweather

git clone https://github.com/phocean/TopIcons-plus.git
cd TopIcons-plus
make install
cd ..

git clone https://github.com/deadalnix/pixel-saver.git
cd pixel-saver
git checkout 1.9
cp -r pixel-saver@deadalnix.me -t ~/.local/share/gnome-shell/extensions
gnome-shell-extension-tool -e pixel-saver@deadalnix.me
cd ..

sudo dnf config-manager --add-repo http://download.opensuse.org/repositories/home:snwh:moka/Fedora_25/home:snwh:moka.repo
sudo dnf install -y moka-icon-theme

sudo dnf config-manager --add-repo http://download.opensuse.org/repositories/home:snwh:paper/Fedora_25/home:snwh:paper.repo
sudo dnf install -y paper-gtk-theme paper-icon-theme



# Neofetch
# -----------------------
sudo dnf copr enable konimex/neofetch
sudo dnf install -y neofetch
echo "
neofetch
" >> ~/.bashrc



# Power-line
# -----------------------
#	https://fedoramagazine.org/add-power-terminal-powerline/
sudo dnf install -y powerline
echo "

if [ -f `which powerline-daemon` ]; then
  powerline-daemon -q
  POWERLINE_BASH_CONTINUATION=1
  POWERLINE_BASH_SELECT=1
  . /usr/share/powerline/bash/powerline.sh
fi 
" >> ~/.bashrc



# Flash installation
# -----------------------
sudo rpm -ivh http://linuxdownload.adobe.com/adobe-release/adobe-release-x86_64-1.0-1.noarch.rpm
sudo rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-adobe-linux
sudo dnf install flash-plugin alsa-plugins-pulseaudio libcurl



# Java installation
# -----------------------
sudo dnf install -y java-openjdk icedtea-web



# Applications installation
# -----------------------
cd ~/Downloads
sudo dnf config-manager --add-repo https://copr.fedorainfracloud.org/coprs/mosquito/brackets/repo/fedora-25/mosquito-brackets-fedora-25.repo
sudo dnf config-manager --add-repo https://copr.fedorainfracloud.org/coprs/heikoada/gradio/repo/fedora-25/heikoada-gradio-fedora-25.repo

sudo dnf install -y nautilus-dropbox python-gpgme
sudo dnf install -y gimp gnome-multi-writer simple-scan youtube-dl geany inkscape stellarium cheese scribus blender shotwell digikam dia cups-pdf evolution bluefish darktable gnome-music conky conky-manager filezilla epiphany geary eog gparted octave entangle
sudo dnf install -y gradio


wget http://kdl.cc.ksosoft.com/wps-community/download/a21/wps-office-10.1.0.5672-1.a21.i686.rpm
sudo dnf install -y wps-office*.rpm
sudo rpm -i https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm

sudo mkdir -p /usr/share/fonts/wps-office
cd /usr/share/fonts/wps-office
sudo git clone https://github.com/udoyen/wps-fonts
#sudo wget https://dl.dropboxusercontent.com/u/31525164/wps_symbol_fonts.zip
sudo unzip wps_symbol_fonts.zip
sudo fc-cache -vf



# Virtualbox
# -----------------------
cd /etc/yum.repos.d/
sudo wget http://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo
sudo dnf update
sudo dnf install binutils gcc make patch libgomp glibc-headers glibc-devel kernel-headers kernel-devel dkms
sudo dnf install VirtualBox-5.1
sudo /usr/lib/virtualbox/vboxdrv.sh setup
usermod -a -G vboxusers `id -un`



# Virtual Manager
# -----------------------
su -c "dnf group install with-optional virtualization"
su -c "systemctl start libvirtd"
su -c "systemctl enable libvirtd"
sudo usermod -aG libvirtd,kvm `id -un`



# i3 Window Manager
# -----------------------
#	https://fedoramagazine.org/getting-started-i3-window-manager/
sudo dnf install -y i3 i3status dmenu i3lock xbacklight feh conky



# Matlab
# -----------------------
sudo mkdir /usr/local/MATLAB
sudo mkdir /usr/local/MATLAB/R2016b
sudo chown -R manoel:manoel /usr/local/MATLAB

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



# Anaconda
# -----------------------
sudo dnf install -y gcc-fortran
cd ~/Downloads
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

#conda install conda-build
conda install -c r r-essentials
conda install -c r r-e1071=1.6_7



# Canopy
# -----------------------
https://store.enthought.com/downloads/installer/17/



# Wireshark
# -----------------------
#	https://fedoramagazine.org/how-to-install-wireshark-fedora/
sudo dnf install wireshark-qt
sudo usermod -a -G wireshark manoel



# Powertop
# -----------------------
#	https://fedoramagazine.org/saving-laptop-power-with-powertop/
sudo dnf install powertop
sudo systemctl start powertop.service
sudo systemctl enable powertop.service



