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
select id, iso_code, name
from person join
(
    select *
    from 
    (
        select *
        from
            reservation natural join trip join location l
            on trip.end_latitude = l.latitude and trip.end_longitude = l.longitude
        where l.iso_code = "PT" and end_date >= CURRENT_DATE
    )
    
    
    group by id_sailor
    having count(distinct(latitude, longitude)) = count(location.iso_code = "PT")
)
as o
on person.id = o.id_sailor and person.iso_code = o.iso_code_sailor;
