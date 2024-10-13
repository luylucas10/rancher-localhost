
helm repo add gitlab https://charts.gitlab.io/ # add the gitlab helm repository
helm fetch gitlab/gitlab --untar # fetch the gitlab helm chart
nano gitlab/values.yaml # configure the gitlab

# global.edition:ce
# global.hosts.domain:yourdomain.com
# global.hosts.https: false
# global.ingress.configureCertmanager:false
# monitoring.enabled:true
# certmanager.install:false # we already have cert-manager
# prometheus.install:false # we already have prometheus
# nginx-ingress.enabled:false # we already have nginx-ingress

# before install, depends on your storage size, you may have to change pvc size of:
#   gitlab/charts/minio/values.yaml 
#   gitlab/charts/gitlab/values.yaml 
#   gitlab/charts/gitlab/charts/gitaly/values.yaml
#   gitlab/charts/postgresql/values.yaml 
#   gitlab/charts/redis/values.yaml 

# install gitlab on cluster
helm upgrade --install --namespace gitlab --create-namespace gitlab gitlab/

# get the root password
kubectl get secret --namespace gitlab gitlab-gitlab-initial-root-password -ojsonpath='{.data.password}' | base64 --decode ; echo

# helm uninstall --namespace gitlab gitlab

# root
# Wp0g1tfGRWEzgAibh4Ov4JUqnVR6coqqiODETcyasamei7tc8wWTTxVkD8PVmJFa
