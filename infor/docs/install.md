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
* Editar .env SITE_URL a url pública
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

En maquina host
- copiar .init a .ini

```
cd infor/setup
cp production.init production.ini
cp preproduction.init preproduction.ini
```

- linkear configuración de nginx en sites-enabled
```
cd /etc/nginx/site-enabled
ln -s /<your_ckan_root_repository>/infor/setup/nginx/host/host_back host_back
cp preproduction.init preproduction.ini
```

Dentro del contenedor re-linkear archivo configuracion .ini y revisar si who.ini ya esta linkeado

```
sh infor/bin/enter-dev-server.sh
cd /etc/ckan
ln -s /usr/lib/ckan/venv/src/ckan/ckan/config/who.ini who.ini (omitir si ya existe)
cp production.init production.ini.bkp
ln -sfn /etc/ckan/backup/setup/preproduction.ini production.ini
exit
```

 ### Instalar plugins
Primero cambiar permisos de ejecución
 ```chmod +x infor/bin/installs-plugin.sh```

En el contenedor CKAN entrar al environment
 ```
sh infor/bin/enter-dev-server.sh
source /usr/lib/ckan/venv/bin/activate
sh /etc/ckan/backup/bin/installs-plugin.sh
```

reconfigurar .ini con los plugins añadidos

```
cd /etc/ckan
ln -sfn /etc/ckan/backup/setup/production.ini production.ini
```

reiniciar ckan


## Mover configuracion nginx en Contenedor CKAN
sh infor/bin/enter-dev-server.sh
cp /etc/ckan/backup/setup/nginx/sites-available/guest

## Ejecutar script .SQL dentro de DB
- Entrar al esquema datastore
- Ejecutar script
```infor/setup/datastore_permissions.sql```
