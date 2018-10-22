#!/usr/bin/env bash

# this is to be executed only after nfs server (wit nfs-wget image) is up

CUBE_NAME=$1
NFS_POD=$(kubectl --namespace jupyterhub get pods --no-headers -o custom-columns=":metadata.name" --selector role=nfs-server)

kubectl --namespace jupyterhub exec -i ${NFS_POD} -- wget -nH -r --cut-dirs=1 --user=demo1 --ask-password  -P /exports/datacube ftp://ftp.brockmann-consult.de/cablab02/${CUBE_NAME}
