# install longhorn: Select local cluster> Menu Cluster > Tools > Longhorn
# install monitoring: Select local cluster> Menu Cluster > Tools > Monitoring
# install logging: Select local cluster> Menu Cluster > Tools > Logging

#install harbor
helm repo add harbor https://helm.goharbor.io
helm fetch harbor/harbor --untar
nano harbor/values.yaml
helm upgrade --install --namespace harbor --create-namespace harbor harbor/

# Or
# helm upgrade --install --namespace harbor --create-namespace harbor harbor/harbor \
#     --set expose.ingress.hosts.core=hub.mydomain.com \ # replace mydomain.com with your domain
#     --set externalURL=https://hub.mydomain.com \ # replace mydomain.com with your domain
#     --set persistence.persistentVolumeClaim.registry.size=10Gi \
#     --set persistence.persistentVolumeClaim.database.size=10Gi \
#     --set persistence.persistentVolumeClaim.trivy.size=10Gi \
#     --set harborAdminPassword=admin


