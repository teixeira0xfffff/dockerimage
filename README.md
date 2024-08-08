# bloodhound

[![Docker Image CI for GHCR](https://github.com/neriberto/bloodhound/actions/workflows/publish-ghcr.yaml/badge.svg)](https://github.com/neriberto/bloodhound/actions/workflows/publish-ghcr.yaml)


## Install

```
docker pull ghcr.io/neriberto/bloodhound:latest
```

## Applications

* `HEDnsExtractor` - [github.com/HuntDownProject/hednsextractor](https://github.com/HuntDownProject/hednsextractor)
* `KoodousFinder` - [https://github.com/HuntDownProject/KoodousFinder](https://github.com/HuntDownProject/KoodousFinder)
* `pdtm` - All tools from Project Discovery using the [github.com/projectdiscovery/pdtm](https://github.com/projectdiscovery/pdtm)
* `anew` - [github.com/tomnomnom/anew](https://github.com/tomnomnom/anew)
* `apkd` - [https://github.com/kiber-io/apkd](https://github.com/kiber-io/apkd)
* `mc` - [Minio](https://min.io/) command line
* `rayder` - [Rayder](https://github.com/devanshbatham/rayder) is a lightweight tool for orchestrating and organizing your command-line workflows

## Usage Examples

1. Easy run, interactive mode getting a shell

```bash
$ docker run -it ghcr.io/neriberto/bloodhound:latest
```

2. Updating nuclei templates and keep it locally

```bash
$ docker volume create nuclei
$ docker run -it -v nuclei:/root/nuclei-templates ghcr.io/neriberto/bloodhound:latest
```