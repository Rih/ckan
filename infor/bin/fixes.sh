#!/bin/bash

cd ckan
git checkout tags/ckan-2.9.0

# Fixed PR: https://github.com/ckan/ckan/pull/5381
git diff 9abeaa1b7d2f6539ade946cc3f407878f49950eb^ 9abeaa1b7d2f6539ade946cc3f407878f49950eb | git apply

# Fixed PR: https://github.com/ckan/ckan/pull/5215 will be added to 2.9.1
git cherry-pick 15f708b08fcce85b66a518228931520579b18388
git cherry-pick 0c15cb668a2f677fffc3138a242285f0a635a8b3
git cherry-pick 8c595c85f0e3e45a569fddee6e78f86429a632f8

# Files affected
# ckan/tests/legacy/test_coding_standards.py
# ckanext/stats/blueprint.py
# ckanext/stats/plugin.py
# ckanext/stats/public/ckanext/stats/javascript/modules/stats-nav.js
# ckanext/stats/public/ckanext/stats/webassets.yml
# ckanext/stats/templates/ckanext/stats/index.html
# ckanext/stats/tests/__init__.py
# ckanext/stats/tests/test_stats_lib.py
# ckanext/stats/tests/test_stats_plugin.py

# run contrib/docker/datastore_init.sql in CKAN postgres db

# export CKAN_INI=/etc/ckan/production.ini

# ckan -c /etc/ckan/production.ini


rm  ckan/tests/legacy/test_coding_standards.pyc &&
rm  ckanext/stats/blueprint.pyc &&
rm  ckanext/stats/plugin.pyc &&
rm  ckanext/stats/tests/__init__.pyc &&
rm  ckanext/stats/tests/test_stats_lib.pyc &&
rm  ckanext/stats/tests/test_stats_plugin.pyc

#point to new config file
cd /etc/ckan
ln -sfn /etc/ckan/backup/production.ini production.ini


# problemas con columnas
# _id, #
# encoding file
# illegal char
