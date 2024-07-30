# XXX:CUST setting up helm repository
helm repo add jetstack https://charts.jetstack.io

#Update your local Helm chart repository cache:
helm repo update

#check if repo successfully configured
helm search repo jetstack

#install cert-manager chart
helm install cert-manager jetstack/cert-manager --namespace cert-manager --create-namespace --version v1.5.4 --set global.leaderElection.namespace=cert-manager --set installCRDs=true --set prometheus.enabled=false

#Apply CertIssuer
kubectl apply -f certIssuer.yaml
