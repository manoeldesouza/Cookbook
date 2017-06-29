
#	https://www.raspberrypi.org/documentation/installation/installing-images/linux.md
#	http://kedei.net/raspberry/raspberry.html

#	http://raspberrypituts.com/raspberry-pi-django-tutorial-2017/
#	https://www.raspberrypi.org/documentation/remote-access/web-server/apache.md
#	https://www.raspberrypi.org/documentation/remote-access/ssh/README.md



sudo adduser manoel
sudo visudo
 manoel   ALL = NOPASSWD: ALL


sudo nano /etc/wpa_supplicant/wpa_supplicant.conf
 network={
     ssid="testing"
     psk="testingPassword"
 }
sudo wpa_cli reconfigure
ifconfig wlan0
ip addr

cd ~
wget http://kedei.net/raspberry/v6_1/LCD_show_v6_1_3.tar.gz

sudo apt-get update
sudo apt-get upgrade

sudo raspi-config

sudo apt-get install mc

sudo mkdir /media/Downloads
sudo chown -R manoel:manoel /media/Downloads 
sudo chmod ugo+w /media/Downloads
sudo mkdir /media/Share
sudo chown -R manoel:manoel /media/Share
sudo chmod ugo+w /media/Share


#	https://www.raspberrypi.org/magpi/samba-file-server/
sudo apt-get install samba samba-common-bin
sudo mkdir /media/Share
sudo nano /etc/samba/smb.conf
sudo smbpasswd -a manoel


#	https://cyberstrikerblog.wordpress.com/2015/12/28/raspberry-pi-model-b-rpimonitor-shellinabox/
sudo apt-get install shellinabox
sudo nano /etc/default/shellinabox


#	https://melgrubb.com/2016/12/11/rphs-v2-transmission/
#	https://www.raspberrypi.org/forums/viewtopic.php?t=135320&p=900555
sudo apt-get install transmission-daemon
sudo service transmission-daemon stop
sudo nano /etc/transmission-daemon/settings.json
sudo service transmission-daemon start
#sudo nano /lib/systemd/system/transmission-daemon.service
# After=dhcpcd.service
# After=network-online.target

sudo nano /etc/rc.local
 sleep 10
 sudo service transmission-daemon reload


#	https://www.raspberrypi.org/learning/lamp-web-server-with-wordpress/worksheet/
sudo apt-get update && sudo apt-get -y dist-upgrade 
sudo apt-get install apache2
sudo apt-get install php5 libapache2-mod-php5
sudo apt-get install mysql-server php5-mysql


#	http://pt.wikihow.com/Criar-um-Servidor-Web-Raspberry-Pi
sudo apt-get install vsftpd
sudo nano /etc/vsftpd.conf


