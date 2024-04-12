# Azure Arc for GitOps Sample

- A sample GitOps repository for Azure Arc for GitOps

## Prerequisites

- Azure Arc enabled Kubernetes Cluster

## Install Arc for GitOps

- Set environment variables

```bash

export PAT=myPersonalAccessToken
export CLUSTER_NAME=lab-01
export ARC_RG=arc

```

## Create cert-manager Kustomization

```bash

az k8s-configuration flux create \
  --cluster-type connectedClusters \
  --interval 1m \
  --kind git \
  --name gitops \
  --namespace flux-system \
  --scope cluster \
  --timeout 3m \
  --https-user gitops \
  --cluster-name $CLUSTER_NAME \
  --resource-group $ARC_RG \
  --url https://github.com/bartr/gitops \
  --branch main \
  --https-key "$PAT" \
  --kustomization \
      name=cert-manager \
      path=./releases/cert-manager \
      timeout=3m \
      sync_interval=1m \
      retry_interval=1m \
      prune=true \
      force=true

```

## Create heartbeat Kustomization

```bash

az k8s-configuration flux create \
  --cluster-type connectedClusters \
  --interval 1m \
  --kind git \
  --name gitops \
  --namespace flux-system \
  --scope cluster \
  --timeout 3m \
  --https-user gitops \
  --cluster-name $CLUSTER_NAME \
  --resource-group $ARC_RG \
  --url https://github.com/bartr/gitops \
  --branch main \
  --https-key "$PAT" \
  --kustomization \
      name=heartbeat \
      path=./releases/heartbeat \
      timeout=3m \
      sync_interval=1m \
      retry_interval=1m \
      prune=true \
      force=true

```

## Create POS Helm Chart

```bash

az k8s-configuration flux create \
  --cluster-type connectedClusters \
  --interval 1m \
  --kind git \
  --name gitops \
  --namespace flux-system \
  --scope cluster \
  --timeout 3m \
  --https-user gitops \
  --cluster-name $CLUSTER_NAME \
  --resource-group $ARC_RG \
  --url https://github.com/bartr/gitops \
  --branch main \
  --https-key "$PAT" \
  --kustomization \
      name=pos \
      path=./releases/pos \
      timeout=3m \
      sync_interval=1m \
      retry_interval=1m \
      prune=true \
      force=true

```

## Support

This project uses GitHub Issues to track bugs and feature requests. Please search the existing issues before filing new issues to avoid duplicates.  For new issues, file your bug or feature request as a new issue.

## Contributing

This project welcomes contributions and suggestions and has adopted the [Contributor Covenant Code of Conduct](https://www.contributor-covenant.org/version/2/1/code_of_conduct.html).

For more information see [Contributing.md](./.github/CONTRIBUTING.md)

## Trademarks

This project may contain trademarks or logos for projects, products, or services. Any use of third-party trademarks or logos are subject to those third-party's policies.
