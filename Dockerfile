FROM golang:1.21-alpine AS build-env

RUN apk add build-base

# Remove the go install commands as they are not valid Dockerfile instructions

RUN apk add --no-cache git \
    && go install -v github.com/tomnomnom/anew@latest \
    && go install -v github.com/HuntDownProject/hednsextractor/cmd/hednsextractor@latest \
    && go install -v github.com/projectdiscovery/pdtm/cmd/pdtm@latest

# Add the following line to the Dockerfile to set the PATH environment variable
ENV PATH=$PATH:/go/bin

# Release
FROM alpine:3.18.6

COPY --from=build-env /go/bin /usr/local/bin/

RUN apk -U upgrade --no-cache \
    && apk add --no-cache bind-tools chromium ca-certificates \
    && rm -rf /var/cache/apk/* \
    && update-ca-certificates \
    && pdtm -install-all

# Add the following line to the Dockerfile to set the WORKDIR
WORKDIR /root

# Add the following line to the Dockerfile to set the ENTRYPOINT
ENTRYPOINT ["/bin/sh"]