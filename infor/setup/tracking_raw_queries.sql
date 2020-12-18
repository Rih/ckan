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
    gender.value as "Género",
    usertype.value as "Tipo usuario",
    (
      CASE
        WHEN traw.tracking_type = 'resource' THEN 'Descarga'
        ELSE 'Visita'
      END
    ) as "Tipo"
FROM tracking_raw traw
LEFT JOIN gender ON traw.gender = gender.name
LEFT JOIN usertype ON traw.usertype = usertype.name
LEFT JOIN package pkg
    ON (
        traw.package_id = pkg.name AND traw.tracking_type = 'page'
        OR
        traw.package_id = pkg.id  AND traw.tracking_type = 'resource'
)
LEFT JOIN resource res ON res.id = traw.resource_id
WHERE traw.access_timestamp BETWEEN
TO_TIMESTAMP('2020-12-09 00:00:00', 'YYYY-MM-DD HH24:MI:SS') AND
TO_TIMESTAMP('2020-12-30 23:59:59', 'YYYY-MM-DD HH24:MI:SS');

-- ALL DOWNLOAD RECORDS BETWEEN DATES GROUP BY GENDER

SELECT
  T.resource_name,
  T.dataset,
  (case when T.gender = gender.name then T.resource_total else 0 end) as resource_total,
  gender.name,
  gender.value
FROM gender,
(
  SELECT
      res.url as resource_name,
      pkg.name as dataset,
      pkg.url as url,
      COUNT(res.url) as resource_total,
      traw.gender
  FROM tracking_raw traw
  INNER JOIN package pkg
      ON (
          traw.package_id = pkg.id  AND traw.tracking_type = 'resource'
  )
  LEFT JOIN resource res ON res.id = traw.resource_id
  WHERE
    traw.access_timestamp BETWEEN
    TO_TIMESTAMP('2020-12-09 00:00:00', 'YYYY-MM-DD HH24:MI:SS') AND
    TO_TIMESTAMP('2020-12-30 23:59:59', 'YYYY-MM-DD HH24:MI:SS')
  GROUP BY traw.gender,res.url, pkg.name, pkg.url
) T
where gender.state = 'active'



-- ALL DOWNLOAD RECORDS BETWEEN DATES GROUP BY USERTYPE

SELECT
  T.resource_name,
  T.dataset,
  (case when T.usertype = usertype.name then T.resource_total else 0 end) as resource_total,
  usertype.name,
  usertype.value
FROM usertype,
(
  SELECT
      res.url as resource_name,
      pkg.name as dataset,
      pkg.url as url,
      COUNT(res.url) as resource_total,
      traw.usertype
  FROM tracking_raw traw
  INNER JOIN package pkg
      ON (
          traw.package_id = pkg.id  AND traw.tracking_type = 'resource'
  )
  LEFT JOIN resource res ON res.id = traw.resource_id
  WHERE
    traw.access_timestamp BETWEEN
    TO_TIMESTAMP('2020-12-09 00:00:00', 'YYYY-MM-DD HH24:MI:SS') AND
    TO_TIMESTAMP('2020-12-30 23:59:59', 'YYYY-MM-DD HH24:MI:SS')
  GROUP BY traw.usertype,res.url, pkg.name, pkg.url
) T
where usertype.state = 'active'


-- ALL VISITS PER PAGE GROUP BY GENDER

SELECT
  T.resource_name,
  T.url,
  T.dataset,
  (case when T.gender = gender.name then T.resource_total else 0 end) as resource_total,
  gender.name,
  gender.value
FROM gender,
(
  SELECT
      res.url as resource_name,
      traw.url,
      pkg.name as dataset,
      COUNT(traw.url) as resource_total,
      traw.gender
  FROM tracking_raw traw
  INNER JOIN package pkg
      ON (
          traw.package_id = pkg.name AND traw.tracking_type = 'page'
  )
  LEFT JOIN resource res ON res.id = traw.resource_id
  WHERE
    traw.access_timestamp BETWEEN
    TO_TIMESTAMP('2020-12-09 00:00:00', 'YYYY-MM-DD HH24:MI:SS') AND
    TO_TIMESTAMP('2020-12-30 23:59:59', 'YYYY-MM-DD HH24:MI:SS')
  GROUP BY traw.gender, pkg.name, res.url, traw.url
) T
where gender.state = 'active'

-- ALL VISITS PER PAGE GROUP BY USERTYPE

SELECT
  T.resource_name,
  T.url,
  T.dataset,
  (case when T.usertype = usertype.name then T.resource_total else 0 end) as resource_total,
  usertype.name,
  usertype.value
FROM usertype,
(
  SELECT
      res.url as resource_name,
      traw.url,
      pkg.name as dataset,
      COUNT(traw.url) as resource_total,
      traw.usertype
  FROM tracking_raw traw
  INNER JOIN package pkg
      ON (
          traw.package_id = pkg.name AND traw.tracking_type = 'page'
  )
  LEFT JOIN resource res ON res.id = traw.resource_id
  WHERE
    traw.access_timestamp BETWEEN
    TO_TIMESTAMP('2020-12-09 00:00:00', 'YYYY-MM-DD HH24:MI:SS') AND
    TO_TIMESTAMP('2020-12-30 23:59:59', 'YYYY-MM-DD HH24:MI:SS')
  GROUP BY traw.usertype, pkg.name, res.url, traw.url
) T
where usertype.state = 'active'
