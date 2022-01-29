--Alter Tables
ALTER TABLE location
DROP CONSTRAINT location_iso_code_fk,
ADD CONSTRAINT location_iso_code_fk
FOREIGN KEY (iso_code) REFERENCES country (iso_code) ON DELETE CASCADE;


ALTER TABLE marina
DROP CONSTRAINT marina_latitude_fkey,
ADD CONSTRAINT marina_latitude_fkey
FOREIGN KEY (latitude, longitude) REFERENCES location (latitude, longitude) ON DELETE CASCADE;

ALTER TABLE wharf
DROP CONSTRAINT wharf_latitude_fkey,
ADD CONSTRAINT wharf_latitude_fkey
FOREIGN KEY (latitude, longitude) REFERENCES location (latitude, longitude) ON DELETE CASCADE;

ALTER TABLE port
DROP CONSTRAINT port_latitude_fkey,
ADD CONSTRAINT port_latitude_fkey
FOREIGN KEY (latitude, longitude) REFERENCES location (latitude, longitude) ON DELETE CASCADE;

ALTER TABLE person
DROP CONSTRAINT person_iso_code_fkey,
ADD CONSTRAINT person_iso_code_fkey
FOREIGN KEY (iso_code) REFERENCES country (iso_code) ON DELETE CASCADE;

ALTER TABLE sailor
DROP CONSTRAINT sailor_id_fkey,
ADD CONSTRAINT sailor_id_fkey
FOREIGN KEY (id, iso_code) REFERENCES person (id, iso_code) ON DELETE CASCADE;

ALTER TABLE owner
DROP CONSTRAINT owner_id_fkey,
ADD CONSTRAINT owner_id_fkey
FOREIGN KEY (id, iso_code) REFERENCES person (id, iso_code) ON DELETE CASCADE;

ALTER TABLE boat
DROP CONSTRAINT boat_id_owner_fkey,
DROP CONSTRAINT boat_iso_code_fkey,
ADD CONSTRAINT boat_id_owner_fkey
    FOREIGN KEY (id_owner, iso_code_owner) REFERENCES owner (id, iso_code) ON DELETE CASCADE,
ADD CONSTRAINT boat_iso_code_fkey
    FOREIGN KEY (iso_code) REFERENCES country (iso_code) ON DELETE CASCADE;

ALTER TABLE boat_vhf
DROP CONSTRAINT boat_vhf_cni_fkey,
ADD CONSTRAINT boat_vhf_cni_fkey
    FOREIGN KEY (cni, iso_code) REFERENCES boat (cni, iso_code);


ALTER TABLE reservation
DROP CONSTRAINT reservation_cni_fkey,
DROP CONSTRAINT reservation_id_sailor_fkey,
DROP CONSTRAINT reservation_start_date_fkey,
ADD CONSTRAINT reservation_cni_fkey
    FOREIGN KEY (cni, iso_code_boat) REFERENCES boat (cni, iso_code) ON DELETE CASCADE,
ADD CONSTRAINT reservation_id_sailor_fkey
    FOREIGN KEY (id_sailor, iso_code_sailor) REFERENCES sailor (id, iso_code) ON DELETE CASCADE,
ADD CONSTRAINT reservation_start_date_fkey
    FOREIGN KEY (start_date, end_date) REFERENCES schedule (start_date, end_date) ON DELETE CASCADE;

ALTER TABLE trip
DROP CONSTRAINT trip_cni_fkey,
DROP CONSTRAINT trip_end_latitude_fkey,
DROP CONSTRAINT trip_start_latitude_fkey,
ADD CONSTRAINT trip_cni_fkey
    FOREIGN KEY (cni, iso_code_boat, id_sailor, iso_code_sailor, start_date, end_date) REFERENCES
        reservation (cni, iso_code_boat, id_sailor, iso_code_sailor, start_date, end_date) ON DELETE CASCADE,
ADD CONSTRAINT trip_end_latitude_fkey
    FOREIGN KEY (start_latitude, start_longitude) REFERENCES location (latitude, longitude) ON DELETE CASCADE,
ADD CONSTRAINT trip_start_latitude_fkey
    FOREIGN KEY (end_latitude, end_longitude) REFERENCES location (latitude, longitude) ON DELETE CASCADE;


/*INTEGRITY CONSTRAINTS*/
--(IC-1) Two reservations for the same boat can not have their corresponding date intervals intersecting.
drop type if exists reservation_interval;
create type reservation_interval as (
    start_date date,
    end_date date
);

create or replace function check_reservation()
returns trigger
language plpgsql
  as
