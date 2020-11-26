#!/bin/bash

cd /usr/lib/ckan/venv/src/ckan/ckanext

source /usr/lib/ckan/venv/bin/activate
# no exists
pip install ckanext-visualize
# add visualize to ckan.plugins

# install basic charts
cd /usr/lib/ckan/venv/src/ckan/ckanext
git clone https://github.com/ckan/ckanext-basiccharts.git
cd ckanext-basiccharts
python setup.py install

# install visualize
cd /usr/lib/ckan/venv/src/ckan/ckanext
git clone https://github.com/keitaroinc/ckanext-visualize.git
cd ckanext-visualize
python setup.py install
pip install -r requirements.txt

# install viewhelper
cd /usr/lib/ckan/venv/src/ckan/ckanext
git clone https://github.com/ckan/ckanext-viewhelpers.git
cd ckanext-viewhelpers
python setup.py install


