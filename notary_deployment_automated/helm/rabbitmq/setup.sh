# XXX:CUST setting up btinami helm repository
helm repo add bitnami https://charts.bitnami.com/bitnami

# check if repo successfully configured
helm search repo bitnami/rabbitmq

# create default config file
helm inspect values bitnami/rabbitmq > values-default.yaml

