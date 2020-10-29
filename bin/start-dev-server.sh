#!/bin/bash

#docker-compose rm -f web # to take changes froma build
cd contrib/docker
docker-compose up -d
echo "Site running"
