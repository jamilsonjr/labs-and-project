-- ##################################################################################
-- querie 1 - Who is the owner with the most boats per country?
-- It need to be simpler for sure
select contador.iso_code,contador.id_owner,contador.iso_code_owner
from 
(
        select id_owner,iso_code_owner,iso_code, count(*)
        from boat
        group by id_owner,iso_code_owner,iso_code
) as contador
where contador.count = (
    select max(get_max.count)
        from (
                select iso_code, count(*)
                from boat
                group by id_owner,iso_code_owner,iso_code
            ) as get_max
    WHERE get_max.iso_code = contador.iso_code
    group by get_max.iso_code
);


-- ##################################################################################
-- querie 2 - List all the owners that have at least two boats in distinct countries.

select id_owner, iso_code_owner, count(*)
from boat
group by id_owner, iso_code_owner
having count(distinct(iso_code))>= 2;

-- ##################################################################################
-- querie 3 -  Who are the sailors that have sailed to every location in 'Portugal'?

select iso_code_sailor, id_sailor
from
(
    select *
    from
    (
        trip join location l
        on trip.end_latitude = l.latitude and trip.end_longitude = l.longitude
    )
    where l.iso_code = 'PT' and end_date <= CURRENT_DATE -- check date?
)
as sailor_locations
group by id_sailor, iso_code_sailor
having count(distinct(latitude, longitude)) = 
(
    select count(*)
    from location
    where iso_code = 'PT'
);

-- ##################################################################################
-- querie 4 - List the sailors with the most trips along with their reservations

select *
from trip
where (id_sailor, iso_code_sailor) in
(
    select id_sailor,iso_code_sailor
    from trip
    group by id_sailor,iso_code_sailor
    having count(*) >= ALL
    (
        select count(*)
        from trip
        group by id_sailor,iso_code_sailor
    )
);


-- ##################################################################################
-- querie 5 - List the sailors with the longest duration of trips (sum of trip durations)
-- for the same single reservation; display also the sum of the trip durations.

select  id_sailor,iso_code_sailor, sum(duration)
from trip
group by start_date, end_date, iso_code_boat, cni, id_sailor,iso_code_sailor -- group by reservation
having sum(duration) >= ALL
(
    select sum(duration)
    from trip
    group by start_date, end_date, iso_code_boat, cni, id_sailor,iso_code_sailor -- group by reservation
);