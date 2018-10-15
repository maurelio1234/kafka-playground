#!/bin/bash

TOPIC=urls
KAFKA=$(docker run -d --rm -p 2181:2181 -p 9092:9092 --env ADVERTISED_HOST=localhost --env ADVERTISED_PORT=9092 --env AUTO_CREATE_TOPICS=true spotify/kafka)$

echo Kafka container $KAFKA started...
sleep 30

echo Running consumer...
./run-consumer.sh $TOPIC & 
P1=$!
echo Started consumer PID=$P1!

sleep 30
echo Running producer...
./run-producer.sh $TOPIC &
P2=$!
echo Started producer PID=$P2!

wait $P1 $P2

docker stop $KAFKA
