#!/bin/bash

# XXX:CUST setting up helm repository
helm repo add argo-cd https://argoproj.github.io/argo-helm

# # create default config file
helm inspect values argo-cd > values-default.yaml

