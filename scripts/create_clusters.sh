#!/usr/bin/env bash

export CORE_CLUSTER_NAME=core-cluster
export CORE_MACHINE_TYPE=n1-standard-2
export CORE_BOOT_DISK_TYPE=pd-standard
export CORE_NUM_NODES=1
export CORE_ZONE=europe-west3-a
export JUPYTER_USER_MACHINE_TYPE=n1-standard-2
export JUPYTER_USER_BOOT_DISK_TYPE=pd-standard
export JUPYTER_USER_MIN_NODES=0
export JUPYTER_USER_MAX_NODES=10
export JUPYTER_USER_ZONE=europe-west3-a
export MIN_CPU_PLATFORM="Intel Broadwell"

echo "Creating the cluster and a node pool for the core pods..."

gcloud beta container clusters create $CORE_CLUSTER_NAME \
  --enable-ip-alias \
  --enable-kubernetes-alpha \
  --num-nodes $CORE_NUM_NODES \
  --zone $CORE_ZONE \
  --disk-type $CORE_BOOT_DISK_TYPE \
  --machine-type $CORE_MACHINE_TYPE \
  --min-cpu-platform "$MIN_CPU_PLATFORM" \
  --num-nodes $CORE_NUM_NODES \
  --cluster-version 1.10 \
  --node-labels hub.jupyter.org/node-purpose=core \
  --no-enable-autoupgrade \
  --no-enable-autorepair

echo "Creating a secondary autoscaling node pool for user pods..."

gcloud beta container node-pools create user-pool \
  --cluster $CORE_CLUSTER_NAME \
  --disk-type $JUPYTER_USER_BOOT_DISK_TYPE \
  --machine-type $JUPYTER_USER_MACHINE_TYPE \
  --min-cpu-platform "$MIN_CPU_PLATFORM" \
  --num-nodes 0 \
  --zone $JUPYTER_USER_ZONE \
  --enable-autoscaling \
  --min-nodes $JUPYTER_USER_MIN_NODES \
  --max-nodes $JUPYTER_USER_MAX_NODES \
  --node-labels hub.jupyter.org/node-purpose=user \
  --node-taints hub.jupyter.org_dedicated=user:NoSchedule \
  --no-enable-autoupgrade \
  --no-enable-autorepair
