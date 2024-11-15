helm repo add elastic https://helm.elastic.co

helm install elastic-operator elastic/eck-operator \
    --namespace elastic-system --create-namespace

helm upgrade --install elastic-stack elastic/eck-stack \
    --namespace elastic-stack --create-namespace \
    --set ingress.enabled=true \
    --set ingress.hosts[0].host=elasticsearch.yourdomain.com \
    --set ingress.hosts[0].path="/" \
    --set ingress.annotations."cert-manager\.io/cluster-issuer"="digitalocean-issuer" \
    --set ingress.tls[0].hosts[0]=elasticsearch.yourdomain.com \
    --set ingress.tls[0].secretName=elasticsearch-tls