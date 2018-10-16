#!/usr/bin/env bash

kubectl --namespace=jupyterhub delete deployments --all
kubectl --namespace=jupyterhub delete service --all
kubectl --namespace=jupyterhub delete jobs --all
kubectl --namespace=jupyterhub delete daemonsets --all
kubectl --namespace=jupyterhub delete pods --all
kubectl --namespace=jupyterhub delete statefulset --all
helm del --purge jupyterhub-kube
