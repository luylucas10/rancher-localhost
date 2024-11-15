# create a namespace for harbor, I'm using -system to follow the pattern of rancher
kubectl create namespace harbor-system

# with cert-manager installed, we can create the tls certificate for harbor
echo "apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: harbor-tls
  namespace: harbor-system
spec:
  secretName: harbor-tls
  issuerRef:
    name: digitalocean-issuer
    kind: ClusterIssuer
  commonName: hub.yourdomain.com
  dnsNames:
    - hub.hub.yourdomain.com
  " | kubectl apply -f -


helm repo add harbor https://helm.goharbor.io 

helm upgrade --install --namespace harbor-system harbor harbor/harbor \
    --set expose.tls.enabled=true \
    --set expose.tls.certSource=secret \
    --set expose.tls.secretName=harbor-tls \
    --set expose.ingress.hosts.core=hub.yourdomain.com \
    --set externalURL=https://hub.yourdomain.com \
    --set harborAdminPassword=<your-password> \
    # with metrics enabled, we can monitor harbor with prometheus
    --set metrics.enabled=true \ 
    # with serviceMonitor enabled, we can monitor harbor with prometheus
    --set metrics.serviceMonitor.enabled=true 

# if you need to remove
# helm uninstall --namespace harbor-system harbor