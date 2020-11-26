#!/bin/bash

# NOTE: run inside ckan sh bin/enter-dev-server.sh
source /usr/lib/ckan/venv/bin/activate
@hourly ckan -c /etc/ckan/production.ini tracking update  && ckan -c /etc/ckan/production.ini search-index rebuild -r
