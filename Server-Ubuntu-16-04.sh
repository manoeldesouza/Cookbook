#!/bin/bash

echo "############################################################################################################"
echo "# About:                                                                                                   #"
echo "# ======                                                                                                   #"
echo "# Author: Manoel de Souza                                                                                  #"
echo "# Email: msouza.rj@gmail.com                                                                               #"
echo "# Device: Turbina (HP ML 110 Gen 9) virtualized under Promo 5.0                                            #"
echo "# OS: Ubuntu Server 16.04.2                                                                                #"
echo "# Date: 16-Oct-2016                                                                                        #"
echo "#                                                                                                          #"
echo "############################################################################################################"

# Notes for the System installation:
#
# 1. Select the second shown interface as primary
# 2. Select sdg (Sandisk 32Gb pendrive) as destination (Use full disk - No LVM)
# 3. Select Samba File Server, Virtual Machine Host & OpenSSH server in software





qm set 100 -virtio1 /dev/disk/by-id/ata-ST2000DM001-1CH164_W1E5GSTZ
qm set 100 -virtio2 /dev/disk/by-id/ata-ST2000DM001-1ER164_Z4Z4NWA7
qm set 100 -virtio3 /dev/disk/by-id/ata-ST2000DM006-2DM164_Z560B3K5
qm set 100 -virtio4 /dev/disk/by-id/ata-ST2000DM006-2DM164_Z4Z64R28
qm set 100 -virtio6 /dev/disk/by-id/ata-MB1000GCWCV_Z1W4HCWD


nano /etc/pve/qemu-server/100.conf

Eth0: 02:a2:78:c6:0e:0c



sudo echo "1. Load Super User..."


sudo echo "2. Install basic packages..."

sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install -y zfs
sudo apt-get install -y mc unace p7zip-rar sharutils arj rar unrar zip unzip lunzip lzip
sudo apt-get install -y youtube-dl
sudo apt-get install -y shellinabox


sudo apt-get install -y mc make linux-image-extra-$(uname -r) zfs unace p7zip-rar sharutils arj rar unrar zip unzip lunzip lzip python-spice-client-gtk youtube-dl fuse exfat-fuse exfat-utils ntp traceroute liblinux-inotify2-perl perl-doc libswitch-perl qemu-utils virt-viewer gir1.2-spice-client-gtk-3.0 hddtemp libdbd-mysql-perl clamav clamav-daemon shellinabox

sudo tasksel install server openssh-server virt-host samba-server lamp-server


#====================================================================================================================

sudo echo "3. Build ZFS Pools, Datasets and disk parameters setup..."
sudo apt install -y smartmontools
sudo smartctl -s on /dev/disk/by-id/ata-ST2000DM001-1ER164_Z4Z4NWA7
sudo smartctl -s on /dev/disk/by-id/ata-ST2000DM001-1CH164_W340CEQA
sudo smartctl -s on /dev/disk/by-id/ata-ST2000DM001-1CH164_W1E5GSTZ
sudo smartctl -s on /dev/disk/by-id/ata-ST2000DM006-2DM164_Z4Z64R28
sudo smartctl -s on /dev/disk/by-id/ata-MB1000GCWCV_Z1W4HCWD

#sudo zpool create HDD-4x2Tb raidz /dev/disk/by-id/ata-ST2000DM001-1ER164_Z4Z4NWA7 /dev/disk/by-id/ata-ST2000DM001-1CH164_W340CEQA /dev/disk/by-id/ata-ST2000DM001-1CH164_W1E5GSTZ /dev/disk/by-id/ata-ST2000DM006-2DM164_Z4Z64R28
#sudo zpool create SSD-360Gb /dev/disk/by-id/ata-KINGSTON_SKC300S37A240G_50026B723501B942 /dev/disk/by-id/ata-KINGSTON_SV300S37A120G_50026B733201C4DF

sudo zpool create HDD-4x2Tb raidz -o ashift=12 /dev/vdb /dev/vdc /dev/vdd /dev/vde

sudo zfs create HDD-4x2Tb/NAS
#sudo zfs create HDD-4x2Tb/NAS/Documents
#sudo zfs create HDD-4x2Tb/NAS/Music
#sudo zfs create HDD-4x2Tb/NAS/Photos
#sudo zfs create HDD-4x2Tb/NAS/Videos

