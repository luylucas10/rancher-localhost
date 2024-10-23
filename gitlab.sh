kubectl -n gitlab apply -f - <<EOF
apiVersion: apps.gitlab.com/v1beta1
kind: GitLab
metadata:
  name: gitlab
spec:
  chart:
    version: "8.4.2" 
    values:
      global:
        edition: ce
        hosts:
          domain: yourdomain.com # use a real domain here
          https: true
        ingress:
          configureCertmanager: true
      certmanager-issuer:
        install: false
      monitoring:
        enabled: true
      prometheus:
        install: false
      nginx-ingress:
        enabled: false 
EOF