# the second step is create the main server, that will creates the tokens for the other servers and agents

curl -sfL https://get.rke2.io | sh - # install rke2
mkdir -p /etc/rancher/rke2/ # create directory
touch /etc/rancher/rke2/config.yaml # create config file
echo "write-kubeconfig-mode: 0644" >> /etc/rancher/rke2/config.yaml # write kubeconfig mode
# the next configuration is about self-signed certificates, we will need this for the rancher server
echo "tls-san:
  - <yourdomain.com>" >> /etc/rancher/rke2/config.yaml

# this configuration add the ingress-nginx with ssl passthrough, we will need this for argocd ingress
mkdir -p /var/lib/rancher/rke2/server/manifests
touch /var/lib/rancher/rke2/server/manifests/rke2-ingress-nginx-config.yaml

echo "apiVersion: helm.cattle.io/v1
kind: HelmChartConfig
metadata:
  name: rke2-ingress-nginx
  namespace: kube-system
spec:
  valuesContent: |-
    controller:
      config:
        use-forwarded-headers: true
      extraArgs:
        enable-ssl-passthrough: true" > /var/lib/rancher/rke2/server/manifests/rke2-ingress-nginx-config.yaml

systemctl enable rke2-server.service # this enables rke2 server to start on boot
systemctl start rke2-server.service # start rke2 server 

# create a link for kubectl
ln -s $(find /var/lib/rancher/rke2/data/ -name kubectl) /usr/local/bin/kubectl

# install helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# add kubeconfig to environment variables to use with kubectl
export KUBECONFIG=/etc/rancher/rke2/rke2.yaml # for current session
echo "KUBECONFIG='/etc/rancher/rke2/rke2.yaml'" >> ~/.bashrc # for future sessions
source ~/.bashrc

# get the token for other servers and agents
cat /var/lib/rancher/rke2/server/node-token