#sudo zfs create SSD-360Gb/MyVMs
#sudo zfs create SSD-360Gb/MyISOs

sudo zfs set mountpoint=/media/NAS HDD-4x2Tb/NAS
sudo zfs set com.sun:auto-snapshot=true HDD-4x2Tb/NAS
#sudo zfs set mountpoint=/media SSD-360Gb

#sudo hdparm -B 1 -S 240 /dev/disk/by-id/ata-ST2000DM001-1ER164_Z4Z4NWA7
#sudo hdparm -B 1 -S 240 /dev/disk/by-id/ata-ST2000DM001-1CH164_W340CEQA
#sudo hdparm -B 1 -S 240 /dev/disk/by-id/ata-ST2000DM001-1CH164_W1E5GSTZ
#sudo hdparm -B 1 -S 240 /dev/disk/by-id/ata-ST2000DM006-2DM164_Z4Z64R28
#sudo hdparm -B 1 -S 240 /dev/disk/by-id/ata-MB1000GCWCV_Z1W4HCWD

sudo chown -R manoel:manoel /media/NAS

sudo mkdir /media/Downloads
sudo mkdir /media/Backup


mkdir /media/NAS/Documents
mkdir /media/NAS/Music
mkdir /media/NAS/Photos
mkdir /media/NAS/Videos
mkdir /media/NAS/Videos/Filmes
mkdir /media/NAS/Videos/Series
mkdir /media/NAS/Videos/Documentarios
mkdir /media/NAS/Videos/Diversos
mkdir /media/NAS/Videos/Clipes
mkdir /media/NAS/Videos/Shows
sudo mkdir /media/Downloads/Watch
sudo mkdir /media/Downloads/Torrents

sudo chown -R manoel:manoel /media/Downloads
sudo chown -R manoel:manoel /media/Backup

sudo mount -t ext4 /dev/vdf1 /media/Downloads
sudo mount -t ext4 /dev/vdg1 /media/Backup

sudo chmod -R ugo+w /media/Downloads/Torrents
sudo chmod -R ugo+w /media/Downloads/Watch


sudo nano /etc/fstab
    /dev/disk/by-id/ata-MB1000GCWCV_Z1W4HCWD-part1          /media/MyBackup         auto            defaults        0       0  
    /dev/disk/by-id/ata-MB1000GCWCV_Z1W4HCWD-part1          /media/MyBackup         auto            defaults        0       0  

	/dev/vda1	/media/Downloads		ext4	defaults	0	0
	/dev/vdf1	/media/Backup			ext4	defaults	0	0


#====================================================================================================================

sudo echo "4. Configure network interfaces..."

sudo nano /etc/network/interfaces
auto br1
iface br1 inet dhcp
	bridge_ports eno1
	bridge_stp off
	bridge_fd 0
	bridge_maxwait 0

auto br2
iface br2 inet dhcp
	bridge_ports eno2
	bridge_stp off
	bridge_fd 0
	bridge_maxwait 0

sudo reboot

#====================================================================================================================

sudo echo "5. Create Samba shares..."
sudo apt-get install -y samba
sudo service smbd stop

sudo nano /etc/samba/smb.conf
[global]
    allow insecure wide links = yes

## oneNAS configuration start:SAMBA_SHARES ==>>

[NAS]
	comment = NAS
	path = /media/NAS
	browseable = yes
	guest ok = no
	read only = no

[Downloads]
	comment = Downloads
	path = /media/Downloads
	browseable = yes
	writeable = yes
	guest ok = no
	read only = no

[Backup]
	comment = Backup
	path = /media/Backup
	browseable = yes
	writeable = yes
	guest ok = no
	read only = no

## <<== oneNAS configuration finish:SAMBA_SHARES

sudo smbpasswd -a manoel
sudo service smbd start

#====================================================================================================================

sudo echo "6. Create NFS shares..."
sudo apt-get install -y nfs-kernel-server
sudo service nfs-kernel-server stop

sudo nano /etc/exports

## oneNAS configuration start:NFS_EXPORTS ==>>
/	192.168.0.0/24(rw,fsid=0,insecure,no_subtree_check,async)

