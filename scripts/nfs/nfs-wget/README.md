## NFS-WGET Docker image

This is a Docker recipe to update nfs container image from [Google](https://console.cloud.google.com/gcr/images/google-containers/GLOBAL) to also include `wget`, which is used for downloading cube data.

To build this image:

```bash
docker build -t eu.gcr.io/jupyterhub-218810/nfs-wget:0.8 .
```

To push the image to private GCR:

```bash
docker push eu.gcr.io/jupyterhub-218810/nfs-wget:0.8
```

**NOTE**: project ID may need to be updated

To download the cube data from BC FTP:

```bash
./download-esdl-cube.sh [cube name]
```