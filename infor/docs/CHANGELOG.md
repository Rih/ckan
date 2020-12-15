# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).


## [Unreleased]
### Added
- adittions
### Changed
- changes

## [ifn_tracking] - 2020-11-26
### Added
- Se agregan consultas SQL

### Changed
- Se quita Flujo de actividad
- Se añaden nuevos headers latitud/longitud para cargar mapas en archivo ```recline.js```
- Se configura opciones de estadisticas de uso en production.ini
    - nuevas variables modificables como una lista separadas por ;
    - donde values son los valores a guardar, y names son lo que se muestra en pantalla
```
ckan.user.usertype.values =
ckan.user.usertype.names =
ckan.user.gender.values =
ckan.user.gender.names =
```

## [ifn_stats] - 2020-11-26
### Added
- carpeta infor:
    - con archivos corregidos
-


### Changed
- Fixes ```infor/bin/fixes.sh```:
    - Se aplica commits de ```tags/ckan-2.9.0```
    - Se corrige commits de stats
- Dockerfile: se instala nginx


[Unreleased]: https://gitlab.com/don_balon/transcriptor/-/compare/develop...v1.0.0
[V0.0.1]: https://gitlab.com/don_balon/transcriptor/-/tree/v0.0.1
