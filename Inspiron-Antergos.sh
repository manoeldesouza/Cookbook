#!/bin/bash

echo "
      Script: Antergos Linux 17.2 Recipe (for Inspiron 13 - 7353)
      Author: Manoel de Souza
      E-Mail: msouza.rj@gmail.com      
     Version: 1.0.0
        Date: 01-Mar-2017
"

cd ~/Downloads
sudo echo "Enter root password to start:"


echo "Updating & upgrading..."
sudo pacman -Syu


echo "Installing System Utilities..."
sudo pacman -S gparted mc git wget dkms fuse exfat-utils smartmontools hddtemp htop lynx-cur terminator htop


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


echo "Change default console font to Terminus"
sudo nano /etc/vconsole.conf


echo "Installing Archive Utilities..."
sudo pacman -S unace sharutils arj lzip cabextract p7zip unrar


echo "Installing Networking Utilities..."
#sudo pacman -S aircrack-ng dsniff driftnet etherwake wireshark iptraf
sudo pacman -S wireshark-cli wireshark-gtk


echo "Installing Server tools..."
#sudo pacman -S openssh-server nfs-common 


echo "Installing Virtualization Utilities..."
sudo pacman -S virtualbox dropbox virt-manager qemu libvirt
sudo usermod -aG libvirtd,kvm,vboxusers `id -un`


echo "Installing Desktop applications..."
#sudo apt-get install -y skype dropbox geany inkscape stellarium cheese shutter rhythmbox scribus blender darktable gnome-music shotwell digikam dia cups-pdf evolution chromium-browser gimp tomahawk musique wine playonlinux
sudo pacman -S geany inkscape stellarium cheese rhythmbox scribus blender docky shotwell digikam dia cups-pdf evolution bluefish gimp tomahawk darktable gnome-music conky conky-manager vlc filezilla


echo "Installing Desktop utilities..."
#sudo apt-get install -y conky-all conky conky-manager docky mint-backgrounds-* ttf-mscorefonts-installer pitivi
sudo pacman -S antergos-wallpapers-extra


echo "Installing Games..."
#sudo apt-get install -y gbrainy gnome-games stella gnome-chess
sudo pacman -S gbrainy stella gnome-chess 


echo "Installing Icon & GTK themes..."
#sudo apt-get install -y numix-icon-theme numix-icon-theme-circle numix-icon-theme-square numix-gtk-theme moka-icon-theme faba-icon-theme faba-mono-icons paper-icon-theme paper-gtk-theme paper-cursor-theme faenza-icon-theme faience-icon-theme arc-theme arc-icons
sudo pacman -S faenza-icon-theme faience-icon-theme arc-gtk-theme arc-icon-theme



echo "Installing Programming Utilities..."
#sudo apt-get install -y perl-doc libdbd-mysql-perl mysql-workbench sublime-text bluefish brackets 


echo "Python Utilities..."
#sudo apt-get install -y python-pip python-dev ipython ipython-doc ipython-notebook ipython3 ipython3-notebook python-setuptools python3-setuptools python-virtualenv python3-virtualenv


echo "Installing standard Data Science tools..."
#sudo apt-get install -y r-base r-base-dev r-cran-littler r-base-core octave scilab weka weka-doc 
#sudo apt-get install -y python-numpy python-numpy-doc python-numpy-dbg python3-numpy python3-numpydoc python3-numpy-dbg python-bs4 python3-bs4 python-sklearn python3-sklearn python-sklearn-doc python-sklearn-pandas python3-sklearn-pandas python-pandas python3-pandas python-django python3-django

#sudo echo "deb http://cran.rstudio.com/bin/linux/ubuntu xenial/" | sudo tee -a /etc/apt/sources.list
#sudo gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9
#sudo gpg -a --export E084DAB9 | sudo apt-key add -
#sudo apt-get update
#sudo apt-get install r-base r-base-dev
#wget https://download1.rstudio.org/rstudio-1.0.136-amd64.deb
#sudo gdebi -n rstudio-1.0.136-amd64.deb
#rm rstudio-1.0.136-amd64.deb


#pip install -U scikit-learn
#pip install django
#pip install pandas
#pip install setuptools
#pip install wheel
#pip install seaborn
#pip install pandas-datareader
#pip install quandl


echo "Installing Anaconda Data Science tools..."
#wget https://download1.rstudio.org/rstudio-1.0.136-amd64.deb
#wget https://repo.continuum.io/archive/Anaconda3-4.3.0-Linux-x86_64.sh
#bash Anaconda3-4.3.0-Linux-x86_64.sh
#conda install -c r r-essentials -c r ipython-notebook r-irkernel html5lib
#conda install pandas-datareader quandl


echo "Installing I3 window manager..."
sudo pacman -S i3 i3-wm dmenu i3status i3lock


#sudo apt-get install -y tlp
#sudo tlp start

echo '
Additional activities:
 - Setup weather applet
 - Configure workspace hover
 - Configure Dropbox
 - Configure Virtualbox extension pack
 - Download Virtualbox guest additions
 - Install Mathlab
 - Download Itaú 
' >> next_steps.txt

echo "Installation complete. Rebooting..."
#sudo reboot


 



sudo pacman -S octave r
wget https://repo.continuum.io/archive/Anaconda3-4.3.0-Linux-x86_64.sh
bash Anaconda3-4.3.0-Linux-x86_64.sh

sudo pacman -S pitivi

#AUR:
rstudio moka arc-gtk-theme arc-icon-theme faba-icon-theme mint-x-theme mint-y-theme 