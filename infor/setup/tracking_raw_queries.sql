/*
This script set the fields when a new resource is visited or downloaded in ckan.
*/

-- ALL RECORDS BETWEEN DATES
SELECT
    LPAD(cast(EXTRACT(day FROM traw.access_timestamp) as TEXT), 2, '0')||'-'||
    LPAD(cast(EXTRACT(month FROM traw.access_timestamp) as TEXT), 2, '0')||'-'||
    LPAD(cast(EXTRACT(year FROM traw.access_timestamp) as TEXT), 4, '0') as "Fecha",
    res.url as "Recurso",
    res.id as "ID recurso",
    pkg.id as "ID dataset",
    pkg.name as "Dataset",
    traw.url as "URL",
    convert_tracking_user_values('gender', traw.gender) as "Género",
    convert_tracking_user_values('usertype', traw.usertype) as "Tipo usuario",
    (CASE  WHEN traw.tracking_type = 'resource' THEN 'Descarga' ELSE 'Visita' END) as "Tipo"
    FROM tracking_raw traw
LEFT JOIN package pkg
    ON (
        traw.package_id = pkg.name AND traw.tracking_type = 'page'
        OR
        traw.package_id = pkg.id  AND traw.tracking_type = 'resource'
)
LEFT JOIN resource res
ON res.id = traw.resource_id
WHERE traw.access_timestamp BETWEEN
TO_TIMESTAMP('2020-12-09 00:00:00', 'YYYY-MM-DD HH24:MI:SS') and TO_TIMESTAMP('2020-12-30 23:59:59', 'YYYY-MM-DD HH24:MI:SS');

-- ALL DOWNLOAD RECORDS BETWEEN DATES GROUP BY GENDER
SELECT
    res.url as resource_name,
    pkg.name as dataset,
    pkg.id as dataset_id,
    COUNT(res.url) as resource_total,
    convert_tracking_user_values('gender', traw.gender) as t_gender,
    traw.gender
FROM tracking_raw traw
INNER JOIN package pkg
    ON (
        traw.package_id = pkg.id  AND traw.tracking_type = 'resource'
)
LEFT JOIN resource res
ON res.id = traw.resource_id
WHERE traw.access_timestamp BETWEEN
TO_TIMESTAMP('2020-12-09 00:00:00', 'YYYY-MM-DD HH24:MI:SS') and TO_TIMESTAMP('2020-12-30 23:59:59', 'YYYY-MM-DD HH24:MI:SS')
GROUP BY traw.gender, res.url, pkg.name, pkg.id;


-- ALL DOWNLOAD RECORDS BETWEEN DATES GROUP BY USERTYPE

SELECT
    res.url as resource_name,
    pkg.name as dataset,
    pkg.id as dataset_id,
    COUNT(res.url) as resource_total,
    convert_tracking_user_values('gender', traw.usertype) as t_usertype,
    traw.usertype
FROM tracking_raw traw
INNER JOIN package pkg
    ON (
        traw.package_id = pkg.id  AND traw.tracking_type = 'resource'
)
LEFT JOIN resource res
ON res.id = traw.resource_id
WHERE traw.access_timestamp BETWEEN
TO_TIMESTAMP('2020-12-09 00:00:00', 'YYYY-MM-DD HH24:MI:SS') and TO_TIMESTAMP('2020-12-30 23:59:59', 'YYYY-MM-DD HH24:MI:SS')
GROUP BY traw.usertype, res.url, pkg.name, pkg.id;


-- ALL VISITS PER PAGE GROUP BY GENDER

SELECT
    traw.url as url,
    res.package_id,
    COUNT(traw.url) as resource_total,
    convert_tracking_user_values('gender', traw.gender) as t_gender,
    traw.gender
FROM tracking_raw traw
INNER JOIN package pkg
    ON (
        traw.package_id = pkg.name AND traw.tracking_type = 'page'
)
LEFT JOIN resource res
ON res.id = traw.resource_id
WHERE traw.access_timestamp BETWEEN
TO_TIMESTAMP('2020-12-09 00:00:00', 'YYYY-MM-DD HH24:MI:SS') and TO_TIMESTAMP('2020-12-30 23:59:59', 'YYYY-MM-DD HH24:MI:SS')
GROUP BY traw.gender, traw.url, res.package_id;


-- ALL VISITS PER PAGE GROUP BY USERTYPE

SELECT
    traw.url as url,
    res.package_id,
    COUNT(traw.url) as resource_total,
    convert_tracking_user_values('usertype', traw.usertype) as t_usertype,
    traw.usertype
FROM tracking_raw traw
INNER JOIN package pkg
    ON (
        traw.package_id = pkg.name AND traw.tracking_type = 'page'
)
LEFT JOIN resource res
ON res.id = traw.resource_id
WHERE traw.access_timestamp BETWEEN
TO_TIMESTAMP('2020-12-09 00:00:00', 'YYYY-MM-DD HH24:MI:SS') and TO_TIMESTAMP('2020-12-30 23:59:59', 'YYYY-MM-DD HH24:MI:SS')
GROUP BY traw.usertype, traw.url, res.package_id;
