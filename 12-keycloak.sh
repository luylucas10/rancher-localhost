helm install keycloak oci://registry-1.docker.io/bitnamicharts/keycloak \
    --namespace keycloak-system \
    --create-namespace \
    --set auth.adminUser=admin \
    --set auth.adminPassword=admin \
    --set ingress.enabled=true \
    --set ingress.ingressClassName=nginx \
    --set ingress.hostname=sso.yourdomain.com \
    --set ingress.tls=true \
    --set ingress.annotations."cert-manager\.io/cluster-issuer"="digitalocean-issuer" \
    --set metrics.enabled=true \
    --set metrics.serviceMonitor.enabled=true
    
    