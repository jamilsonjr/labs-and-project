-- Analytics queries
-- The start date (i.e., per year, per month independently of year, and per exact date);
-- GROUPING SETS -> ((year), (month), ())
SELECT EXTRACT(YEAR FROM trip_start_date) AS year, EXTRACT(MONTH FROM trip_start_date) AS month, COUNT(*)
FROM trip_info
GROUP BY GROUPING SETS (
  (EXTRACT(YEAR FROM trip_start_date)),
  (EXTRACT(MONTH FROM trip_start_date)),
    ());

-- The location of origin (i.e., per location within countries, per country, and in total).
-- GROUPING SETS -> ((contries, location), (country), ()) aka roullup
SELECT country_name_origin, loc_name_origin, COUNT(*)
FROM trip_info
GROUP BY ROLLUP(country_name_origin, loc_name_origin)