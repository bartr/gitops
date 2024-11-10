echo 'export CODESPACES="FALSE"' >> ~/.bashrc
echo 'export CLUSTER_NAME=${CODESPACE_NAME%-*}' >> ~/.bashrc
source ~/.bashrc
