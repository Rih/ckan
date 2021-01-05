#!/bin/bash

cd contrib/docker
source /usr/lib/ckan/venv/bin/activate && ckan -c /etc/ckan/development.ini run --host 0.0.0.0
# DEBUG ckan error
# docker run -it --entrypoint /bin/bash docker_ckan -s
# docker exec -w /etc/ckan docker_ckan ln -sfn /etc/ckan/backup/setup/preproduction.ini production.ini
