#!/bin/bash

sudo ufw allow 5566
docker-compose up -d --build

docker-compose logs -t -f --tail 100 dev_pg_db


docker run -d \
	--name dev_pg_db \
	-e POSTGRES_PASSWORD=secret123 \
        -p 5566:5432 postgres

DB_HOST = 157.230.90.40
DB_POST = 5566
DB_NAME = postgres
DB_USER = postgres
DB_PASSWORD = secret123
