#!/bin/bash

cd contrib/docker
docker-compose down
echo "Containers removed"

# remove unused volumes
docker volume prune -y
# docker image rm $(docker images -f -q)
docker image rm docker_ckan docker_solr docker_db clementmouchet/datapusher solr:6.6.5 mdillon/postgis:11
# docker image prune -y
echo "All removed"
