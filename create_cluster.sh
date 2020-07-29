#!/usr/bin/env bash

# setup the HA mode on rabbit1 (master) node
docker exec -it rabbit1 rabbitmqctl

# these specific command are for the "slave nodes/containers" only
docker exec -it rabbit2 rabbitmqctl stop_app

docker exec -it rabbit2 rabbitmqctl reset

docker exec -it rabbit2 rabbitmqctl join_cluster rabbit@rabbit1

docker exec -it rabbit2 rabbitmqctl start_app



# if I will use a side container for the cluster management part
 - it will need rabbitmqctl command on different containers...
 - have to wait and know when every node is up and ready for taking commands....

# on the master, wait until is up and add the ha mode command on it
# in the slave, wait until is up and join them to the cluster....
# check if the slaves need to join to the cluster after...

# or just run the script from the host machine :)
