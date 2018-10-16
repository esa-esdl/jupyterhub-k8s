# jupyterhub-k8s

A full instruction on how to deploy Jupyterhub with Kubernetes is available [here](https://zero-to-jupyterhub-with-kubernetes.readthedocs.io/en/latest/index.html). This repository is more of a documentation on what has been done in regards to Jupyterhub deployment for ESDL project. The scripts and configurations are created specifically for this purpose. 

## Deployment at GKE

All the commands below are to be executed inside Google Cloud Shell.

to create a cluster:
* `./create_clusters.sh`

to start Jupyterhub:
* `gcloud container clusters create jupyterhub-kubernetes --num-nodes=2 --machine-type=n1-standard-1 --zone=europe-west3-a`
* `git clone https://github.com/esa-esdl/jupyterhub-k8s.git`
* `cd jupyterhub-k8s`
* `./initialize-helm.sh`
* `./install-jupyterhub.sh`
	
to stop and remove (also remove cluster):
* `./remove-jupyterhub-kube.sh`
* `gcloud container clusters delete jupyterhub-kubernetes --zone=europe-west3-a`
	
to create nfs server (for the datacube):
* `cd nfs`
* `./create-nfs-server.sh`
* `./create-nfs-volume.sh`
	
to upload existing Docker images to GCR:
* follow this instruction: https://cloud.google.com/container-registry/docs/pushing-and-pulling
  * for authentication, run gcloud auth login
	
More resources:
* https://gist.github.com/tallclair/849601a16cebeee581ef2be50c351841 (mount git repo using emptyDir)
* https://github.com/kubernetes/examples/tree/master/staging/volumes/nfs (create nfs persistent volume)
