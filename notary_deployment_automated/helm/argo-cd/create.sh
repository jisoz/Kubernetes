kubectl create ns argocd

helm install --namespace argocd argo-cd argo-cd/argo-cd  -f values.yaml

