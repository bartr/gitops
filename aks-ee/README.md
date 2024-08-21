# Installing Arc from PowerShell

## Install Azure CLI

```powershell

choco install azure-cli

```

## Update az CLI

```powershell

az upgrade

```

## Login to azure

- Login to Azure with the subscription that will contain the Arc resource group

```powershell

az login

```

## Add CA Certs

```powershell

copy "c:\Program Files\Microsoft SDKs\Azure\CLI2\Lib\site-packages\certifi\cacert.pem"

# run open ssl in git bash
"c:\Program Files\Git\usr\bin\openssl.exe" pkcs12 -export -nokeys -out cacert.pfx -in cacert.pem

powershell Import-PfxCertificate -CertStoreLocation Cert:\LocalMachine\Root -FilePath cacert.pfx;

```

## Add certs

```powershell

# check / install certs
Get-ChildItem -Path Cert:\LocalMachine\Root | Where-Object {$_.Subject -like "CN=Microsoft Root Certificate Authority 2011*"}
# certutil.exe -addstore -f "AuthRoot" "MicrosoftRootCertificateAuthority2011.cer"

Get-ChildItem -Path Cert:\LocalMachine\CA | Where-Object {$_.Subject -like "CN=Microsoft Code Signing PCA 2011*"}
# certutil.exe -addstore -f "CA" "MicCodSigPCA2011_2011-07-08.crt"

```

## Install kubectl

```powershell

az aks install-cli

```

## Enable Extensions

```powershell

az extension add --yes --upgrade --name connectedk8s
az extension add --yes --upgrade --name k8s-configuration
az extension add --yes --upgrade --name  k8s-extension
az provider register --wait --consent-to-permissions --namespace Microsoft.Kubernetes
az provider register --wait --consent-to-permissions --namespace Microsoft.KubernetesConfiguration
az provider register --wait --consent-to-permissions --namespace Microsoft.ExtendedLocation

```

## Install AKS EE

- Follow the setup instructions

## Select K8s Context

- Verify kubectl is using the correct cluster

```powershell

kubectl config get-contexts

```

## Create Arc Secret

- You will need this to connect to the cluster in the Azure portal
- Save the secret for future use

```powershell

kubectl create serviceaccount arc -n default
kubectl create clusterrolebinding demo-user-binding --clusterrole cluster-admin --serviceaccount default:arc

kubectl apply -f arc-secret.yaml

kubectl get secret arc-secret -o jsonpath='{$.data.token}' | %{[Text.Encoding]::UTF8.GetString([Convert]::FromBase64String($_))}

```

## Select Azure Sub

- Use `az account set -s subNameOrID` if necessary

```powershell

az account list -o table

```

## Set Env Vars

- Change these as appropriate

```powershell

$ARC_RG="arc"
$ARC_NAME="lab-01"

```

## Create Resource Group

```powershell

az group create -l eastus -n $ARC_RG

```

## Enable Arc

```powershell

az connectedk8s connect --name $ARC_NAME --resource-group $ARC_RG

```

## Enable Arc GitOps

- Set PAT environment variable
- Update repo name

```powershell
# Add flux extension
az k8s-configuration flux create `
  --url https://github.com/dominos-pizza/repoName `
  --https-key $PAT `
  --cluster-type connectedClusters `
  --interval 1m `
  --kind git `
  --name gitops `
  --namespace flux-system `
  --scope cluster `
  --timeout 3m `
  --https-user gitops `
  --cluster-name Lab-02 `
  --resource-group arc `
  --branch labs `
  --kustomization `
      name=flux-system `
      path=./clusters/Lab-02/flux-system/listeners `
      timeout=3m `
      sync_interval=1m `
      retry_interval=1m `
      prune=true `
      force=true
```
