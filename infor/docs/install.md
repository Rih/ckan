# Pasos instalación CKAN - INFOR

## Requisitos máquina HOST:
- git
- docker
- docker-compose
- vim, nano u otro editor de preferencia
- nginx

Si máquina HOST es linux:
- ```chmod +x infor/bin/install-host.sh```
- ```sh  infor/bin/installs-host.sh ```

## Clonar repositorio git y cambiar de rama a ifn_stats actualizada
- git clone https://github.com/Rih/ckan.git
- cd ckan && git checkout ifn_stats && git pull origin ifn_stats

## Instalar los contenedores de [CKAN](https://docs.ckan.org/en/2.9/maintaining/installing/install-from-docker-compose.html)
#### Copiar .env
* cd ckan/contrib/docker/
* cp .env.template .env

#### En maquina HOST Añadir a /etc/hosts dominio
* 127.0.0.1 ckan

#### En .env añadir o corregir
```
CKAN_SITE_URL=http://ckan:5000
CKAN_MAX_UPLOAD_SIZE_MB=10
```

#### Instalar contenedores
cd contrib/docker
docker-compose up -d --build

## Configurar contenedor CKAN
- Re-linkear .ini revisar si who.ini ya esta linkeado


```
sh bin/enter-dev-server.sh
cd /etc/ckan
ln -s /usr/lib/ckan/venv/src/ckan/ckan/config/who.ini who.ini
ln -sfn /etc/ckan/backup/setup/preproduction.ini production.ini
```

Instalar plugins
- ```chmod +x infor/bin/installs-plugin.sh```
- ```sh infor/bin/installs-plugin.sh```

reconfigurar .ini con los plugins añadidos

```ln -sfn /etc/ckan/backup/setup/production.ini production.ini```

## Ejecutar script .SQL dentro de DB ```contrib/docker/datastore_init.sql```