## <<== oneNAS configuration finish:NFS_EXPORTS

sudo service nfs-kernel-server start

#====================================================================================================================

sudo echo "7. Create FTP shares..."
sudo apt install -y vsftpd
sudo service vsftpd stop

sudo nano /etc/vsftpd.conf
    anonymous_enable=NO 
    local_enable=YES
	write_enable=YES

sudo service vsftpd start

#====================================================================================================================

sudo echo "8. Create SNMP monitor agent..."
sudo apt-get install -y snmp snmpd snmp-mibs-downloader libnet-snmp-perl
sudo service snmpd stop

sudo nano /etc/snmp/snmpd.conf
	agentAddress udp:161,udp6:[::1]:161
	rocommunity public

sudo service snmpd start

#====================================================================================================================

sudo echo "9. Create Transmission Server..."
sudo apt-get install -y transmission-cli transmission-common transmission-daemon

sudo service transmission-daemon stop

sudo nano /var/lib/transmission-daemon/info/settings.json

	"download-dir": "/media/Downloads/Torrents", 
	"download-queue-size": 10, 
    "rpc-whitelist": "127.0.0.1,192.168.0.*", 
	"umask": 2,
    "watch-dir": "/media/Downloads/Watch",
    "watch-dir-enabled": true,

sudo service transmission-daemon start

#====================================================================================================================

sudo echo "10. Configure NUT..."
sudo apt-get install -y nut

sudo upsdrvctl stop
sudo service nut-server stop
sudo service nut-client stop

sudo nano /etc/nut/nut.conf
MODE=standalone

sudo nano /etc/nut/ups.conf
[UPS-APC]
	driver = usbhid-ups
	port = auto
	#maxretry = 3

sudo nano /etc/nut/upsd.users
[upsmon]
	password = upsmonpass
	allowfrom = localhost
	upsmon master
	actions = SET
	instcmds = ALL

sudo nano /etc/nut/upsmon.conf
MONITOR UPS-APC@localhost 1 upsmon upsmonpass master

sudo upsdrvctl start
sudo service nut-server start
sudo service nut-client start

sudo reboot

#====================================================================================================================

sudo echo "11. Install ZFS Auto Snapshot..."
mkdir ~/Downloads
cd ~/Downloads

#wget https://github.com/zfsonlinux/zfs-auto-snapshot
wget https://github.com/zfsonlinux/zfs-auto-snapshot/archive/master.zip

unzip master.zip
cd zfs-auto-snapshot-master
sudo make install   

sudo zfs set com.sun:auto-snapshot=false HDD-4x2Tb
sudo zfs set com.sun:auto-snapshot=true HDD-4x2Tb/MNAS

cd ~

#====================================================================================================================


sudo echo "12. Install & Configure RSnapshot..."
sudo apt-get install -y rsnapshot

sudo mkdir /usr/share/oneNAS
sudo chown -R manoel:manoel /usr/share/oneNAS

sudo nano /etc/rsnapshot.conf

## oneNAS configuration start:BACKUP_DESTINATION ==>>
snapshot_root	/media/Backup/rsnapshot/
## <<== oneNAS configuration finish:BACKUP_DESTINATION

## oneNAS configuration start:BACKUP_RETENTION ==>>
retain  hourly  4
retain  daily   7
retain  weekly  4
retain  monthly 3
## <<== oneNAS configuration finish:BACKUP_RETENTION

## oneNAS configuration start:BACKUP_SOURCES ==>>
backup	/media/NAS/Photos/		localhost/
backup	/media/NAS/Music/		localhost/
backup	/media/NAS/Documents/	localhost/
backup	/usr/share/oneNAS		localhost/
## <<== oneNAS configuration finish:BACKUP_SOURCES


sudo rsnapshot configtest
sudo rsnapshot -t hourly

#====================================================================================================================

sudo echo "13. Install & Configure Docker..."
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" | sudo tee /etc/apt/sources.list.d/docker.list
sudo apt-get update
apt-cache policy docker-engine

sudo apt-get install -y docker-engine

sudo systemctl status docker
sudo usermod -aG docker $(whoami)
sudo reboot

docker run hello-world

#====================================================================================================================

sudo echo "14. Install & Configure Minidlna..."
sudo apt-get install -y minidlna
sudo service minidlna stop

