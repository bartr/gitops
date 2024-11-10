FROM mcr.microsoft.com/devcontainers/universal:2-linux

# Install k9s
RUN wget https://github.com/derailed/k9s/releases/download/v0.28.0/k9s_Linux_amd64.tar.gz && \
    tar xf k9s_Linux_amd64.tar.gz --directory=/usr/local/bin k9s && \
    chmod +x /usr/local/bin/k9s && \
    rm -rf k9s_Linux_amd64.tar.gz
