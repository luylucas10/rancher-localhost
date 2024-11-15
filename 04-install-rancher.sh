# in the main server (where you linked kubectl), we will install rancher and cert-manager

helm repo add rancher-latest https://releases.rancher.com/server-charts/latest

helm upgrade --install rancher rancher-latest/rancher \
  --namespace cattle-system \
  --create-namespace \
  --set hostname=rancher.<your-domain> \
  --set bootstrapPassword=admin \
  --set ingress.tls.source=letsEncrypt \
  --set letsEncrypt.email=your@email.com \
  --set letsEncrypt.ingress.class=nginx \
  --set letsEncrypt.environment=staging

kubectl -n cattle-system rollout status deploy/rancher

# patch the rancher ingress to use cert-manager digitalocean-issuer as the cluster issuer and the tls secret
kubectl -n cattle-system patch ingress rancher -p '{"metadata":{"annotations":{"cert-manager.io/cluster-issuer":"digitalocean-issuer"}}}'

# wait some minutes to get rancher ready, then access rancher.yourdomain.com and login with the password admin
# save the new password
# if you need to reset, use that command: 
# kubectl -n cattle-system exec $(kubectl -n cattle-system get pods -l app=rancher --no-headers | head -1 | awk '{ print $1 }') -c rancher -- reset-password