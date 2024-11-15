helm repo add sonarqube https://SonarSource.github.io/helm-chart-sonarqube

helm upgrade --install --namespace sonarqube-system \
    --create-namespace sonarqube sonarqube/sonarqube \
    --set initSysctl.enabled=false \
    --set initFs.enabled=false \
    --set ingress.enabled=true \
    --set ingress.hosts[0].name=sonarqube.yourdomain.com \
    --set ingress.annotations."cert-manager\.io/cluster-issuer"="digitalocean-issuer" \
    --set ingress.tls[0].hosts[0]=sonarqube.yourdomain.com \
    --set ingress.tls[0].secretName=sonarqube-tls


# helm uninstall --namespace sonarqube-system sonarqube