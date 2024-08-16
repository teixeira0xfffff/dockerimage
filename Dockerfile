FROM golang:1.22-alpine AS build-env

# Remove the go install commands as they are not valid Dockerfile instructions
RUN apk add --no-cache build-base git \
    && go install -v github.com/tomnomnom/anew@latest \
    && go install -v github.com/HuntDownProject/hednsextractor/cmd/hednsextractor@latest \
    && go install -v github.com/HuntDownProject/logme/cmd/logme@latest \
    && go install -v github.com/projectdiscovery/pdtm/cmd/pdtm@latest \
    && go install -v github.com/devanshbatham/rayder@v0.0.4

# Release
FROM alpine:3.18.6

COPY --from=build-env /go/bin /root/go/bin
COPY requirements.txt requirements.txt

RUN echo "export PATH=$HOME/bin:$HOME/go/bin:$HOME/.pdtm/go/bin:$PATH" >> /etc/profile \
    && apk -U upgrade --no-cache \
    && apk add --no-cache git curl bind-tools chromium ca-certificates python3 py3-pip vim nano \
    && update-ca-certificates \
    && python -m ensurepip \
    && pip install -r requirements.txt \
    && curl -o /usr/local/bin/mc https://dl.min.io/client/mc/release/linux-amd64/mc \
    && chmod +x /usr/local/bin/mc \
    && source /etc/profile && pdtm -install-all \
    && rm -rf /var/cache/apk/*

# Add the following line to the Dockerfile to set the WORKDIR
WORKDIR /root
ENV ENV="/etc/profile"
ENV PATH=/root/bin:/root/go/bin:/root/.pdtm/go/bin:$PATH
