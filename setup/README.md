# Deploy Flux to Lab Cluster

```bash

# clone this repo
git clone https://github.com/bartr/gitops
cd gitops
git pull

# checkout this branch
git checkout quickstart --
git pull

cd setup

# create the namespace
kubectl apply -f namespace.yaml

# create the Flux secret (substitute $PAT)
# the PAT must have permissions to the repo
flux create secret git flux-system -n flux-system --url https://github.com/bartr/gitops -u gitops -p $PAT

# deploy the Flux components
kubectl apply -f components.yaml

# create the Flux Source
kubectl apply -f source.yaml

# this single kustomization will manage all of the kustomizations and Helm Releases
cd ../clusters/lab01/flux-listeners
kubectl apply -f flux-kustomization.yaml

# force flux to reconcile
flux reconcile source git gitops

# check pods for flux-system
kubectl get pods -A

```
