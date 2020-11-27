#!/bin/bash

# add visualize basiccharts viewhelpers to ckan.plugins production.ini

source /usr/lib/ckan/venv/bin/activate

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

# install viewhelpers
cd /usr/lib/ckan/venv/src/ckan/ckanext
git clone https://github.com/ckan/ckanext-viewhelpers.git
cd ckanext-viewhelpers
python setup.py install


