## Description

This docker-compose file allows you to create an robust rabbitmq cluster

It uses the [official rabbitmq docker image](https://hub.docker.com/_/rabbitmq?tab=description) :rocket:


### * Note on features

Starting with the **rabbitmq version 3.8.1** because of its SAC capability, namely having multiple consumers on one particular queue but with only one active at a time.

You can use this docker-compose file on macos and linux machines

The default image is **rabbitmq:3.8.1-management** so that you can easily manage your cluster from the web interface

## General Instructions

Just clone this repo, and run the following command:

```
docker-compose up [-d]
```



## Release Notes

### Latest Changes

### 1.0.0

2020-07-27:

* The starting point is with the docker-compose version 3.7

## License

This project is licensed under the terms of the MIT license.
