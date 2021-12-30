-- SQL Queries:

-- SQL QUERY A
SELECT DISTINCT * FROM boat
WHERE (boat.cni, boat.iso_code) IN (SELECT boat_cni,boat_iso_code FROM Reservation);

--SQL QUERY B
SELECT DISTINCT * FROM sailor
WHERE (sailor.id_card, sailor.iso_code) IN 
(SELECT sailor_id,sailor_iso_code FROM Reservation WHERE boat_iso_code = 'PRT');

--SQL QUERY C
SELECT DISTINCT * FROM reservation WHERE end_date - start_date > 5;

-- SQL QUERY D 
SELECT b.name, b.cni FROM Boat b JOIN Person p
ON b.owner_iso_code = p.iso_code AND b.owner_id = p.id_card
WHERE b.iso_code = 'ZAF' AND p.name LIKE '%Rendeiro';