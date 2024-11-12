#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

echo "on-create start"
echo "$(date +'%Y-%m-%d %H:%M:%S')    on-create start" >> "$HOME/status"

# Change shell to zsh for vscode
sudo chsh --shell /bin/zsh vscode

# Copy the custom first run notice over
if [ -f .devcontainer/welcome.txt ]; then
    sudo cp .devcontainer/welcome.txt /usr/local/etc/vscode-dev-containers/first-run-notice.txt
fi

# configure git
git config --global core.whitespace blank-at-eol,blank-at-eof,space-before-tab
git config --global pull.rebase false
git config --global init.defaultbranch main
git config --global fetch.prune true
git config --global core.pager more
git config --global diff.colorMoved zebra
git config --global devcontainers-theme.show-dirty 1
git config --global core.editor "nano -w"

# Create k3d cluster and forwarded ports
# k3d cluster delete
# k3d cluster create \
# -p '1883:1883@loadbalancer' \
# -p '8883:8883@loadbalancer'

echo "generating completions"
mkdir -p "$HOME/.oh-my-zsh/completions"
helm completion zsh > "$HOME/.oh-my-zsh/completions/_helm"
kubectl completion zsh > "$HOME/.oh-my-zsh/completions/_kubectl"
k3d completion zsh > "$HOME/.oh-my-zsh/completions/_k3d"
kustomize completion zsh > "$HOME/.oh-my-zsh/completions/_kustomize"

sudo apt-get update

# only run apt upgrade on pre-build
if [ "$CODESPACE_NAME" = "null" ]; then
    echo "$(date +'%Y-%m-%d %H:%M:%S')    upgrading" >> "$HOME/status"
    sudo apt-get upgrade -y
fi

echo "on-create complete"
echo "$(date +'%Y-%m-%d %H:%M:%S')    on-create complete" >> "$HOME/status"
