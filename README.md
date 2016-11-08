# docker-ts
Fingerland Teamspeak server

## Quickstart

edit the top of the `Makefile` to feet to your need.

### Install from sources

```
make build
```

### prepare volume if need 

```
make volume
```

### run the docker

```
make run
```

## SystemD

to manage the docker using systemd:

```
make systemd-service
```

It will create the service file and an environment file.
