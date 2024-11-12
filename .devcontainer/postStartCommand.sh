#!/bin/bash

echo "export CLUSTER_NAME=${CODESPACE_NAME%-*}" >> "$HOME/.zshrc"
echo "alias k=kubectl" >> "$HOME/.zshrc"
