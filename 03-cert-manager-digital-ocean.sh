# I recommend you to have a domain, to do that. You can use Digital Ocean to get staging certificates for free,
# and use this to have tls in all of your ingresses.
# in this update I'm considering that.
# in the first control plane server, execute the following commands.
# those commands will install cert-manager and create the issuer for digital ocean dns01 challenge.

helm repo add jetstack https://charts.jetstack.io

helm install cert-manager jetstack/cert-manager \
    --namespace cert-manager \
    --create-namespace \
    --set crds.enabled=true

echo "apiVersion: v1
kind: Secret
metadata:
  name: digitalocean-api-token
  namespace: cert-manager
type: Opaque
data:
  access-token: <base64-digital-token>" | kubectl apply -f -

echo "apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: digitalocean-issuer
  namespace: cert-manager
spec:
  acme:
    server: https://acme-staging-v02.api.letsencrypt.org/directory
    email: <your-email>
    privateKeySecretRef:
      name: digitalocean-tls-key
    solvers:
    - dns01:
        digitalocean:
          tokenSecretRef:
            name: digitalocean-api-token
            key: access-token" | kubectl apply -f -
