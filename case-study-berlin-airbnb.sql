SELECT *
FROM listings_berlin1;

DESCRIBE listings_berlin1;

-- check rows number
SELECT COUNT(*) AS rows_number
FROM listings_berlin1;

-- remove possible empty spaces from all values
UPDATE listings_berlin1
SET id = TRIM(id),
	name = TRIM(name),
    host_id = TRIM(host_id), 
    host_name = TRIM(host_name), 
    neighbourhood_group = TRIM(neighbourhood_group),
    neighbourhood = TRIM(neighbourhood), 
    latitude = TRIM(latitude), 
    longitude = TRIM(longitude), 
    room_type = TRIM(room_type), 
    price_euro = TRIM(price_euro), 
    minimum_nights = TRIM(minimum_nights), 
    number_of_reviews = TRIM(number_of_reviews), 
    last_review = TRIM(last_review), 
    reviews_per_month = TRIM(reviews_per_month), 
    calculated_host_listings_count = TRIM(calculated_host_listings_count), 
    availability_365 = TRIM(availability_365);

-- check for duplicate values
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY id, name, latitude, longitude) AS row_num
FROM listings_berlin1;

WITH duplicate_check AS
(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY id, name, latitude, longitude) AS row_num
FROM listings_berlin1
)
SELECT *
FROM duplicate_check
WHERE row_num > 1;

-- delete duplicate values
CREATE TABLE listings_berlin_no_duplicates LIKE listings_berlin1;

ALTER TABLE listings_berlin_no_duplicates
ADD COLUMN row_num INT;

SELECT *
FROM listings_berlin_no_duplicates;

INSERT INTO listings_berlin_no_duplicates
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY id, name, latitude, longitude) AS row_num
FROM listings_berlin1;

DELETE
FROM listings_berlin_no_duplicates
WHERE row_num > 1;

SELECT *
FROM listings_berlin_no_duplicates
WHERE row_num > 1;

-- check if there are null values
SELECT *
FROM listings_berlin_no_duplicates
WHERE id IS NULL
	OR host_id IS NULL
	OR neighbourhood_group IS NULL
	OR neighbourhood IS NULL
	OR latitude IS NULL
    OR longitude IS NULL
    OR room_type IS NULL
    OR price_euro IS NULL
    OR minimum_nights IS NULL
    OR number_of_reviews IS NULL
    OR calculated_host_listings_count IS NULL
	OR availability_365 IS NULL;
        -- one row has null values that make it useless for analysis
        
-- remove this row with null values
DELETE
FROM listings_berlin_no_duplicates
WHERE id IS NULL
	OR host_id IS NULL
	OR neighbourhood_group IS NULL
	OR neighbourhood IS NULL
	OR latitude IS NULL
    OR longitude IS NULL
    OR room_type IS NULL
    OR price_euro IS NULL
    OR minimum_nights IS NULL
    OR number_of_reviews IS NULL
    OR calculated_host_listings_count IS NULL
	OR availability_365 IS NULL; 

-- change last_review column format to "date"
UPDATE listings_berlin_no_duplicates
SET last_review = STR_TO_DATE(last_review, "%d/%m/%Y");

-- remove euro sign in price_euro column
UPDATE listings_berlin_no_duplicates
SET price_euro = REPLACE(price_euro, " €", "");

-- convert last_review to date and price_euro to integer
ALTER TABLE listings_berlin_no_duplicates
MODIFY COLUMN last_review DATE;

ALTER TABLE listings_berlin_no_duplicates
MODIFY COLUMN price_euro INT;
-- cannot convert to integer because one row has a comma
SELECT *
FROM listings_berlin_no_duplicates
WHERE id = 2860420;

-- remove comma and convert price_euro to integer
UPDATE listings_berlin_no_duplicates
SET price_euro = REPLACE(price_euro, ",", "");

ALTER TABLE listings_berlin_no_duplicates
MODIFY COLUMN price_euro INT;

-- count how many airbnb there are in each neighbourhood group
SELECT neighbourhood_group, COUNT(neighbourhood_group) AS airbnb_count
FROM listings_berlin_no_duplicates
GROUP BY neighbourhood_group
ORDER BY airbnb_count DESC;

-- check what kind of rooms/flats there are, and how many
SELECT room_type, COUNT(room_type) AS count
FROM listings_berlin_no_duplicates
GROUP BY room_type
ORDER BY count DESC;

-- check how many full apartments are available year round or for more than 6 months
SELECT COUNT(room_type) AS entire_homes_available_for_more_than_6_months
FROM listings_berlin_no_duplicates
WHERE room_type = "Entire home/apt" AND availability_365 > 182;

-- compare full apartments available for more than 6 months vs. the total number of full apartments 
SELECT 
    COUNT(CASE WHEN room_type = "Entire home/apt" AND availability_365 > 182 THEN 1 END) AS entire_homes_available_for_more_than_6_months,
    COUNT(CASE WHEN room_type = "Entire home/apt" THEN 1 END) AS total_entire_homes,
    COUNT(CASE WHEN room_type = "Shared room" AND availability_365 > 182 THEN 1 END) AS shared_rooms_available_for_more_than_6_months,
    COUNT(CASE WHEN room_type = "Shared room" THEN 1 END) AS total_shared_rooms,
    COUNT(CASE WHEN room_type = "Private room" AND availability_365 > 182 THEN 1 END) AS private_rooms_available_for_more_than_6_months,
    COUNT(CASE WHEN room_type = "Private room" THEN 1 END) AS total_private_rooms
