#!/bin/bash

echo "export CLUSTER_NAME=${CODESPACE_NAME%-*}" >> "$HOME/.zshrc"

# Create aliases
mkdir -p "$HOME/.oh-my-zsh/customizations"
{
    echo "alias k='kubectl'"
    echo "alias kaf='kubectl apply -f'"
    echo "alias kak='kubectl apply -k'"
    echo "alias kdelf='kubectl delete -f'"
    echo "alias kl='kubectl logs'"
} >> "$HOME/.oh-my-zsh/custom/alias.zsh"
