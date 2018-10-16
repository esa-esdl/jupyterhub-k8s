#!/usr/bin/env bash

# make sure that the NFS server IP address is updated based on the NFS service before running this script
# to get the NFS service IP address, run `kubectl describe -n jupyterhub services nfs-server`
kubectl create -n jupyterhub -f nfs-pv.yaml
kubectl create -n jupyterhub -f nfs-pvc.yaml
