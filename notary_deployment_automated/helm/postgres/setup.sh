helm repo add postgres-operator-charts https://opensource.zalando.com/postgres-operator/charts/postgres-operator

helm repo add postgres-operator-ui-charts https://opensource.zalando.com/postgres-operator/charts/postgres-operator-ui

helm inspect values postgres-operator-charts/postgres-operator > values-default.yaml

helm inspect values postgres-operator-ui-charts/postgres-operator-ui > values-default-ui.yaml

