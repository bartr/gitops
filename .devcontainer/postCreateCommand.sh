#!/bin/bash

{
    echo ""
    echo "export CLUSTER_NAME=${CODESPACE_NAME%-*}" >> "$HOME/.zshrc"
} >> "$HOME/.oh-my-zsh/custom/alias.zsh"

echo "Creating k3d cluster"
# k3d cluster create \
# -p '80:80@loadbalancer' \
# -p '443:443@loadbalancer' \
# -p '8080:8080@loadbalancer'
