# GitOps Demo

- Start in the root of this repo

## Deploy cert-manager

```bash

# Copy the Flux Kustomize yaml definition to the lab01 cluster
cp demo/cert-manager.yaml clusters/lab01/flux-listeners

# push to git
git add .
git commit -am "quick start demo"
git push

# force flux to reconcile
flux reconcile source git gitops

# check pods for cert-manager
kubectl get pods -A

```

## Deploy heartbeat

```bash

# Copy the Flux HelmRelease yaml definition to the lab01 cluster
cp demo/heartbeat.yaml clusters/lab01/flux-listeners

# push to git
git add .
git commit -am "quick start demo"
git push

# force flux to reconcile
flux reconcile source git gitops

# check pods for heartbeat
kubectl get pods -A

```

## Deploy POS

```bash

# Copy the Flux HelmRelease yaml definition to the lab01 cluster
cp demo/pos.yaml clusters/lab01/flux-listeners

# push to git
git add .
git commit -am "quick start demo"
git push

# force flux to reconcile
flux reconcile source git gitops

# check pods for POS
# it didn't deploy
kubectl get pods -A

# check helmreleases
# notice the error
kubectl get helmrelease -A

# copy the per cluster values.yaml file
cp -r demo/pos clusters/lab01

# push to git
git add .
git commit -am "quick start demo"
git push

# force flux to reconcile
flux reconcile source git gitops

# check pods for POS
kubectl get pods -A

```
