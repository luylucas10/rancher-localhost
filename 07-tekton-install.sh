# install the tekton operator
kubectl apply -f https://storage.googleapis.com/tekton-releases/operator/latest/release.yaml

# apply config to install all resources
kubectl apply -f https://raw.githubusercontent.com/tektoncd/operator/main/config/crs/kubernetes/config/all/operator_v1alpha1_config_cr.yaml

# add ingress to the dashboard
DASHBOARD_URL=ci.yourdomain.com
kubectl apply -n tekton-pipelines -f - <<EOF
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: tekton-dashboard
  namespace: tekton-pipelines
spec:
  rules:
  - host: ci.yourdomain.com
    http:
      paths:
      - pathType: ImplementationSpecific
        backend:
          service:
            name: tekton-dashboard
            port:
              number: 9097
  tls:
    - hosts:
      - ci.yourdomain.com
EOF


curl -LO https://github.com/tektoncd/cli/releases/download/v0.38.1/tektoncd-cli-0.38.1_Linux-64bit.deb
dpkg -i ./tektoncd-cli-0.38.1_Linux-64bit.deb
