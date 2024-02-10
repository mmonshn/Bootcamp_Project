
-- create example tables
DROP TABLE employee;

CREATE TABLE employee (
    id INT,
    name TEXT,
    level TEXT,
    manager_id INT 
);

INSERT INTO employee VALUES 
    (1, 'David', 'CEO', NULL),
    (2, 'John', 'SVP', 1),
    (3, 'Mary', 'VP', 2),
    (4, 'Adam', 'VP', 2),
    (5, 'Scott', 'Manager', 3),
    (6, 'Louise', 'Manager', 3),
    (7, 'Kevin', 'Manager', 4),
    (8, 'Takeshi', 'Manager', 4),
    (9, 'Joe', 'AM', 6),
    (10, 'Anna', 'AM', 7);

SELECT * FROM employee;

-- self join
SELECT 
	t1.id, 
    t1.name AS employeeName, 
    t1.level AS employeeLevel,
    t2.name AS managerName,
    t2.level AS managerLevel
FROM employee t1, employee t2
WHERE t1.manager_id = t2.id;

/* create table ranks and suits for cross join */
/* https://www.sqlitetutorial.net/sqlite-cross-join/ */
CREATE TABLE ranks (
    rank TEXT NOT NULL
);

CREATE TABLE suits (
    suit TEXT NOT NULL
);

INSERT INTO ranks(rank) 
VALUES('2'),('3'),('4'),('5'),('6'),('7'),('8'),('9'),('10'),('J'),('Q'),('K'),('A');

INSERT INTO suits(suit) 
VALUES('Clubs'),('Diamonds'),('Hearts'),('Spades');

select * FROM ranks 
CROSS JOIN suits ORDER BY suit;

/* subqueries */
SELECT * FROM tracks 
WHERE milliseconds = (SELECT max(milliseconds) FROM tracks);

SELECT COUNT(*) FROM tracks 
WHERE milliseconds >= (SELECT AVG(milliseconds) FROM tracks);

/* example joins */
CREATE TABLE book_shop (
	id INT,
  	name TEXT,
    release_year INT
);
  
CREATE TABLE favourite_book (
  id INT, 
  author TEXT,
  reviews REAL
);

INSERT INTO book_shop VALUES
  (1, 'Think Like A Freak', 2014),
  (2, 'Ultralearning', 2019),
  (3, 'Blue Ocean Strategy', 2015),
  (4, 'The Power of Habit', 2012),
  (5, 'Outliers', 2008);

INSERT INTO favourite_book VALUES
  (1, 'Steven D. Levitt, Stephen J. Dubner', 1904),
  (4, 'Charles Duhigg', 12007),
  (5, 'Malcolm Gladwell', 12063);

SELECT * FROM book_shop;
SELECT * From favourite_book;

SELECT * FROM book_shop A
INNER JOIN favourite_book B ON A.id = B.id; 

SELECT * FROM book_shop A
LEFT JOIN favourite_book B ON A.id = B.id; 

/* Union Intersect Except */
-- intersect = which books are in both tables
SELECT id FROM book_shop
INTERSECT
SELECT id FROM favourite_book;

-- except = which books are in the left table, but not in the right tables
SELECT id FROM book_shop
EXCEPT
SELECT id FROM favourite_book;

-- union example
CREATE TABLE book_shop_new (
  	id INT,
  	name TEXT,
 	release_year INT
  );

INSERT INTO book_shop_new VALUES
  (6, 'Business Data Science', 2020),
  (7, 'Subliminal', 2018),
  (8, 'Good Strategy Bad Strategy', 2015);
  
SELECT * FROM book_shop
UNION 
SELECT * FROM book_shop_new
ORDER BY 3 DESC;

/* more join examples */
SELECT 
	customers.country, 
    COUNT(DISTINCT customers.customerid) AS n_customers,
    COUNT(invoices.total) AS n_transactions,
    SUM(invoices.total)   AS total_revenue
FROM customers  
JOIN invoices 
ON customers.customerid = invoices.customerid 
GROUP BY 1 
ORDER BY 2 DESC;