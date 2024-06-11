SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;

USE `restaurants`;
-- -----------------------------------------------------
-- Retrieve All Restaurants: Display a list of all restaurants in the database.
-- -----------------------------------------------------
SELECT * FROM restaurant;

-- -----------------------------------------------------
-- Sort Restaurants by Name: Display restaurants ordered by their name, in ascending order. 
-- -----------------------------------------------------
SELECT * FROM restaurant
ORDER BY rating DESC;

-- -----------------------------------------------------
-- Find Restaurants with Titles Starting with a Specific Letter: Search for restaurants whose titles 
-- begin with a particular letter.
-- Example: letter "C"
-- -----------------------------------------------------
SELECT * FROM restaurant
WHERE name LIKE 'C%'
ORDER BY rating DESC;

-- -----------------------------------------------------
-- Find Restaurants with Titles having a Specific Keyword: Search for restaurants whose titles have a given keyword. 
-- Example: keyword "Vikings"
-- -----------------------------------------------------
SELECT * FROM restaurant
WHERE name LIKE '%Vikings%'
ORDER BY rating DESC;

-- -----------------------------------------------------
-- Retrieve Restaurants in a Specific Location: Filter and display restaurants that 
-- were located in a given location (City, Country). 
-- Example: in Pasay City 
-- Example 2: in Brazil
-- -----------------------------------------------------
SELECT * FROM restaurant
WHERE city = "Pasay City"
ORDER BY rating DESC;

SELECT * FROM restaurant
WHERE country = "Brazil"
ORDER BY rating DESC;
-- -----------------------------------------------------
-- Retrieve the Menu of a Specific Restaurants: Display the menu of a given restaurants.
-- Example: menu of all restaurants including keyword "Vikings"
-- -----------------------------------------------------
SELECT
	restaurant.name AS restaurant_name,    
    menu.food_name_1 AS food_1,
    menu.food_name_2 AS food_2,
    menu.food_name_3 AS food_3,
    menu.food_name_4 AS food_4,
    menu.food_name_5 AS food_5,
    menu.food_name_6 AS food_6,
    menu.food_name_7 AS food_7,
    menu.food_name_8 AS food_8,
    menu.food_name_9 AS food_9,
    restaurant.rating AS restaurant_rating,
    CONCAT(restaurant.address, ', ', restaurant.city, ', ', restaurant.country) AS restaurant_address
FROM menu
LEFT JOIN services ON menu.id = services.menu_id
LEFT JOIN restaurant ON services.restaurant_id = restaurant.id
WHERE restaurant.name LIKE "%Vikings%"
ORDER BY restaurant_rating DESC;  

-- -----------------------------------------------------
-- Find Restaurants having a Specific Cuisine: Search for restaurants which have a specific cuisine
-- Example: restaurants having "Cheeseburger"
-- -----------------------------------------------------
SELECT DISTINCT	
	restaurant.name AS restaurant_name,
    CONCAT(restaurant.address, ', ', restaurant.city, ', ', restaurant.country) AS restaurant_address,
    restaurant.hotline_number AS restaurant_hotline,
    restaurant.rating AS restaurant_rating,
    menu.food_name_1 AS food_1,
    menu.food_name_2 AS food_2,
    menu.food_name_3 AS food_3,
    menu.food_name_4 AS food_4,
    menu.food_name_5 AS food_5,
    menu.food_name_6 AS food_6,
    menu.food_name_7 AS food_7,
    menu.food_name_8 AS food_8,
    menu.food_name_9 AS food_9
FROM restaurant
LEFT JOIN services ON services.restaurant_id = restaurant.id
LEFT JOIN menu ON menu.id = services.menu_id
WHERE 
	menu.food_name_1 = "Cheeseburger"
    OR menu.food_name_2 = "Cheeseburger"
    OR menu.food_name_3 = "Cheeseburger"
    OR menu.food_name_4 = "Cheeseburger"
    OR menu.food_name_5 = "Cheeseburger"
    OR menu.food_name_6 = "Cheeseburger"
    OR menu.food_name_7 = "Cheeseburger"
    OR menu.food_name_8 = "Cheeseburger"
    OR menu.food_name_9 = "Cheeseburger"
