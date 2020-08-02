#!/usr/bin/env bash

set -e

# define all the slave nodes here
# just make sure you always have an quorum
# 3,5,7... of nodes including the master
rabbits=(rabbit1 rabbit2 rabbit3)

for rabbit in ${rabbits[*]}; do
  while :
  do
    echo "Checking rabbit nodes for connectivity.."
    if docker exec -it "$rabbit" rabbitmqctl -q node_health_check;
    then
      echo "$rabbit is up and ready for the incoming commands..."
      if [ "$rabbit" == "rabbit1" ];
      then
        sleep 2
        # setup the HA mode on the rabbit1 (master) node
        docker exec -it "$rabbit" rabbitmqctl set_policy ha-all "^ha\." '{"ha-mode":"all", "ha-sync-mode":"automatic"}'
        break
      else
        # join the slave nodes to the cluster
        docker exec -it "$rabbit" rabbitmqctl stop_app
        sleep 1
        docker exec -it "$rabbit" rabbitmqctl reset
        sleep 1
        docker exec -it "$rabbit" rabbitmqctl join_cluster rabbit@rabbit1
        sleep 2
        docker exec -it "$rabbit" rabbitmqctl start_app
        break
      fi
    else
      sleep 1
    fi
  done
done

#for slave in ${slaves[*]}; do
#  while :
#  do
#    echo "Checking rabbit1 for connectivity.."
#    if docker exec -it "$slave" rabbitmqctl -q node_health_check;
#    then
#      echo "$slave is up and ready for the incoming commands..."
#        docker exec -it "$slave" rabbitmqctl stop_app
#        sleep 1
#        docker exec -it "$slave" rabbitmqctl reset
#        sleep 1
#        docker exec -it "$slave" rabbitmqctl join_cluster rabbit@rabbit1
#        sleep 2
#        docker exec -it "$slave" rabbitmqctl start_app
#      break
#    else
#      sleep 1
#    fi
#  done
#done
