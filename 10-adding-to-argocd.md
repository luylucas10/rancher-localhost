the machines that we created and the cluster don't know the names of domain that we are using, so lets add those names to hosts file in all of them

echo '127.0.0.1  gitlab.yourdomain.com' >> /etc/hosts
echo '127.0.0.1  ci.yourdomain.com' >> /etc/hosts
echo '127.0.0.1  cd.yourdomain.com' >> /etc/hosts

open your argocd instance, log with admin

settings > repositories