ORDER BY restaurant_rating DESC; 

-- -----------------------------------------------------
-- Find Restaurants having a Specific Services: Search for restaurants which have a specific services
-- Example: restaurants that have payment method is "paypal" and serve buffet
-- -----------------------------------------------------
SELECT DISTINCT	
	restaurant.name AS restaurant_name,
    CONCAT(restaurant.address, ', ', restaurant.city, ', ', restaurant.country) AS restaurant_address,
    restaurant.hotline_number AS restaurant_hotline,
    restaurant.rating AS restaurant_rating
FROM restaurant
LEFT JOIN services ON services.restaurant_id = restaurant.id
WHERE 
	services.payment_methods = "paypal"
    AND services.buffet = 1
ORDER BY restaurant_rating DESC; 

-- -----------------------------------------------------
-- Find Restaurants having a Specific Facilities: Search for restaurants which have a specific facilities
-- Example: restaurants that have private room and smoking area
-- -----------------------------------------------------
SELECT DISTINCT	
	restaurant.name AS restaurant_name,
    CONCAT(restaurant.address, ', ', restaurant.city, ', ', restaurant.country) AS restaurant_address,
    restaurant.hotline_number AS restaurant_hotline,
    restaurant.rating AS restaurant_rating
FROM restaurant
LEFT JOIN facilities ON facilities.restaurant_id = restaurant.id
WHERE 
	facilities.private_room = 1
    AND facilities.smoking_area = 1
ORDER BY restaurant_rating DESC; 

-- -----------------------------------------------------
-- Retrieve the Top 5 Most Reviewed Restaurants: List the top 5 restaurants with the highest number of reviews.
-- -----------------------------------------------------
SELECT 
	restaurant.name AS restaurant_name,
    CONCAT(restaurant.address, ', ', restaurant.city, ', ', restaurant.country) AS restaurant_address,
    restaurant.hotline_number AS restaurant_hotline,
    restaurant.rating AS restaurant_rating,
    COUNT(review.id) AS review_count
FROM restaurant
LEFT JOIN review ON restaurant.id = review.restaurant_id
GROUP BY restaurant.id
ORDER BY review_count DESC
LIMIT 5;


-- -----------------------------------------------------
-- Sort Restaurants by Average Rating: Display restaurants sorted by their average rating stars, in descending order.
-- -----------------------------------------------------
SELECT * FROM restaurant
ORDER BY rating DESC;

-- -----------------------------------------------------
-- Retrieve Restaurants That Have Not Received Any Ratings: List all restaurants that have not been rated yet.
-- -----------------------------------------------------
SELECT * FROM restaurant
WHERE rating IS NULL
ORDER BY name ASC;

-- -----------------------------------------------------
-- Find the Top 5 Restaurants with the Highest and Lowest Average Ratings: List the Top 5 restaurants with 
-- the highest and lowest average ratings (except the non-rated restaurants).
-- -----------------------------------------------------
SELECT * FROM restaurant
ORDER BY rating DESC
LIMIT 5;

SELECT * FROM restaurant
WHERE rating IS NOT NULL
ORDER BY rating ASC
LIMIT 5;

-- -----------------------------------------------------
-- Find Reviews which were created within a Specific Date Range: List reviews which were created between two specific dates.
-- Example: from 1-1-2007 to 31-12-2009
-- -----------------------------------------------------
SELECT * FROM review
WHERE date_created BETWEEN '2007-01-01' AND '2009-12-31'
ORDER BY date_created ASC;

-- -----------------------------------------------------
-- Retrieve the Top 5 Most Recently Modified Reviews: List top 5 most recently modified reviews
-- -----------------------------------------------------
SELECT * FROM review
WHERE date_modified <> date_created
ORDER BY date_modified DESC
LIMIT 5;

-- -----------------------------------------------------
-- List All Restaurants with Ratings Greater Than the Average: Display restaurants whose ratings are above the average.
-- average rating: 4.0
-- -----------------------------------------------------
SELECT * FROM restaurant
WHERE rating >= (SELECT AVG(rating) FROM restaurant)
ORDER BY rating DESC;

