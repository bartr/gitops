#!/bin/bash

echo "export CLUSTER_NAME=${CODESPACE_NAME%-*}" >> "$HOME/.zshrc"

# Create aliases
mkdir -p "$HOME/.oh-my-zsh/customizations"
echo "alias k='kubectl'" >> "$HOME/.oh-my-zsh/customizations/alias.zsh"
echo "alias kaf='kubectl apply -f'" >> "$HOME/.oh-my-zsh/customizations/alias.zsh"
echo "alias kak='kubectl apply -k'" >> "$HOME/.oh-my-zsh/customizations/alias.zsh"
echo "alias kdelf='kubectl delete -f'" >> "$HOME/.oh-my-zsh/customizations/alias.zsh"
echo "alias kl='kubectl logs'" >> "$HOME/.oh-my-zsh/customizations/alias.zsh"
