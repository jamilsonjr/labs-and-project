drop view if exists  trip_info;
create view trip_info as
select l_origin.iso_code as country_iso_origin, c_origin.name as country_name_origin,
       l_dest.iso_code as country_iso_dest, c_dest.name as country_name_dest,
       l_origin.name as loc_name_origin, l_dest.name as loc_name_dest,
       t.cni as cni_boat,t.iso_code_boat as country_iso_boat, c_boat.name as country_name_boat,
       t.start_date as trip_start_date
from trip t
    join location l_origin on l_origin.latitude = t.start_latitude and l_origin.longitude = t.start_longitude
    join country c_origin on l_origin.iso_code = c_origin.iso_code
    join location l_dest on l_dest.latitude = t.end_latitude and l_dest.longitude = t.end_longitude
    join country c_dest on l_dest.iso_code = c_dest.iso_code
    join country c_boat on t.iso_code_boat = c_boat.iso_code;

select * from trip_info;