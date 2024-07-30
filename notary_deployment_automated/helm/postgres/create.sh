
helm install postgres-operator postgres-operator-charts/postgres-operator -f values.yaml

helm install postgres-operator-ui postgres-operator-ui-charts/postgres-operator-ui -f values-ui.yaml


sleep 5

kubectl apply -f prod-cluster.yaml