FROM listings_berlin_no_duplicates;

-- check how many rooms are rented out by hosts who own more than one listing
SELECT host_id, COUNT(*) AS rooms_count
FROM listings_berlin_no_duplicates
GROUP BY host_id
HAVING COUNT(*) > 1;

SELECT SUM(rooms_count) AS rooms_rented_out_by_hosts_with_many_listings
FROM (
SELECT host_id, COUNT(*) AS rooms_count
FROM listings_berlin_no_duplicates
GROUP BY host_id
HAVING COUNT(*) > 1
) AS dt;


-- check how it affects the price when a host owns multiple rooms/apartments

-- STEP 1: find the average room price of hosts owning only one room/apt
SELECT host_id, COUNT(*) AS rooms_count, price_euro
FROM listings_berlin_no_duplicates
GROUP BY host_id, price_euro
HAVING COUNT(*) = 1;

SELECT AVG(price_euro) AS avg_room_price_of_hosts_owning_one_room
FROM (
SELECT host_id, COUNT(*) AS rooms_count, price_euro
FROM listings_berlin_no_duplicates
GROUP BY host_id, price_euro
HAVING COUNT(*) = 1
) AS dt;

-- STEP 2: find the average room price of hosts with multiple rooms
SELECT AVG(price_euro) AS avg_room_price_of_hosts_owning_many_rooms
FROM (
SELECT host_id, COUNT(*) AS rooms_count, price_euro
FROM listings_berlin_no_duplicates
GROUP BY host_id, price_euro
HAVING COUNT(*) > 1
) AS dt;

-- STEP 3: compare the two averages
SELECT
    AVG(CASE WHEN rooms_count = 1 THEN price_euro END) AS avg_price_one_room_owned,
    AVG(CASE WHEN rooms_count > 1 THEN price_euro END) AS avg_price_multiple_rooms_owned
FROM (
    SELECT
        host_id,
        COUNT(*) AS rooms_count,
        price_euro
    FROM listings_berlin_no_duplicates
    GROUP BY host_id, price_euro
) AS dt;

-- find out in what ways East and West Berlin differ

-- add column to be able to divide neighbourhood groups between West and East Berlin
ALTER TABLE listings_berlin_no_duplicates
ADD COLUMN berlin_area TEXT;

UPDATE listings_berlin_no_duplicates
SET berlin_area = CASE
    WHEN neighbourhood_group IN ('Mitte', 'Pankow', 'Friedrichshain-Kreuzberg', 'Treptow - KÃ¶penick', 'Lichtenberg', 'Marzahn - Hellersdorf') THEN 'East Berlin'
    WHEN neighbourhood_group IN ('Tempelhof - SchÃ¶neberg', 'NeukÃ¶lln', 'Charlottenburg-Wilm.', 'Reinickendorf', 'Steglitz - Zehlendorf', 'Spandau') THEN 'West Berlin'
END;


-- check where the effects are most noticeable

-- STEP 1: find the average room price of hosts owning only one room/apt by area
SELECT neighbourhood_group, AVG(price_euro) AS avg_price_one_room
FROM listings_berlin_no_duplicates
WHERE host_id IN (
	SELECT host_id
        FROM listings_berlin_no_duplicates
    GROUP BY host_id
    HAVING COUNT(*) = 1
)
GROUP BY neighbourhood_group;

-- STEP 2: find the average room price of hosts owning more than one room/apt by area
SELECT neighbourhood_group, AVG(price_euro) AS avg_price_many_rooms
FROM listings_berlin_no_duplicates
WHERE host_id IN (
	SELECT host_id
        FROM listings_berlin_no_duplicates
    GROUP BY host_id
    HAVING COUNT(*) > 1
)
GROUP BY neighbourhood_group;

-- STEP 3: compare the two averages
SELECT
	berlin_area,
	neighbourhood_group,
    AVG(CASE WHEN rooms_count = 1 THEN price_euro END) AS avg_price_one_room_owned,
    AVG(CASE WHEN rooms_count > 1 THEN price_euro END) AS avg_price_multiple_rooms_owned,
    AVG(CASE WHEN rooms_count = 1 THEN price_euro END) - AVG(CASE WHEN rooms_count > 1 THEN price_euro END) AS price_difference
FROM (
    SELECT
		berlin_area,
        host_id,
        neighbourhood_group,
        COUNT(*) AS rooms_count,
        AVG(price_euro) AS price_euro
    FROM listings_berlin_no_duplicates
    GROUP BY host_id, neighbourhood_group, berlin_area
) AS dt
GROUP BY neighbourhood_group, berlin_area
ORDER BY price_difference DESC;


-- check average airbnb price and count for East vs. West Berlin
SELECT berlin_area, AVG(price_euro) AS avg_room_price, COUNT(id) AS airbnb_count
FROM listings_berlin_no_duplicates
GROUP BY berlin_area;

-- check average airbnb price and count for each room type in East vs. West Berlin
SELECT berlin_area, COUNT(room_type) AS airbnb_count, room_type, AVG(price_euro) AS avg_price
FROM listings_berlin_no_duplicates
GROUP BY berlin_area, room_type
ORDER BY avg_price DESC;

