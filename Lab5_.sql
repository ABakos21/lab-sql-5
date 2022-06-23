use sakila;
#1
ALTER TABLE staff
DROP COLUMN picture;
#2
use bank;
insert into bank.loan values(8000,8000000,930705,96396,12,8033.0,'C');
/*2. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
*/
INSERT INTO staff ()
SELECT 3,first_name,last_name,address_id,email,store_id,True,first_name,"",Now()
FROM customer
where first_name = "TAMMY" and last_name = "SANDERS";
/*
3. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. You can use current date for the `rental_date` column in the `rental` table.
   **Hint**: Check the columns in the table rental and see what information you would need to add there. You can query those pieces of information. For eg., you would notice that you need `customer_id` information as well. To get that you can use the following query:
    ```sql
    select customer_id from sakila.customer
    where first_name = 'CHARLOTTE' and last_name = 'HUNTER';
    ```
    
    Use similar method to get `inventory_id`, `film_id`, and `staff_id`.
*/
# Check the necessary information


SELECT 
    staff_id
FROM
    sakila.staff
WHERE
    first_name = 'Mike'
        AND last_name = 'Hillyer'; 
# staff_id for Mike= 1

SELECT 
    customer_id
FROM
    sakila.customer
WHERE
    first_name = 'CHARLOTTE'
        AND last_name = 'HUNTER'; 
#   customer_id=130     

SELECT 
    film_id
FROM
    film
WHERE
    title = 'Academy Dinosaur';
# film_id = 1

SELECT 
    inventory_id
FROM
    inventory
WHERE
    film_id = 1; 
# inventory_id 1..8    
SELECT 
    *
FROM
    rental
LIMIT 1;

insert into rental ()
select max(rental_id)+1,Now(), 9, 130, null, 1, Now() from rental;

#check insertion
SELECT 
    *
FROM
    rental
ORDER BY rental_id DESC
LIMIT 1;

/*
4. Delete non-active users, but first, create a _backup table_ `deleted_users` to store `customer_id`, `email`, and the `date` for the users that would be deleted. Follow these steps:
*/

#- Check if there are any non-active users
SELECT 
    *
FROM
    customer
WHERE
    active = 0;

# - Create a table _backup table_ as suggested
CREATE TABLE customer_backup LIKE customer;

#- Insert the non active users in the table _backup table_
INSERT INTO customer_backup ()
SELECT * FROM customer WHERE `active` = 0;

#checking inserted data
SELECT 
    *
FROM
    customer_backup
LIMIT 10;


#- Delete the non active users from the table _customer_
SET SQL_SAFE_UPDATES = 0;
DELETE FROM customer 
WHERE
    `active` = 0; 
SET SQL_SAFE_UPDATES = 1;