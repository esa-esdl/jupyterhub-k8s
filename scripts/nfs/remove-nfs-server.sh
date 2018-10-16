#!/usr/bin/env bash

kubectl delete -n jupyterhub rc nfs-server 
kubectl delete -n jupyterhub service nfs-server
kubectl delete -n jupyterhub pvc nfs
kubectl delete -n jupyterhub pv nfs
kubectl delete -n jupyterhub pvc nfs-pv
kubectl delete -n jupyterhub pv datacube
