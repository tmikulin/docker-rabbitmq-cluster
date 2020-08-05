## Description

This docker-compose file allows you to create an **rabbitmq cluster** for local development or testing

It uses the [official rabbitmq docker image](https://hub.docker.com/_/rabbitmq?tab=description) :rocket:


### * Note on features

The default version is the **rabbitmq version 3.8.1** because of its [SAC capability](https://www.cloudamqp.com/blog/2019-04-23-rabbitmq-3-8-feature-focus-single-active-consumer.html), namely having multiple consumers on one particular queue but with only one active at a time.

The compose file is setup with sane defaults that you can change (.env file), and the `bash script + advanced.config` with the added modifications for the cluster configuration:

 - `ha policy` (mirroring of queues on all nodes)
 - `pause minority` as the partition handling strategy (because s*** happens :fire: and you need to be prepared)
 

## General Instructions

Just clone this repo, and run the following commands:

```
chmod +x ./create_cluster.sh

docker-compose up -d && ./create_cluster.sh
or
docker-compose up 
./create_cluster.sh
```

The bash script joins the slave nodes to the cluster and it just needs to `run once` :warning:, 
on every other usage just run the compose file.

My intent was not to change the original rabbitmq docker image, but just boost it a little to create a `practical rabbitmq cluster`.

Tested on macOS Sierra (version 10.12.6) and Ubuntu/Kubuntu 18
```
docker version 19.03.8/11
docker-compose 1.22.0/1.25.5
```


## Release Notes

### Latest Changes

### 1.0.0-rc.1

2020-08-05:

* The starting point is with the rabbitmq version 3.8.1

## License

This project is licensed under the terms of the MIT license.
