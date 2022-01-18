CREATE OR REPLACE FUNCTION check_location_type_fn()
RETURNS TRIGGER LANGUAGE plpgsql AS
    $$
        BEGIN
            IF EXISTS(
                SELECT *
                FROM
                    (SELECT * FROM marina
                    UNION
                    SELECT * FROM port
                    UNION
                    SELECT* FROM wharf) AS all_loc
                WHERE all_loc.latitude = NEW.latitude AND all_loc.longitude = NEW.longitude
                )
            THEN
                RAISE EXCEPTION 'This location is already specialized.'
                USING HINT = 'Please, make sure that the location is not already in one of the types of location tables.';
            END IF;
        END;
    $$;

CREATE TRIGGER chk_location_type
BEFORE INSERT ON marina
FOR EACH ROW EXECUTE PROCEDURE check_location_type_fn();

