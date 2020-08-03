## Description

This docker-compose file allows you to create an robust rabbitmq cluster for local development

It uses the [official rabbitmq docker image](https://hub.docker.com/_/rabbitmq?tab=description) :rocket:


### * Note on features

The default version is the **rabbitmq version 3.8.1** because of its SAC capability, namely having multiple consumers on one particular queue but with only one active at a time.

Tested on macOS Sierra (version 10.12.6) and Ubuntu 18

I needed an local rabbitmq cluster with these defaults for development purposes, but they are all easily customizable:

 - ha policy (mirroring of queues on all nodes)
 - pause minority as the partition handling strategy (because s*** happens and you need to be prepared)
 

## General Instructions

Just clone this repo, and run the following commands:

```
chmod +x ./create_cluster.sh

docker-compose up -d && ./create_cluster.sh
or
docker-compose up 
./create_cluster.sh
```

The bash script joins the slave nodes to the cluster and it just needs to run once, 
on every other usage just run the compose file.

My intent was not to change the original rabbitmq docker image, but just boost it a little to create a practical rabbitmq cluster.

## Release Notes

### Latest Changes

### 1.0.0

2020-07-27:

* The starting point is with the docker-compose version 3.7

## License

This project is licensed under the terms of the MIT license.
