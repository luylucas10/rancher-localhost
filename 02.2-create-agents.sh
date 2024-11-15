# for the agent nodes we need less configuration

mkdir -p /etc/rancher/rke2/ # create directory
touch /etc/rancher/rke2/config.yaml # create config file
echo "write-kubeconfig-mode: 0644" >> /etc/rancher/rke2/config.yaml # write kubeconfig mode
echo "server: https://192.168.0.10:9345" >> /etc/rancher/rke2/config.yaml # main server ip 
echo "token: <server-token>" >> /etc/rancher/rke2/config.yaml # main server token

curl -sfL https://get.rke2.io | INSTALL_RKE2_TYPE="agent" sh - # install rke2 agent
systemctl enable rke2-agent.service # enable rke2 agent
systemctl start rke2-agent.service # start rke2 agent