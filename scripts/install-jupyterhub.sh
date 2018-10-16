#!/usr/bin/env bash

helm repo add jupyterhub https://jupyterhub.github.io/helm-chart
helm repo update
# version 0.8-e29f3e7 is required because a bug fix that is not yet released is required. Once v0.8 is released, simply us v0.8
helm install jupyterhub/jupyterhub --version=v0.8-e29f3e7 --name=jupyterhub-kube --namespace=jupyterhub -f config.yaml --debug --timeout 10000
