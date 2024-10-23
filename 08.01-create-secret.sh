# create a kubernetes secret at namespace pipelines with username and password

kubectl create secret generic argotektonuser --from-literal=username=argotekton --from-literal=password=q4fpcDs3WS -n pipelines