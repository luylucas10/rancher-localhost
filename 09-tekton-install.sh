# install the tekton operator
kubectl apply -f https://storage.googleapis.com/tekton-releases/operator/latest/release.yaml

# apply config to install all resources
kubectl apply -f - <<EOF
apiVersion: operator.tekton.dev/v1alpha1
kind: TektonConfig
metadata:
  name: config
spec:
  targetNamespace: tekton-pipelines
  profile: all
  chain:
    disabled: false
  pipeline:
    set-security-context: true
  pruner:
    disabled: false
    schedule: "* 1 * * *"
    resources:
      - taskrun
      - pipelinerun
    keep: 5
  dashboard:
    readonly: false
EOF

# add ingress to the dashboard
kubectl apply -f - <<EOF
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: tekton-dashboard
  namespace: tekton-pipelines
  annotations:
    cert-manager.io/cluster-issuer: digitalocean-issuer
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
    secretName: tekton-dashboard-tls
EOF

curl -LO https://github.com/tektoncd/cli/releases/download/v0.38.1/tektoncd-cli-0.38.1_Linux-64bit.deb
dpkg -i ./tektoncd-cli-0.38.1_Linux-64bit.deb
