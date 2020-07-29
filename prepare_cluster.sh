#!/usr/bin/env bash

set -e

echo "Starting the rabbitmq server bras..."
#rabbitmq-server &

sleep 3

until &>/dev/null </dev/tcp/127.0.0.1/5672 && false || true
do
  echo "Waiting for the rabbitmq server to wake up..."
  sleep 0.5
done


#until echo > /dev/tcp/localhost/5672
#do
#  echo "Waiting for the rabbitmq server to wake up..."
#  sleep 0.5
#done

#for (( ; ; )) ; do
#  sleep 5
#  rabbitmqctl -q node_health_check > /dev/null 2>&1
#  if [ $? -eq 0 ] ; then
#    echo "$0 `date` rabbitmq is now running"
#    break
#  else
#    echo "$0 `date` waiting for rabbitmq startup"
#  fi
#done

#echo "The rabbitmq server started..."
#sleep 10
## setup the HA policy on the "master node/container"
## if you have a lot of slave node you may want to use ha-mode: exactly
#if [ $HOSTNAME == "rabbit1" ];
#then
#  rabbitmqctl set_policy ha-all "^ha\." '{"ha-mode":"all", "ha-sync-mode":"automatic"}'
#  echo "The policy ha-mode was successfully applied to the rabbitmq cluster"
#fi




#sleep 0.5
#
if [ $HOSTNAME != "rabbit1" ];
then
  # these specific command are for the "slave nodes/containers" only
  rabbitmqctl stop_app
    sleep 1
  rabbitmqctl reset
    sleep 1
  rabbitmqctl join_cluster rabbit@rabbit1
    sleep 1
  rabbitmqctl start_app
  echo "Successfully joined the node $HOSTNAME to the rabbitmq cluster!"
fi
