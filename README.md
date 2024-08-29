## Install

```
docker pull ghcr.io/teixeira0xfffff/dockerimage:latest
```

## Applications

* `HEDnsExtractor` - [github.com/HuntDownProject/hednsextractor](https://github.com/HuntDownProject/hednsextractor)
* `KoodousFinder` - [https://github.com/HuntDownProject/KoodousFinder](https://github.com/HuntDownProject/KoodousFinder)
* `pdtm` - All tools from Project Discovery using the [github.com/projectdiscovery/pdtm](https://github.com/projectdiscovery/pdtm)
* `anew` - [github.com/tomnomnom/anew](https://github.com/tomnomnom/anew)
* `apkd` - [https://github.com/kiber-io/apkd](https://github.com/kiber-io/apkd)
* `mc` - [Minio](https://min.io/) command line
* `rayder` - [Rayder](https://github.com/devanshbatham/rayder) is a lightweight tool for orchestrating and organizing your command-line workflows
* `dirhunt` - [dirhunt]([https://github.com/sherlock-project/sherlock/](https://github.com/Nekmo/dirhunt)) command line
* `sherlock` - [sherlock]([https://github.com/sherlock-project/sherlock/](https://github.com/sherlock-project/sherlock)) command line

## Usage Examples

1. Easy run, interactive mode getting a shell

```bash
$ docker run -it ghcr.io/teixeira0xfffff/dockerimage:latest
```

2. Updating nuclei templates and keep it locally

```bash
$ docker volume create nuclei
$ docker run -it -v nuclei:/root/nuclei-templates ghcr.io/teixeira0xfffff/dockerimage:latest 
```
