FROM golang:1.21-alpine AS build-env

RUN apk add build-base

# Remove the go install commands as they are not valid Dockerfile instructions
RUN apk add --no-cache git \
    && go install -v github.com/HuntDownProject/hednsextractor/cmd/hednsextractor@latest \
    && go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest \
    && go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest \
    && go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest \
    && go install -v github.com/projectdiscovery/notify/cmd/notify@latest \
    && go install -v github.com/tomnomnom/anew@latest \
    && go install -v github.com/devanshbatham/rayder@v0.0.4

# Release
FROM alpine:3.18.6

COPY --from=build-env /go/bin /usr/local/go/bin

ADD requirements.txt requirements.txt

RUN echo "export PATH=/usr/local/go/bin:$HOME/bin:$HOME/go/bin:$PATH" >> /etc/profile \
    && apk -U upgrade --no-cache \
    && apk add --no-cache git curl bind-tools chromium ca-certificates python3 py3-pip vim nano \
    && update-ca-certificates \
    && python -m ensurepip \
    && pip install -r requirements.txt \
    && curl -o /usr/local/bin/mc https://dl.min.io/client/mc/release/linux-amd64/mc \
    && chmod +x /usr/local/bin/mc \
    && rm -rf /var/cache/apk/*

# Add the following line to the Dockerfile to set the WORKDIR
WORKDIR /root
ENV ENV="/etc/profile"
