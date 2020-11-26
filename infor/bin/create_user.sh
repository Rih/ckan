#!/bin/bash


## Create sysadmin
username="rih"
email="rih@dev.cl"
name="rih"

# mkdir -p /etc/ckan/default
# cp /etc/ckan/production.ini /etc/ckan/default/ckan.ini
# cp /etc/ckan/production.ini /etc/ckan/default/development.ini
# cd /etc/ckan/default
# ln -s /usr/lib/ckan/venv/src/ckan/ckan/config/who.ini who.ini
# ckan -c "/etc/ckan/default/ckan.ini" create_schema
# export CKAN_INI=/etc/ckan/default/ckan.ini
# export CKAN_INI=/etc/ckan/production.ini
# ENV
# contrib/docker/.env
# add user
cd /usr/lib/ckan/
source /usr/lib/ckan/venv/bin/activate
ckan -c /etc/ckan/production.ini sysadmin add $username email=$email name=$name


## Set permissions
ckan -c /etc/ckan/production.ini datastore set-permissions | sudo -u postgres psql --set ON_ERROR_STOP=1
ckan -c /etc/ckan/production.ini datastore set-permissions | sudo -u postgres psql
ckan -c /etc/ckan/production.ini datastore set-permissions | ssh db sudo -u postgres psql

#docker exec ckan /usr/local/bin/ckan-paster --plugin=ckan datastore set-permissions -c /etc/ckan/production.ini | docker exec -i db psql -U ckan
# ckan -c /etc/ckan/default/ckan.ini datastore set-permissions | ssh db sudo -u postgres psql

# create a
# /etc/ckan/ckan.ini or /etc/ckan/development.ini

# Troubleshooting Datapusher
# https://github.com/ckan/ckan/issues/3987
# change localhost to dockerhost site_url in .env and production.ini
# look for ip internal docker address => ip addr show | grep docker0


## Check _id not a valid header in csv
