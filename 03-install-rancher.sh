# in the main server (where you linked kubectl), we will install rancher and cert-manager

# install helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# add rancher repo
helm repo add rancher-latest https://releases.rancher.com/server-charts/latest

# add jetstack repo
helm repo add jetstack https://charts.jetstack.io

# install cert-manager
helm install cert-manager jetstack/cert-manager --namespace cert-manager --create-namespace --version v1.16.1 --set crds.enabled=true

# install rancher, this configuration will use cert-manager to create the certificates
helm install rancher rancher-latest/rancher --namespace cattle-system --create-namespace --set hostname=rancher.yourdomain.com --set bootstrapPassword=admin 

# wait for rancher to be ready
kubectl -n cattle-system rollout status deploy/rancher

# wait some minutes to get rancher ready, then access rancher.yourdomain.com and login with the password admin
# save the new password
# if you need to reset, use that command: kubectl -n cattle-system exec $(kubectl -n cattle-system get pods -l app=rancher --no-headers | head -1 | awk '{ print $1 }') -c rancher -- reset-password

# admin
# TwnUSdyUcJN7Ye61