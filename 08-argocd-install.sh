curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
rm argocd-linux-amd64

# add the helm repo
helm repo add argo https://argoproj.github.io/argo-helm

# install argocd
helm upgrade --install argocd argo/argo-cd \
  --namespace argocd --create-namespace \
  --set global.domain='cd.yourdomain.com' \
  --set configs.cm.url='https://cd.yourdomain.com' \
  --set configs.cm.users.anonymous.enabled=false \
  --set configs.cm.resource.exclusions[0].apiGroups[0]="*" \
  --set configs.cm.resource.exclusions[0].kinds[0]="PipelineRun" \
  --set configs.cm.resource.exclusions[0].kinds[1]="TaskRun" \
  --set configs.cm.resource.exclusions[0].clusters[0]="*"\
  --set configs.params.application.namespaces="*" \
  --set server.metrics.enabled=true \
  --set server.metrics.serviceMonitor.enabled=true \
  --set server.ingress.enabled=true \
  --set server.ingress.ingressClassName=nginx \
  --set server.ingress.tls=true \
  --set server.ingress.annotations."nginx\.ingress\.kubernetes\.io/force-ssl-redirect"=true \
  --set server.ingress.annotations."nginx\.ingress\.kubernetes\.io/ssl-passthrough"=true \
  --set server.ingress.annotations."nginx\.ingress\.kubernetes\.io/backend-protocol"="HTTPS" \
  --set server.ingress.annotations."cert-manager\.io/cluster-issuer"="digitalocean-issuer"