sudo nano /etc/minidlna.conf
	media_dir=/media/Downloads
	media_dir=/media/NAS/Music
	media_dir=/media/NAS/Photos
	media_dir=/media/NAS/Videos/Filmes
	media_dir=/media/NAS/Videos/Series
	media_dir=/media/NAS/Videos/Documentarios
	media_dir=/media/NAS/Videos/Diversos
	media_dir=/media/NAS/Videos/Clipes
	media_dir=/media/NAS/Videos/Shows
	inotify=yes
sudo service minidlna start

#====================================================================================================================

sudo echo "15. Install & Configure PlexMediaServer..."
wget -O - http://shell.ninthgate.se/packages/shell.ninthgate.se.gpg.key | sudo apt-key add -
echo "deb http://shell.ninthgate.se/packages/debian jessie main" | sudo tee -a /etc/apt/sources.list.d/plex.list

sudo apt update
sudo apt install -y plexmediaserver
sudo usermod -aG manoel plex

#====================================================================================================================

sudo echo "16. Install & Configure Syncthing..."

curl -s https://syncthing.net/release-key.txt | sudo apt-key add -
echo "deb http://apt.syncthing.net/ syncthing release" | sudo tee /etc/apt/sources.list.d/syncthing.list
sudo apt-get update
sudo apt-get install -y syncthing
sudo systemctl enable syncthing@manoel.service
sudo systemctl start syncthing@manoel.service

nano ~/.config/syncthing/config.xml
	<address>0.0.0.0:8384</address>

#====================================================================================================================

sudo echo "17. Install & Configure Admin services..."
sudo apt-get install -y rrdtool librrds-perl collectd collectd-utils hddtemp

#sudo service carbon-cache stop 
sudo service collectd stop
sudo nano /etc/collectd/collectd.conf

Hostname "localhost"
#FQDNLookup true
BaseDir "/var/lib/collectd"
PluginDir "/usr/lib/collectd"
TypesDB "/usr/share/collectd/types.db" "/etc/collectd/my_types.db"

LoadPlugin hddtemp
LoadPlugin nfs
LoadPlugin nut
LoadPlugin ntpd
LoadPlugin smart
LoadPlugin uptime
LoadPlugin virt
LoadPlugin vserver
LoadPlugin zfs_arc

<Plugin hddtemp>
        Host "127.0.0.1"
        Port 7634
</Plugin>

<Plugin ntpd>
        Host "localhost"
        Port 123
        ReverseLookups false
        IncludeUnitID true
</Plugin>


<Plugin nut>
        UPS "UPS-APC@localhost:3493"
</Plugin>

#sudo service carbon-cache start
sudo service collectd start


#====================================================================================================================
sudo echo "18. Final update..."
sudo apt-get update && sudo apt-get upgrade -y

#====================================================================================================================


#cp -R /home/manoel/Media/manoel/1bf9f5f4-ed2c-4216-a3cd-42fe21ded613/media/5df22048-6619-41f7-9fd6-9a8674a2973f/Documents/daily.0/* /home/manoel/HomeServer/media/MyNAS/Documents && cp -R /home/manoel/Media/manoel/1bf9f5f4-ed2c-4216-a3cd-42fe21ded613/media/5df22048-6619-41f7-9fd6-9a8674a2973f/Music/daily.0/* /home/manoel/HomeServer/media/MyNAS/Music && cp -R /home/manoel/Media/manoel/1bf9f5f4-ed2c-4216-a3cd-42fe21ded613/media/5df22048-6619-41f7-9fd6-9a8674a2973f/Photos/daily.0/*  /home/manoel/HomeServer/media/MyNAS/Photos





#sudo apt-get install -y mc zfsutils-linux apt-transport-https ca-certificates linux-image-extra-$(uname -r) nut bridge-utils rrdtool snmp snmpd snmp-mibs-downloader vsftpd minidlna transmission-cli transmission-common transmission-daemon unace p7zip-rar sharutils rar arj lunzip lzip htop iptraf slurm lynx-cur fuse exfat-fuse exfat-utils rsnapshot samba rar unrar make gnu-fdisk ntp ntpdate docker-engine discus di cockpit smartmontools youtube-dl cryptsetup

