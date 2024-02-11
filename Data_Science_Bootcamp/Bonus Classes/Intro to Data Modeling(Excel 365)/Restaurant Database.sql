-- Table 1
-- DROP TABLE food_types;
CREATE TABLE food_types (
  typeId INT UNIQUE PRIMARY KEY,
  typeName TEXT
);
INSERT INTO food_types VALUES
  (1, 'Fried rice'),
  (2, 'Soup'),
  (3, 'Rice'),
  (4, 'Noodle');
  
-- Table 2
-- DROP TABLE menus;
CREATE TABLE menus (
		menuId INT UNIQUE PRIMARY KEY,
  	menuName TEXT,
    price REAL,
    typeId INT
);
INSERT INTO menus VALUES
	(1, "Pork Fried Rice", 45, 1),
  (2, "Chicken Fried Rice", 45, 1),
  (3, "Seafood Fried Rice", 50, 1),
  (4, "Tom-Yam Kung", 60, 2),
  (5, "Clear glass noodle soup", 60, 2),
  (6, "Rice topped with stir-fried pork and basil", 30, 3),
  (7, "Roasted duck on rice", 35, 3),
  (8, "Pad-Thai Noodle with Seafood", 50, 4),
  (9, "Stir-Fried Rice Noodle with Chicken in Gravy", 45, 4),
  (10, "Stir-Fried Rice Noodle with Seafood in Gravy", 50, 4);

-- Table 3
-- DROP TABLE member_levels;
CREATE TABLE member_levels (
  levelId INT UNIQUE PRIMARY KEY,
  levelName TEXT
);
INSERT INTO member_levels VALUES
  (1, 'Bronze Card'),
  (2, 'Silver Card'),
  (3, 'Gold Card');

-- Table 4
-- DROP TABLE customers;
CREATE TABLE customers (
		customerId INT UNIQUE PRIMARY KEY,
  	firstname TEXT,
    lastname TEXT,
    phone TEXT,
    country TEXT,
    levelId INT
);
INSERT INTO customers VALUES
	(101, 'Eric', 'Cantona', '(+66)95-524-0748', 'French',2),
  (102, 'Roy', 'Keane','(+66)97-984-5386', 'Ireland',1),
  (103, 'Paul', 'Scholes', '(+66)98-274-6348', 'United Kingdom', 1),
  (104, 'David', 'Beckham', '(+66)61-075-0378', 'United Kingdom', 3),
  (105, 'Wayne', 'Rooney', '(+66)87-215-8277', 'United Kingdom', 2),
  (106, 'Ryan', 'Giggs', '(+66)61-075-0378', 'Wales',3);

-- Table 5
-- DROP TABLE orders;
CREATE TABLE orders (
		orderId INT UNIQUE PRIMARY KEY,
  	orderDate DATE,
    menuId INT,
    customerId INT
);
INSERT INTO orders VALUES
	(1, '2023-01-01 12:00:00', 1, 101),
  (2, '2023-01-01 12:00:12', 3, 103),
  (3, '2023-01-01 15:30:57', 2, 104),
  (4, '2023-01-01 15:31:04', 4, 104),
  (5, '2023-01-01 15:33:12', 5, 105),
  (6, '2023-01-02 13:27:33', 6, 102),
  (7, '2023-02-13 09:40:59', 7, 103),
  (8, '2023-02-13 09:45:22', 6, 106),
  (9, '2023-02-13 09:45:47', 7, 104),
  (10, '2023-02-28 10:46:08', 9, 101),
  (11, '2023-03-01 11:34:12', 10, 102),
  (12, '2023-03-01 11:35:41', 1, 106),
  (13, '2023-03-01 14:21:45', 9, 105);
