helm repo add gitlab https://charts.gitlab.io/
helm fetch gitlab/gitlab --untar
nano gitlab/values.yaml

# global.edition=ce
# global.hosts.domain=mydomain.com
# monitoring.enabled=true
# certmanager-issuer.email=your@email.com
# certmanager.install=false
# prometheus.install=false

helm upgrade --install --namespace gitlab --create-namespace gitlab gitlab/

kubectl get secret --namespace gitlab gitlab-gitlab-initial-root-password -ojsonpath='{.data.password}' | base64 --decode ; echo

# helm upgrade --install --namespace gitlab --create-namespace gitlab gitlab/gitlab \
#     --set global.edition=ce \
#     --set global.hosts.domain=mydomain.com \
#     --set monitoring.enabled=true \
#     --set certmanager-issuer.email=your@email.com \
#     --set certmanager.install=false

# helm uninstall --namespace gitlab gitlab

# root
# c5N9SggUd1QjRHjc9zlo2uSamCg5ESW2bQHOmtf5eE68wMB690gg7I0pGanFre5k
