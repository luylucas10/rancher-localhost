helm repo add gitlab https://charts.gitlab.io/ # add the gitlab helm repository

# install gitlab on cluster
helm upgrade --install gitlab gitlab/gitlab \
  --namespace gitlab-system --create-namespace \
  --set global.edition=ce \
  --set global.hosts.domain=yourdomain.com \
  --set global.ingress.configureCertmanager=false \
  --set gitlab.webservice.ingress.annotations."cert-manager\.io/cluster-issuer"="digitalocean-issuer" \
  --set global.ingress.class=nginx \
  --set global.ingress.tls.enabled=true \
  --set global.ingress.tls.secretName=gitlab-tls \
  --set global.monitoring.enabled=true \
  --set global.gitaly.enabled=true \
  --set global.praefect.enabled=false \
  --set global.minio.enabled=true \
  --set global.kas.enabled=false \
  --set global.registry.enabled=false \
  --set certmanager.install=false \
  --set nginx-ingress.enabled=false \
  --set prometheus.install=false \
  --set gitlab-runner.install=false

# get the root password
kubectl get secret --namespace gitlab-system gitlab-gitlab-initial-root-password -ojsonpath='{.data.password}' | base64 --decode ; echo

# to uninstall
# helm uninstall --namespace gitlab-system gitlab
