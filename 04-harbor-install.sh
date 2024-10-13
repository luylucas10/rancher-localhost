# before install harbor we need to install some tools for cluster
# install longhorn (for storage): Select local cluster> Menu Cluster > Tools > Longhorn
# install monitoring (prometheus + grafana): Select local cluster> Menu Cluster > Tools > Monitoring
# install logging (fluentd): Select local cluster> Menu Cluster > Tools > Logging

helm repo add harbor https://helm.goharbor.io # add the harbor helm repository
helm fetch harbor/harbor --untar # fetch the harbor helm chart
nano harbor/values.yaml 

# change the following values:
# expose.ingress.hosts.core: "hub.<yourdomain.com>"
# externalURL: "https://hub.<yourdomain.com>"
# harborAdminPassword: "admin"
# metrics.enabled: true
# metrics.serviceMonitor.enabled: true
# cache.enabled: true

helm upgrade --install --namespace harbor --create-namespace harbor harbor/ # install harbor