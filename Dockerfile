FROM python:3.12-slim-bookworm

# Instala dependências do sistema e Python
USER root
RUN apt-get update \
    && apt-get install -y --no-install-recommends iputils-ping git curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Atualiza o pip e instala as dependecias para o airflow
ADD requirements.txt .
RUN pip install --upgrade pip \
    && pip install -r requirements.txt

# Instala golang
WORKDIR /usr/local
ENV GO_VERSION=1.22.5
RUN curl -OL https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz \
    && tar -C /usr/local -xvf go${GO_VERSION}.linux-amd64.tar.gz

ENV GOPATH=/go
ENV PATH=$GOPATH/bin:/usr/local/go/bin:$PATH
RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"

# Copia o arquivo requirements.txt para o contêiner
COPY requirements.txt .

#USER hunter
RUN go install -v github.com/HuntDownProject/hednsextractor/cmd/hednsextractor@latest \
    && go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest \
    && go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest \
    && go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest \
    && go install -v github.com/tomnomnom/anew@latest

WORKDIR /root