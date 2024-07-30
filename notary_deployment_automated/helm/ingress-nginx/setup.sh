# XXX:CUST setting up helm repository
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx

# check if repo successfully configured
helm search repo ingress-nginx/ingress-nginx

# create default config file
helm inspect values ingress-nginx/ingress-nginx > values-default.yaml

