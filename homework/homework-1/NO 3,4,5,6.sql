


-- SELECT
--   gtd.Borough,
--   gtd.total_amount
-- FROM
--   green_taxi_data AS gtd
-- JOIN
--   green_taxi_zone AS gtz
-- ON
--   gtd.PULocationID = gtz.LocationID
-- WHERE
--   gtd.lpep_pickup_datetime = '2019-09-18'
--   AND gtd.Borough != 'Unknown'
-- GROUP BY
--   gtd.Borough
-- ORDER BY
--   gtd.total_amount DESC
-- LIMIT
--   3;

-- SELECT
--     gtd.lpep_dropoff_datetime,
--     gtz."Zone" AS dropoff_zone,
--     gtd.tip_amount
-- FROM
--     green_taxi_data gtd
-- -- JOIN
--     green_taxi_zone gtz ON gtd."DOLocationID" = gtz."LocationID"
-- WHERE
--     gtz."Zone" = 'Astoria'
--     AND EXTRACT(MONTH FROM gtd.lpep_pickup_datetime::date) = 9
--     AND EXTRACT(YEAR FROM gtd.lpep_pickup_datetime::date) = 2019
-- ORDER BY
--     gtd.tip_amount DESC
-- LIMIT 1;

-- WITH SeptemberAstoriaTrips AS (
--   SELECT
--     t1."DOLocationID",
--     t2."Zone" AS drop_off_zone,
--     t1."tip_amount"
--   FROM
--     green_taxi_data t1
--   JOIN
--     taxi_zones_table t2 ON t1."DOLocationID" = t2."LocationID"
--   WHERE
--     t1."lpep_pickup_datetime" >= '2019-09-01'::timestamp
--     AND t1."lpep_pickup_datetime" < '2019-10-01'::timestamp
--     AND t2."Zone" = 'Astoria'
-- )

-- SELECT
--   drop_off_zone,
--   MAX("tip_amount") AS largest_tip_amount
-- FROM
--   SeptemberAstoriaTrips
-- GROUP BY
--   drop_off_zone
-- ORDER BY
--   largest_tip_amount DESC;


-- -- nomer 3
-- SELECT
--     COUNT(*) AS total_trips
-- FROM
--     green_taxi_data
-- WHERE
--     lpep_pickup_datetime >= '2019-09-18 00:00:00' AND
--     lpep_pickup_datetime < '2019-09-19 00:00:00' AND
--     lpep_dropoff_datetime >= '2019-09-18 00:00:00' AND
--     lpep_dropoff_datetime < '2019-09-19 00:00:00';


-- nomor 4
SELECT
    DATE_TRUNC('day', CAST(lpep_pickup_datetime AS TIMESTAMP)) AS pickup_day,
    MAX(trip_distance) AS largest_trip_distance
FROM
    green_taxi_data
WHERE
    DATE_TRUNC('day', CAST(lpep_pickup_datetime AS TIMESTAMP)) IN ('2019-09-18', '2019-09-16', '2019-09-26', '2019-09-21')
GROUP BY
    pickup_day
ORDER BY
    pickup_day
LIMIT 1;

-- -- nomor 5
-- SELECT
--     gtz."Borough",
--     SUM(gtd.total_amount) AS total_amount
-- FROM
--     green_taxi_data AS gtd
-- JOIN
--     green_taxi_zone AS gtz
-- ON
--     gtd."PULocationID" = gtz."LocationID"
-- WHERE
--     DATE(gtd.lpep_pickup_datetime) = '2019-09-18'
--     AND gtz."Borough" != 'Unknown'
-- GROUP BY
--     gtz."Borough"
-- ORDER BY
--     total_amount DESC
-- LIMIT
--     3;

-- -- nomor 6
-- SELECT
--     gtz."Zone" AS drop_off_zone,
--     SUM(gtd."tip_amount") AS total_tip_amount
-- FROM
--     green_taxi_data AS gtd
-- JOIN
--     green_taxi_zone AS gtz ON gtd."DOLocationID" = gtz."LocationID"
-- GROUP BY
--     drop_off_zone
-- ORDER BY
--     total_tip_amount DESC
-- LIMIT 5;