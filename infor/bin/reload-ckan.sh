#!/bin/bash

cd contrib/docker
docker-compose stop
echo "Site stoped"

docker-compose up -d
echo "Site running"
