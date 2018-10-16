#!/usr/bin/env bash

# initially, a volume called datacube shall be created (only a one-time execution)
# gcloud compute --project=jupyterhub-218810 disks create datacube --zone=europe-west3-a --type=pd-standard --size=300GB
kubectl create -n jupyterhub -f nfs-server-gce-pv.yaml
kubectl create -n jupyterhub -f nfs-server-gce-pvc.yaml
