# the first step is prepare the all ubuntu-vms for rke2 installation
# disabling the firewall, updating the system, installing nfs, and cleaning up

# if necessary change the root password
# sudo -i # become root
# passwd # change root password

systemctl stop ufw # stop the software firewall
systemctl disable ufw # disable the software firewall
apt update # get updates
apt upgrade -y # do updates
apt install nfs-common -y # install nfs for longhorn system
apt autoremove -y # clean up