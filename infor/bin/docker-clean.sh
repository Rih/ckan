#!/bin/bash

cd contrib/docker
docker-compose down
echo "Containers removed"

docker volume prune -y
docker image rm $(docker images -f -q)
docker image prune -y
echo "All removed"
