/*
This script set the fields when a new resource is visited or downloaded in ckan.
*/

-- \connect "ckan"

-- resource_id and package_id fields are now updated by a trigger when a row is created
CREATE OR REPLACE FUNCTION populate_resource_package_ids_trigger() RETURNS trigger
AS $body$
    BEGIN
        IF NEW.resource_id IS NOT NULL AND NEW.package_id IS NOT NULL THEN
            RETURN NEW;
        END IF;
        IF NEW.tracking_type = 'resource' THEN
            NEW.resource_id := (
                substring(NEW.url from '%resource/#"([A-Za-z0-9_\-]+)#"/download%' for '#')
            );
        ELSE
            NEW.resource_id := (
                substring(NEW.url from '%resource/#"([A-Za-z0-9_\-]+)#"%' for '#')
            );
        END IF;
        --package_name  := (
        --    substring(NEW.url from '%dataset/#"([A-Za-z0-9_\-]+)#"/%' for '#')
        --);
        --package_id  := (
        --    substring(NEW.url from '%dataset/#"([a-f0-9_\-]+)#"/%' for '#')
        --);
        NEW.package_id := (
            substring(NEW.url from '%dataset/#"([A-Za-z0-9_\-]+)#"/%' for '#')
        );
        RETURN NEW;
    END;
$body$ LANGUAGE plpgsql;
ALTER FUNCTION populate_resource_package_ids_trigger() OWNER TO "ckan";

CREATE TRIGGER tracking_fill_resource_and_package_ids BEFORE INSERT ON tracking_raw
FOR EACH ROW EXECUTE PROCEDURE populate_resource_package_ids_trigger();