-- -----------------------------------------------------
-- Retrieve the Top 5 Most Liked Restaurants: List the top 5 restaurants which frequently included in users' favorite list.
-- -----------------------------------------------------
SELECT 
	restaurant.name AS restaurant_name,
    CONCAT(restaurant.address, ', ', restaurant.city, ', ', restaurant.country) AS restaurant_address,
    restaurant.hotline_number AS restaurant_hotline,
    restaurant.rating AS restaurant_rating,
    COUNT(customer.fav_res_id) AS favourite_restaurant_count
FROM restaurant
LEFT JOIN customer ON restaurant.id = customer.fav_res_id
GROUP BY restaurant.id
ORDER BY favourite_restaurant_count DESC
LIMIT 5;

-- -----------------------------------------------------
-- List Users with Full Names: Display a list of users with their IDs and full names.
-- -----------------------------------------------------
SELECT name AS user_full_name, id AS user_id FROM customer
ORDER BY user_full_name ASC;

-- -----------------------------------------------------
-- Insert a New Restaurant: Add a new restaurant information to the database.
-- -----------------------------------------------------
INSERT INTO `restaurants`.`restaurant` 
	(`id`, `name`, `address`, `city`, `country`, `hotline_number`, `rating`) 
VALUES 
	(7301515, 'Mon Ma Mes', 'Purok 238, Barangay Neogan, Tagaytay City', 'Tagaytay City', 'Philippines', '919880065198', NULL);

INSERT INTO `restaurants`.`services` 
	(`restaurant_id`, `menu_id`, `payment_methods`, `buffet`, `brunch`, `kids_menu`, `delivery`, `take_out`, `catering`) 
VALUES 
	(7301515, 99255, 'paypal', 1, 1, 0, 0, 1, 0);
    
INSERT INTO `restaurants`.`facilities` 
	(`restaurant_id`, `bar`, `indoor_space`, `outdoor_space`, `private_room`, `parking_place`, `smoking_area`) 
VALUES 
	(7301515, 1, 1, 0, 0, 0, 1);
    
-- -----------------------------------------------------
-- Insert a New User Account: Add a new user information to the database.
-- -----------------------------------------------------
INSERT INTO `restaurants`.`customer` 
	(`id`, `name`, `gender`, `phone_number`, `email_address`, `address`, `city`, `country`, `fav_res_id`) 
VALUES 
	(7000000, 'Katlin', 'F', '603-891-1428', 'kat1285@netty.zie', '60 Main St', 'Brockport', 'USA', 7301515);

-- -----------------------------------------------------
-- Delete a Restaurant: Remove a specific restaurant information from the database.
-- -----------------------------------------------------
DELETE FROM restaurant
WHERE id = 7301515;

DELETE FROM facilities
WHERE restaurant_id = 7301515;

DELETE FROM services
WHERE restaurant_id = 7301515;

UPDATE customer
SET fav_res_id = NULL
WHERE fav_res_id = 7301515;

-- -----------------------------------------------------
-- Delete an User Account: Remove a specific user account from the database.
-- -----------------------------------------------------
DELETE FROM customer
WHERE id = 7000000;

-- -----------------------------------------------------
-- Modify a Specific restaurant Information: Update the given restaurant’s information.
-- -----------------------------------------------------
UPDATE restaurant
SET address = 'Purok 238, Barangay Neogan'
WHERE id = 7301515;

-- -----------------------------------------------------
-- Modify the Services information of a Specific Restaurant: Update the restaurant’s services information.
-- -----------------------------------------------------
UPDATE services
SET kids_menu = 1
WHERE restaurant_id = 7301515;

-- -----------------------------------------------------
-- Modify the Facilities information of a Specific Restaurant: Update the restaurant’s facilities information.
-- -----------------------------------------------------
UPDATE facilities
SET parking_place = 1
WHERE restaurant_id = 7301515;

-- -----------------------------------------------------
-- Modify a Specific User Information: Update the given user’s information.
-- -----------------------------------------------------
UPDATE customer
SET address = '670 Lake Rd N'
WHERE id = 7000000;
