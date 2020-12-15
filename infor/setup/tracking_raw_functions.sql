/*
This script set functions to traslate usertype and gender fields in tracking_raw table
*/

-- \connect "ckan"

CREATE OR REPLACE FUNCTION convert_tracking_usertype(
    in_key VARCHAR
) 
RETURNS VARCHAR
AS $body$
DECLARE
RESULTS VARCHAR;
BEGIN
    
    RESULTS := (
        SELECT 
     	T.value ->> 'result'
        FROM (
            SELECT key, value from json_each('{
                "academic": {"result": "Academico"},
                "student": {"result": "Estudiante"},
                "propietary": {"result": "Pequeño Propietario"},
                "pyme": {"result": "Pyme"},
                "company": {"result": "Gran Empresa"},
                "ong": {"result": "ONG"},
                "organization": {"result": "Organización o asociación"},
                "other": {"result": "Otros usuarios"}
            }')
        ) T
        WHERE T.key = in_key
    );
    IF RESULTS IS NULL THEN
        RETURN 'Indefinido';
    END IF;
    RETURN RESULTS;
END;
$body$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION convert_tracking_gender(
    in_key VARCHAR
) 
RETURNS VARCHAR
AS $body$
DECLARE
RESULTS VARCHAR;
BEGIN
    RESULTS := (
        SELECT 
     	T.value ->> 'result'
     	FROM (
            select key, value from json_each('{
                "female": {"result": "Femenino"},
                "male": {"result": "Masculino"}
            }')
        ) T
        where key = in_key
    );
    
    IF RESULTS IS NULL THEN
        RETURN 'Indefinido';
    END IF;
    RETURN RESULTS;
END;
$body$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION convert_tracking_user_values(
    mode VARCHAR, in_key VARCHAR
) 
RETURNS TEXT
AS $body$
DECLARE
RESULTS VARCHAR;
BEGIN
    IF mode NOT IN ('gender', 'usertype') THEN
        RETURN 'Invalid mode';
    END IF;
    IF mode = 'gender' THEN
        RESULTS := convert_tracking_gender(in_key);
    ELSE
        RESULTS := convert_tracking_usertype(in_key);
    END IF;
    RETURN RESULTS;
END;
$body$ LANGUAGE plpgsql;

