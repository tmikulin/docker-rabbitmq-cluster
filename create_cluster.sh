#!/usr/bin/env bash

set -e

# define all the slave nodes here
# just make sure you always have an quorum
# 3,5,7 of nodes including the master
slaves=(rabbit2 rabbit3)

# check until rabbit1/master is up
while ! nc -z localhost 5672;
do
  echo "Waiting for rabbit1 to wake up....";
  sleep 1;
done;

echo "Rabbit1 node is up and ready for the incoming command..."

# setup the HA mode on rabbit1 (master) node
docker exec -it rabbit1 rabbitmqctl set_policy ha-all "^ha\." '{"ha-mode":"all", "ha-sync-mode":"automatic"}'

echo "The HA policy was successfully executed on the master rabbit1 node!"

while ! (nc -z localhost 5673 && nc -z localhost 5674);
do
  echo "Waiting for for the rabbit slave to wake up...."
  sleep 1
done

# these specific commands are for the "slave nodes/containers" ONLY
for slave in ${slaves[*]}; do
  docker exec -it "$slave" rabbitmqctl stop_app
  sleep 1
  docker exec -it "$slave" rabbitmqctl reset
  sleep 1
  docker exec -it "$slave" rabbitmqctl join_cluster rabbit@rabbit1
  sleep 2
  docker exec -it "$slave" rabbitmqctl start_app
done