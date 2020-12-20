#!/bin/bash

source /usr/lib/ckan/venv/bin/activate
paster serve /etc/ckan/production.ini
ckan -c /etc/ckan/production.ini run --host 0.0.0.0 --port 5001
# DEBUG ckan error
# docker run -it --entrypoint /bin/bash docker_ckan -s
# docker exec -w /etc/ckan docker_ckan ln -sfn /etc/ckan/backup/setup/preproduction.ini production.ini