$$
    declare
        res_int reservation_interval default null;
    declare
        cursor_reservation cursor for
        (select start_date,end_date
        from reservation
        where reservation.cni = new.cni and reservation.iso_code_boat = new.iso_code_boat);

    BEGIN
        open cursor_reservation;
        Loop -- verifies if the dates intersect
            fetch cursor_reservation into res_int;

            if res_int is null then
                exit;
            end if;

            if ((new.start_date between res_int.start_date and res_int.end_date)
                or (new.end_date between  res_int.start_date and res_int.end_date)
                or (new.start_date <= res_int.start_date and new.end_date >= res_int.end_date)) then

                close cursor_reservation;
                RAISE EXCEPTION 'Boat sold out for that period!'
                USING HINT = 'Please, make sure the boat is available for the time period you want to book it.';
            end if;

        end loop;
        -- if not, may proceed!
        close cursor_reservation;
        return new;
    END;
$$;
drop trigger if exists tg_verify_reservation_dates on reservation;

create trigger tg_verify_reservation_dates
    before insert on reservation
    for each row execute procedure check_reservation();

-- (IC-2) Any location must be specialized in one of three - disjoint - entities: marina, wharf, or port.
-- Loop between must specialize and fk_constraint
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
                    SELECT * FROM wharf) AS all_loc
                WHERE all_loc.latitude = NEW.latitude AND all_loc.longitude = NEW.longitude
                )
            THEN
                RAISE EXCEPTION 'This location is already specialized.'
                USING HINT = 'Please, make sure you use the START TRANSACTION query to insert into wharf,
                            marina or port tables while you also insert into to the Location table.';
                RETURN OLD;
            END IF;
            RETURN NEW;
        END;
    $$;

DROP TRIGGER IF EXISTS chk_location_type_marina ON marina;
CREATE TRIGGER chk_location_type_marina
BEFORE INSERT ON marina
FOR EACH ROW EXECUTE PROCEDURE check_location_type_fn();

DROP TRIGGER IF EXISTS chk_location_type_port ON port;
CREATE TRIGGER chk_location_type_port
BEFORE INSERT ON port
FOR EACH ROW EXECUTE PROCEDURE check_location_type_fn();

DROP TRIGGER IF EXISTS chk_location_type_wharf ON wharf;
CREATE TRIGGER chk_location_type_wharf
BEFORE INSERT ON wharf
FOR EACH ROW EXECUTE PROCEDURE check_location_type_fn();

-- (IC-3) A country where a boat is registered must correspond - at least - to one location.
create or replace function check_location()
returns trigger
language plpgsql
  as
$$
    declare
        reg_country location%rowtype;

    BEGIN
        select * 
        into reg_country
        from location
        where location.iso_code = new.iso_code;

        if reg_country is null then
            RAISE EXCEPTION 'Boat cannot be registred in country!'
            USING HINT = 'Please, make sure the boat is resgistred in a country with a registred location!';
        else
            return new; -- continues normally
        end if;
    END;
$$;
drop trigger if exists tg_verify_country_location on boat;

create trigger tg_verify_country_location
    before insert on boat
    for each row execute procedure check_location();
 -- Works nicely!!

-- Auxiliar Functions to WEB

drop function if exists check_person(owner_id varchar, owner_iso_code char);
create function check_person(owner_id varchar(80),owner_iso_code char(2))
returns bool
language plpgsql
  as
$$

    BEGIN
        If exists (SELECT * FROM person WHERE id = owner_id AND iso_code = owner_iso_code) then
            return true;
        else
            return false;
        end if;
    END
$$;

drop type if exists reservation_interval;
create type reservation_interval as (
    start_date date,
    end_date date
);
drop function if exists  check_reservation_web(boat_cni varchar, boat_iso_code varchar, start_date date, end_date date);
create or replace function check_reservation_web(boat_cni varchar(60),boat_iso_code varchar(2),start_date date, end_date date)
returns bool
language plpgsql
  as
$$
    declare
        res_int reservation_interval default null;
    declare
        cursor_boat cursor for
        (select r.start_date,r.end_date
        from reservation r
        where r.cni = boat_cni and r.iso_code_boat = boat_iso_code);

    BEGIN
        open cursor_boat;

        Loop -- verifies if the dates intersect
            fetch cursor_boat into res_int;

            if res_int is null then
                exit;
            end if;

            if ((start_date between res_int.start_date and res_int.end_date)
                or (end_date between  res_int.start_date and res_int.end_date)
                or (start_date <= res_int.start_date and end_date >= res_int.end_date)) then
                return false;
            end if;

        end loop;
        close cursor_boat;
        return true;
    END
$$;