#!/usr/bin/env bash

kubectl create -n jupyterhub -f nfs-server-rc.yaml
kubectl create -n jupyterhub -f nfs-server-service.yaml
