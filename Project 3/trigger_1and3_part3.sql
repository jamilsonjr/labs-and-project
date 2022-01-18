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
                raise notice 'Boat sold out for that period!';
                return old; -- stops from inserting
            end if;
        end loop;
        -- if not, may proceed!
        close cursor_reservation;
        raise notice 'Nothing to see here!';
        return new;
    END;
$$;
drop trigger if exists tg_verify_reservation_dates on reservation;

create trigger tg_verify_reservation_dates
    before insert on reservation
    for each row execute procedure check_reservation();

-- (IC-2) Any location must be specialized in one of three - disjoint - entities: marina, wharf, or port.
-- Loop between must specialize and fk_constraint


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
            raise notice 'Country cannot register boats!';
            return old; -- does nothing (aka stops insertion)
        else
            raise notice 'Nothing to see here...';
            return new; -- continues normally
        end if;
    END;
$$;
drop trigger if exists tg_verify_country_location on boat;

create trigger tg_verify_country_location
    before insert on boat
    for each row execute procedure check_location();
 -- Works nicely!!
