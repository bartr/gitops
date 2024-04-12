# Azure Arc for GitOps Sample

- A sample GitOps repository for Azure Arc for GitOps

## Prerequisites

- Azure Arc enabled Kubernetes Cluster

## Install Arc for GitOps

- Set environment variables

```bash

export PAT=myPersonalAccessToken
export CLUSTER_NAME=lab-01

```

- Use az CLI to install Arc for GitOps

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
  --resource-group arc \
  --url https://github.com/bartr/gitops \
  --branch main \
  --https-key "$PAT" \
  --kustomization \
      name=flux-system \
      path=./clusters/lab-01/flux-listeners \
      timeout=3m \
      sync_interval=1m \
      retry_interval=1m \
      prune=true \
      force=true

```

- Working in progress

## Support

This project uses GitHub Issues to track bugs and feature requests. Please search the existing issues before filing new issues to avoid duplicates.  For new issues, file your bug or feature request as a new issue.

## Contributing

This project welcomes contributions and suggestions and has adopted the [Contributor Covenant Code of Conduct](https://www.contributor-covenant.org/version/2/1/code_of_conduct.html).

For more information see [Contributing.md](./.github/CONTRIBUTING.md)

## Trademarks

This project may contain trademarks or logos for projects, products, or services. Any use of third-party trademarks or logos are subject to those third-party's policies.
