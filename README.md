# jupyterhub-k8s

A full instruction on how to deploy Jupyterhub with Kubernetes is available [here](https://zero-to-jupyterhub-with-kubernetes.readthedocs.io/en/latest/index.html). This repository is more of a documentation on what has been done in regards to Jupyterhub deployment for ESDL project. The scripts and configurations are created specifically for this purpose. 

## Deployment at GKE

All the commands below are to be executed inside Google Cloud Shell.

#### Create a cluster
* `git clone https://github.com/esa-esdl/jupyterhub-k8s.git`
* `cd jupyterhub-k8s/scripts`
* `./create_clusters.sh`

#### Install and Start Jupyterhub
* `vim config.yaml`
  * `proxy.secretToken`: generate the [secret token](https://zero-to-jupyterhub.readthedocs.io/en/latest/reference.html?highlight=secrettoken#proxy-secrettoken)
  * `proxy.service.loadBalancerIP`: reserve a static IP address and use its value (in GCP: go to Networking > VPC network > External IP addresses, and then click `reserve static address`)
  * `proxy.https.hosts`: select a host name
  * `proxy.https.letsencrypt.contactEmail`: an email address to which an expiry notice will be sent
  * `auth.admin.users`: list of GitHub usernames that will have admin role
  * `auth.whitelist.users`: list of GitHub usernames that are allowed access to the Jupyterhub
  * `auth.github.[clientId|clientSecret|callbackUrl]`: information required for OAuth using [GitHub](https://zero-to-jupyterhub-with-kubernetes.readthedocs.io/en/latest/authentication.html?highlight=github#github)
* `./initialize-helm.sh`
* `./install-jupyterhub.sh`
* `kubectl -n jupyterhub get all` -> _to check if installation has been successful. Ensure that none of the pods or services indicates some errors. It may take a while until all the Kubernetes objects are up and running._

#### Upgrade Jupyterhub after configuration changes
* `helm upgrade jupyterhub-kube jupyterhub/jupyterhub --version=v0.8-e29f3e7 -f config.yaml`
	
#### Stop and remove Jupyterhub (also remove cluster)
* `./remove-jupyterhub-kube.sh`
* `gcloud container clusters delete jupyterhub-kubernetes --zone=europe-west3-a`
	
#### Create NFS server (for the datacube)
* `cd nfs`
* `./create-datacube-volume.sh`
* `./create-nfs-server.sh`
* `kubectl -n jupyterhub describe service nfs-server`
  * copy the value of `IP` field, to be used on the next step
* `vim nfs-pv.yaml`
  * update the value of `spec.nfs.server` to use the value from the previous step
* `./create-nfs-volume.sh`
	
#### Upload existing Docker images to GCR
* follow this instruction: https://cloud.google.com/container-registry/docs/pushing-and-pulling
  * for authentication, run `gcloud auth login` and then follow the instructions
	
More resources:
* https://gist.github.com/tallclair/849601a16cebeee581ef2be50c351841 (mount git repo using emptyDir)
* https://github.com/kubernetes/examples/tree/master/staging/volumes/nfs (create nfs persistent volume)
