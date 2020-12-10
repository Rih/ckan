#!/bin/bash

# Inside CKAN

source /usr/lib/ckan/venv/bin/activate
cd /usr/lib/ckan/venv/src/ckan

# python setup.py init_catalog --locale YOUR_LANGUAGE
# deploying your new language https://docs.ckan.org/en/2.9/contributing/i18n.html#i18n-manual
# git add ckan/i18n/YOUR_LANGUAGE/LC_MESSAGES/ckan.po
# git commit -m '[i18n]: New language po added: YOUR_LANGUAGE' ckan/i18n/YOUR_LANGUAGE/LC_MESSAGES/ckan.po
python setup.py compile_catalog -f --locale es
