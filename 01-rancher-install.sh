#rancher 123456
#su - 123456 

# for every node
# preparing ubuntu-vm for rke2 installation
systemctl stop ufw # stop the software firewall
systemctl disable ufw # disable the software firewall
apt update && apt upgrade -y # get updates, install nfs, and apply
apt install nfs-common -y # install nfs
apt autoremove -y # clean up

# for the server node
# install rke2
curl -sfL https://get.rke2.io | sh - # install rke2
mkdir -p /etc/rancher/rke2/ # create directory
touch /etc/rancher/rke2/config.yaml # create file
echo "enable-servicelb: true" >> /etc/rancher/rke2/config.yaml # write kubeconfig mode
systemctl enable rke2-server.service # enable rke2
systemctl start rke2-server.service # start rke2

# simlink all the things - kubectl
ln -s $(find /var/lib/rancher/rke2/data/ -name kubectl) /usr/local/bin/kubectl

# add kubeconfig to environment variables
export KUBECONFIG=/etc/rancher/rke2/rke2.yaml # for current session
echo "KUBECONFIG='/etc/rancher/rke2/rke2.yaml'" >> ~/.bashrc # for future sessions
source ~/.bashrc

# for the agent node
mkdir -p /etc/rancher/rke2/
touch /etc/rancher/rke2/config.yaml
echo "server: https://192.168.0.10:9345
token: K10daafaec98e8330e638e60386a7624be441c481396558be0bd71fa68c28df12af::server:64d1e7cf7c8ed7135b38ca5e33f8d270" >> /etc/rancher/rke2/config.yaml

curl -sfL https://get.rke2.io | INSTALL_RKE2_TYPE="agent" sh -
systemctl enable rke2-agent.service
systemctl start rke2-agent.service


#in the server node
# install helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

#echo '127.0.0.1     rancher.mydomain.com' >> /etc/hosts

# add rancher repo
helm repo add rancher-latest https://releases.rancher.com/server-charts/latest

# add jetstack repo
helm repo add jetstack https://charts.jetstack.io

# install cert-manager
helm upgrade --install --namespace cert-manager --create-namespace cert-manager jetstack/cert-manager --set crds.enable=true

# install rancher
helm install rancher rancher-latest/rancher --namespace cattle-system --create-namespace --set hostname=rancher.mangotecnologia.com.br --set bootstrapPassword=admin 

# admin
# zUoL2V$WFhIp$sx
# kubectl -n cattle-system exec $(kubectl -n cattle-system get pods -l app=rancher --no-headers | head -1 | awk '{ print $1 }') -c rancher -- reset-password