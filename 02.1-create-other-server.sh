# optional: create other servers (in this case, odd numbers, like more 2 servers, total 3 servers)

curl -sfL https://get.rke2.io | sh - # install rke2
mkdir -p /etc/rancher/rke2/ # create directory
touch /etc/rancher/rke2/config.yaml # create file
echo "write-kubeconfig-mode: 0644" >> /etc/rancher/rke2/config.yaml # write kubeconfig mode
echo "server: https://192.168.0.10:9345" >> /etc/rancher/rke2/config.yaml # main server ip
echo "token: <server-token>" >> /etc/rancher/rke2/config.yaml # main server token
echo "tls-san:
  - <yourdomain.com>" >> /etc/rancher/rke2/config.yaml

# is necessary to have the same configuration for other servers
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

systemctl enable rke2-server.service # enable rke2 server
systemctl start rke2-server.service # start rke2 server

# isn't necessary to create a link for kubectl for additional servers