#!/bin/bash


export PROVIDER=GKE #k0s
##this file is not final
##chart vesrions depend on version listed in this  file

#kubectl versrion
export kubectl=1.21.0
export k0sctl=v1.21.11+k0s


consul=0.42.0 #charts version
consul_app_version=1.11.4 #app version

minio=8.0.10 #chart version
minio_image=RELEASE.2021-02-14T04-01-33Z
minio_mc_image=RELEASE.2021-02-14T04-28-06Z
minio_helm_jq_image=3.1.0

gitlab_chart_version=5.10.4 #chart version
gitlab=14.10.4 #app version
busybox_image=latest
gitlab_minio_mc_image=latest

externalDns=6.2.4  #chart version
external_dns_app_version=0.11.0

ingressNginx=4.0.18 #chart version
ingress_app_version=1.1.3 #app version
ingress_controller_image=v1.1.2
ingress_jettech_webhook_image=v1.5.1
ingress_defaultbackend_image=1.5

rabbitmq=8.31.3 #chart version
rabbitmq_app_version=3.9.14 #app version

gitlabRunner=0.39.0 #chart version
gitlab_runner_app_version=14.9.0 #app version

prometheus=15.8.1 #chart version
promethus_app_version=2.34.0 #app version
quay_io_prom_alertmanager_img=v0.21.0
jimidyson_prom_configmap_image=v0.5.0
quay_io_prom_nodeexporter_image=v1.1.2
prom_server_image=v2.26.0
prom_pushgateway_image=v1.3.1

vault=0.19.0 #chart version
vault_app_version=1.9.2 #app version
vault_lead_elector=0.4
vault_image=0.10.0
vault_agent_image=1.7.0
vault_csi_provider=0.2.0

postgres-operator=1.8.1 #chart version
postgres-operator_app_version=1.8.1 #app version

postgres-operator-ui=1.8.1 #chart version
postgres-operator-ui_app_version=1.8.1 #app version

argo-workflow=0.13.0 #chart version    #alternative 0.16.2
argo-workflow_app_version=3.2.9 #app version #alternative 3.3.6

argo-cd=4.8.2 #chart version
argo-cd_app_version=2.3.4 #app

