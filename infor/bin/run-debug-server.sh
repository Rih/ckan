#!/bin/bash

source /usr/lib/ckan/venv/bin/activate
paster serve /etc/ckan/production.ini
ckan -c /etc/ckan/production.ini run --host 0.0.0.0 --port 5001
