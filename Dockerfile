FROM golang:1.21-alpine AS build-env

RUN apk add build-base

# Remove the go install commands as they are not valid Dockerfile instructions

RUN apk add --no-cache git \
    && go install -v github.com/tomnomnom/anew@latest \
    && go install -v github.com/HuntDownProject/hednsextractor/cmd/hednsextractor@latest \
    && go install -v github.com/projectdiscovery/pdtm/cmd/pdtm@latest

# Release
FROM alpine:3.18.6

COPY --from=build-env /go/bin /usr/local/bin/

RUN apk -U upgrade --no-cache \
    && apk add --no-cache bind-tools chromium ca-certificates python3 py3-pip \
    && rm -rf /var/cache/apk/* \
    && update-ca-certificates \
    && python -m ensurepip \
    && pdtm -install-all -bp $HOME/go/bin

# Adicionar configurações de PATH ao /etc/profile
RUN echo "export PATH=$HOME/bin:$HOME/go/bin:$PATH" >> /etc/profile

# Carregar /etc/profile ao iniciar o shell
RUN echo "source /etc/profile" >> /etc/profile

# Definir o WORKDIR
WORKDIR /root

# Definir o ENTRYPOINT
ENTRYPOINT ["/bin/sh"]
