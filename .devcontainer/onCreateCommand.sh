#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

echo "onCreate start"

# Change shell to zsh for vscode
sudo chsh --shell /bin/zsh vscode

# Copy the custom first run notice
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

echo "generating completions"
mkdir -p "$HOME/.oh-my-zsh/completions"
helm completion zsh > "$HOME/.oh-my-zsh/completions/_helm"
kubectl completion zsh > "$HOME/.oh-my-zsh/completions/_kubectl"
k3d completion zsh > "$HOME/.oh-my-zsh/completions/_k3d"
kustomize completion zsh > "$HOME/.oh-my-zsh/completions/_kustomize"

# Create aliases
mkdir -p "$HOME/.oh-my-zsh/customizations"
{
    echo "#kubectl aliases"
    echo "alias k='kubectl'"
    echo "alias kaf='kubectl apply -f'"
    echo "alias kak='kubectl apply -k'"
    echo "alias kdelf='kubectl delete -f'"
    echo "alias kl='kubectl logs'"

    echo ""
    echo "#remove git aliases"
    echo "for alias_name in \$(alias | grep 'git' | awk -F'=' '{print \$1}' | sed \"s/'//g\"); do"
    echo "    unalias \$alias_name"
    echo "done"

    echo ""
    echo "#remove deprecated aliases"
    echo "for alias_name in \$(alias | grep 'deprecated alias' | awk -F'=' '{print \$1}' | sed \"s/'//g\"); do"
    echo "    unalias \$alias_name"
    echo "done"
} > "$HOME/.oh-my-zsh/custom/alias.zsh"

sudo apt-get update

# only run apt upgrade on pre-build
if [ "$CODESPACE_NAME" = "null" ]; then
    sudo apt-get upgrade -y
fi

echo "onCreate complete"
