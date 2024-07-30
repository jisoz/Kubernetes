#!/bin/bash
export GOOGLE_PROJECT_ID=project1-396111
export DNSZONE=gcp   #mission gcp
export STORAGE_CLASS=standard #slow do-block-storage
export NGINX_LOAD_BALANCER_IP=165.227.244.9 #35.240.127.90 #165.227.244.9
export REDIS_HOST="" #139.162.149.228  #""for digital ocean
export PSQL_HOST="" #139.162.149.228   #"" for digital ocean
export INTERNAL_REDIS=true   #true false
export ENABLE_REDIS_SECRET=true
export CREATE_RABC=true
export CLOUD_DNS_PROVIDER=google    #google digitalocean

