INSERT into reviews(content ,picture_url, published_at , rating  )
SELECT substring(p.description,1, 15), REVERSE(p.name),'2010-10-10 00:00:00', p.price/8
from products as p
WHERE p.id >= 5;


#3
UPDATE `products`
SET `quantity_in_stock` = `quantity_in_stock` - 5
WHERE `quantity_in_stock`BETWEEN 60 AND 70 ; 

#4
DELETE customers 
FROM 
customers 

left JOIN 
orders as o ON o.customer_id = customers.id
where o.customer_id is null; 

SELECT * FROM 
customers
left JOIN 
orders as o ON o.customer_id = customers.id
where o.customer_id is null; 

#4 
SELECT c.id FROM 
customers as c
left JOIN 
orders as o ON o.customer_id = c.id;

#5
SELECT c.id, c.`name`
FROM categories as c
ORDER BY c.`name`DESC;

#6
SELECT 
    p.id, p.brand_id, p.`name`, p.quantity_in_stock
FROM
    products AS p
WHERE
    p.price > 1000
        AND p.quantity_in_stock < 30
ORDER BY p.quantity_in_stock , p.id;

#7
SELECT r.id,
r.content,
r.rating,
r.picture_url,
r.published_at
FROM reviews as r
WHERE r.content LIKE 'My%' and char_length(r.content)> 61
ORDER BY r.rating DESC;

#8
SELECT
 concat(c.first_name, ' ', c.last_name) AS full_name,
c.address,
o.order_datetime as order_date
FROM customers as c
	 JOIN 
	orders as o ON o.customer_id = c.id
   WHERE YEAR(o.order_datetime)= '2018'
ORDER BY full_name desc;

#9 
#count(p.category_id) as `items_count`
SELECT count(p.category_id) as `items_count`,
 c.`name`, 
SUM(p.`quantity_in_stock`) AS `total_quantity`
FROM categories as c
	JOIN
    products as p ON c.id = p.category_id
GROUP BY p.category_id

ORDER BY `items_count` DESC,`total_quantity`
LIMIT 5;


#10

CREATE FUNCTION `udf_customer_products_count` (name VARCHAR(30)) 
RETURNS INT
DETERMINISTIC

RETURN( 
SELECT count(pr.id) 
FROM customers as c
	JOIN 
	orders as o ON o.customer_id = c.id
	JOIN
    orders_products as op on op.order_id = o.id
    JOIN
    products as pr ON op.product_id = pr.id
    WHERE c.first_name = name);

SELECT count(pr.id)  
FROM customers as c
	JOIN 
	orders as o ON o.customer_id = c.id
	JOIN
    orders_products as op on op.order_id = o.id
    JOIN
    products as pr ON op.product_id = pr.id
    WHERE c.first_name = 'Shirley'
    GROUP BY c.first_name
    ;
    drop function udf_customer_products_count;
call udf_customer_products_count(Shirley);

SELECT c.first_name,c.last_name, 
udf_customer_products_count('Shirley') as `total_products`
 FROM customers c
WHERE c.first_name = 'Shirley';


#11
DELIMITER $$
CREATE PROCEDURE `udp_reduce_price` (category_name VARCHAR(50))
BEGIN
	UPDATE products AS pr
		JOIN 
        categories  AS ca ON pr.category_id = ca.id
		JOIN
        reviews as rw ON pr.review_id = rw.id
        
	SET pr.price = pr.price * 0.7
    WHERE rw.rating < 4 AND category_name = ca.`name`;
        


END$$
DELIMITER ;
CALL udp_reduce_price ('Phones and tablets');


SELECT * from products AS pr
WHERE (SELECT ca.name
		FROM categories AS ca
        JOIN
        products as pr ON pr.category_id = ca.id
        JOIN
        reviews as rw ON pr.review_id = rw.id
        WHERE rw.rating < 4
          GROUP BY ca.name)
      ;

SELECT ca.name
		FROM categories AS ca
        JOIN
        products as pr ON pr.category_id = ca.id
        JOIN
        reviews as rw ON pr.review_id = rw.id
        WHERE rw.rating < 4;
        
	UPDATE products AS pr
		JOIN 
        categories  AS ca ON pr.category_id = ca.id
		JOIN
        reviews as rw ON pr.review_id = rw.id
        
	SET pr.price = pr.price * 0.7
    WHERE rw.rating < 4
		;


SELECT ca.name
		FROM categories AS ca
        JOIN
        products as pr ON pr.category_id = ca.id
        JOIN
        reviews as rw ON pr.review_id = rw.id
        WHERE rw.rating < 4;