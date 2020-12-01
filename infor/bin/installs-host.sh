#!/bin/bash

apt-get update && \
apt-get install -y software-properties-common apt-utils locales locales-all \
build-essential docker docker-compose nginx vim nano git
