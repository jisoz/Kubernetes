kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml 
kubectl apply -f admin-ksa.yaml -n kubernetes-dashboard
kubectl apply -f admin-rolebinding.yaml -n kubernetes-dashboard
kubectl apply -f admin-secret.yaml -n kubernetes-dashboard
kubectl apply -f admin-ingress.yaml -n kubernetes-dashboard
