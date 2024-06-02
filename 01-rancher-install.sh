# preparing ubuntu-vm for rke2 installation
systemctl stop ufw # stop the software firewall
systemctl disable ufw # disable the software firewall
apt update && apt upgrade -y # get updates, install nfs, and apply
apt install nfs-common -y # install nfs
apt autoremove -y # clean up

# install rke2
curl -sfL https://get.rke2.io | sh - # install rke2
systemctl enable rke2-server.service # enable rke2
systemctl start rke2-server.service # start rke2

# simlink all the things - kubectl
ln -s $(find /var/lib/rancher/rke2/data/ -name kubectl) /usr/local/bin/kubectl

# add kubeconfig to environment variables
export KUBECONFIG=/etc/rancher/rke2/rke2.yaml # for current session
echo "KUBECONFIG='/etc/rancher/rke2/rke2.yaml'" >> ~/.bashrc # for future sessions
source ~/.bashrc

# install helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

#echo '127.0.0.1     rancher.mydomain.com' >> /etc/hosts

# add rancher repo
helm repo add rancher-latest https://releases.rancher.com/server-charts/latest

# add jetstack repo
helm repo add jetstack https://charts.jetstack.io

# install cert-manager
helm install cert-manager jetstack/cert-manager \ 
  --namespace cert-manager \
  --create-namespace \
  --set installCRDs=true

# install rancher
helm install rancher rancher-latest/rancher \
  --namespace cattle-system \
  --create-namespace \
  --set hostname=rancher.mydomain.com \
  --set bootstrapPassword=admin
