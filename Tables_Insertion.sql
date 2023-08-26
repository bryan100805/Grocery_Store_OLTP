USE GroceryStore2214449;

--Drop tables if they exist
DROP TABLE IF EXISTS Inventory;
DROP TABLE IF EXISTS Trans;
DROP TABLE IF EXISTS Depends;
DROP TABLE IF EXISTS Checkout;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Item_Info;
DROP TABLE IF EXISTS Store;

--Creating tables
CREATE TABLE Store
(Store_ID decimal(3,0) not null,
Address varchar(100) not null,
Manager Integer not null,
PRIMARY KEY (Store_ID));

CREATE TABLE Employee
(Employee_ID Integer not null,
Employee_Name varchar(85) not null,
SSN decimal(9,0) not null,
Phone decimal(10,0) not null,
Store_ID decimal(3,0) not null,
Address varchar(100) not null,
Password varchar(255) null,
Manager Integer null,
Email varchar(255) null,
Date_hired date null,
Date_Start date not null,
Date_end date null,
PwdChange_Date date null,
Annual_Pay money null,
Hourly_Pay money null,
PayType smallint not null,
PRIMARY KEY (Employee_ID),
FOREIGN KEY (Manager)
REFERENCES Employee(Employee_ID),
FOREIGN KEY (Store_ID)
REFERENCES Store(Store_ID));

CREATE TABLE Customer
(Cust_ID Integer not null,
Cust_Name varchar(85) not null,
Phone decimal(10,0) null,
Email varchar(255) null,
Date_Joined date not null,
DateLastTrans date not null,
PRIMARY KEY (Cust_ID));

CREATE TABLE Item_Info
(Item_ID Integer not null,
Brand varchar(45) not null,
Item_Description varchar(255) not null,
Price money not null,
Cost money not null,
Shape varchar(20) not null,
Size varchar(12) not null,
UPC decimal(6,0) not null,
Weight money not null,
Taxable smallint not null,
PRIMARY KEY (Item_ID));

CREATE TABLE Checkout
(Checkout_ID Integer not null,
Employee_ID Integer not null,
Cust_ID Integer not null,
Store_ID decimal(3,0) not null,
Trans_Date date not null
PRIMARY KEY (Checkout_ID),
FOREIGN KEY (Employee_ID)
REFERENCES Employee(Employee_ID),
FOREIGN KEY (Store_ID)
REFERENCES Store(Store_ID),
FOREIGN KEY (Cust_ID)
REFERENCES Customer(Cust_ID));

CREATE TABLE Inventory
(Store_ID decimal(3,0) not null,
Item_ID Integer not null,
Quantity Integer not null,
PRIMARY KEY (Store_ID, Item_ID),
FOREIGN KEY (Store_ID)
REFERENCES Store(Store_ID),
FOREIGN KEY (Item_ID)
REFERENCES Item_Info(Item_ID));

CREATE TABLE Trans
(Checkout_ID Integer not null,
Item_ID Integer not null,
Quantity Integer not null,
PRIMARY KEY (Checkout_ID, Item_ID),
FOREIGN KEY (Checkout_ID)
REFERENCES Checkout(Checkout_ID),
FOREIGN KEY (Item_ID)
REFERENCES Item_Info(Item_ID));

CREATE TABLE Depends
(Employee_ID Integer not null,
Dependent_Name varchar(85) not null,
Relationship varchar(20) not null,
Email varchar(255) null,
Date_Created date not null,
PRIMARY KEY (Employee_ID, Dependent_Name),
FOREIGN KEY (Employee_ID)
REFERENCES Employee(Employee_ID));

-- Insert Data
INSERT INTO Store VALUES 
    (159, '13636 Fir St', 14),
    (247, '64 CCK St', 10),
	(348, '690 Almond St', 10),
    (354, '820 Birch Rd', 15),
    (369, '940 Green St', 6),
    (674, '14496 Maple Way', 6),
    (696, '710 Edison Dr', 4),
    (778, '341 Main St', 15),
    (854, '22556 Elm St', 14),
    (989, '500 Dover Road', 15);

INSERT INTO Item_Info VALUES
    (12, 'Nabisco', 'Cookies', 2.25, 1.00, 'Oval', '23x5x20', 224852, 22.40, 1),
    (145, 'Kleenex', 'Tissues', 2.99, 1.00, 'Rectangle', '3x19x4', 178965, 34.00, 0),
    (256, 'Hersey', 'Candy', 3.99, 2.00, 'Rectangle', '4x16x6', 123058, 52.80, 0),
    (335, 'DelMonte', 'Canned Fruit', 0.50, 0.10, 'Square', '3x3x3', 411255, 5.20, 1),
    (658, 'PhillpMorris', 'Cigarettes', 5.00, 3.00, 'Square', '8x8x8', 596543, 89.00, 0),
    (1566, 'HomeBrand' , 'Spaghetti', 0.99, 0.50, 'Round', '3x3x3', 698547, 3.00, 0),
    (2365, 'Kellogg', 'Cereal', 1.99, 0.50, 'Round', '10x10x10', 557858, 18.00, 1),
    (3521, 'Nabisco', 'Crackers', 4.00, 2.00, 'Round', '4x4x4', 254413, 2.00, 0),
    (4587, 'Kraft', 'Cheese', 6.00, 4.00, 'Rectangle','6x12x3', 845532, 0.11, 0),
    (84854, 'Quaker', 'Oatmeal', 2.50, 1.00, 'Square', '2x2x2', 556487, 1.00, 0);


INSERT INTO Employee VALUES
    (1, 'Darrel Philbin', 654269856, 5489659874, 854, '258 Cumberland dr', '1234', 14, 'baldman@gmail.com', NULL, '1985-04-05', '2011-02-02', '2010-05-25', NULL, 20, 0),
    (2, 'Ricky Tanner' , 125651452, 6988532587, 696, '1587 H st', 'Abcdef', 4, 'omegaman@aol.com', NULL, '1990-06-08', '1999-06-10', '2003-01-14', NULL, 10,0),
    (3, 'Susan Philips', 145969658, 9856984523, 369, '695 LMNOP st', 'Password', 4, 'streetsmartkid@hampster.edu', NULL, '1972-06-09', NULL, '1984-03-14', NULL, 15,0),
    (4, 'George Scott', 147589652, 2586521452, 696, '4521 Gold st', 'Alpha', 9, NULL, NULL, '1999-07-25', NULL, NULL, 42000, NULL,1),
    (5, 'Erin Abernathy', 256985698, 5896583541, 369, '635 Number In' , 'Bottle', 6, 'drinkerster@gmail.com', NULL, '1998-12-20', NULL, '1999-01-01', NULL, 30, 0),
    (6, 'Ted Smith', 352956587, 4736593569, 369, '12 S st', 'Workshop', 9, NULL, NULL, '1989-06-08', NULL, NULL, 50000, NULL,1),
    (7, 'Harry Buts', 458521658, 2586584763, 674, '1 wonder st', 'Password', 6, NULL, NULL, '1970-10-20', NULL, '2000-09-21', NULL, 12,0),
	(15, 'Luke Ted', 111111144, 2144544123, 354, '65 Southland Av', NULL, 9, NULL, NULL, '2004-09-09',NULL, NULL, 20000, NULL,1),
    (8, 'Myanar Teener', 256656521, 2596573257, 674, '24 nice In', 'Password', 6, 'Meme585@gmail.com', NULL, '2005-06-04', NULL, '2008-03-14', NULL, 9.25,0),
    (9, 'Matt Longfellow', 958786548, 5249868525, 354, '6144 Computer dr', 'Password', NULL, 'thisisshort@az.com', NULL, '2000-09-21', NULL, NULL, 60000, NULL,1),
    (10, 'Jerry Garcia', 758965897, 6521458569, 247, '214 Q st', '1234', 9, 'govperson@gov.gov', NULL, '1990-09-24', NULL, NULL, 52000, NULL,1),
    (11, 'Lawarnce Tom', 625458569, 9658745632, 159, '2154 Beech st', NULL, 14, NULL, NULL, '1989-01-20', '2011-01-01', '2006-11-14', NULL, 15,0),
    (12, 'Dexter Robert', 254125478, 1111111111, 778, '365 Moon dr', NULL, 15, NULL, NULL, '1990-05-06', NULL, '2005-09-01', NULL, 12.25,0),
    (13, 'Mark Nick', 563258965, 2225478512, 989, '65412 B St', NULL, 15, NULL, NULL, '1998-02-05', NULL, '2005-08-09', NULL, 8.25, 0),
    (14, 'Jeremy David', 111111112, 2356895654, 159, '2 Molly Way', NULL, 9, NULL, NULL, '2000-06-03', NULL, NULL, 16000, NULL, 1)

INSERT INTO Customer Values
	(50, 'Bob Hope', 6615552485, 'Bobhope@gmail.com', '2001-01-01','2011-05-07'),
	(51, 'Renee Hicks', 4589854588,	'Dragonthing@aol.com', '2005-05-05','2011-04-25'),
	(52, 'Scott Sheer',	4176521425,	'Scotts@hotmail.com', '2011-12-12','2011-03-14'),
	(53, 'Colleen Mctyre', NULL, 'CMCT@ct.com',	'2008-08-12','2009-12-05'),
	(58, 'Bart Simpson', NULL, NULL, '2001-06-06','2007-08-25'),
	(67, 'Lisa Girl', 6619755896, NULL,	'1999-04-09','2011-04-06'),
	(99, 'Jeremy Scott', 4586895847, 'TheBigMan@gmail.com', '2000-01-09','2011-10-10'),
	(105, 'Master Shake', 5555555555, 'MixMaster@crimefighter.org', '2000-08-25', '2011-08-18'),
	(178, 'Bruce Wayne', 6619872145, 'lamBatman@crimefighter.org', '2000-01-09', '2011-02-15'),
	(179, 'Seymoure Butes',	4789582145,	'SButes@education.edu',	'2001-01-01', '2001-08-18');

INSERT INTO Depends VALUES
	(13, 'Jonas Nick', 'Father', 'nickJonas@hotmail.com', '2005-09-02'),
	(14, 'Jeremy Zucker', 'Mother', 'jeremyZuck@hotmail.com', '2000-03-23');

INSERT INTO Checkout (Checkout_ID, Cust_ID, Store_ID, Employee_ID, Trans_Date) VALUES
	(0, 50, 854, 1, '2011-06-10'),
	(1, 178, 778, 12, '2011-12-12'),
	(2, 99, 159, 11, '2010-06-05'),
	(3, 105, 369, 3, '2007-04-05'),
	(4, 51, 354, 15, '2011-06-09'),
	(5, 52, 696, 2, '2010-08-12'),
	(6, 179, 674, 7, '2009-11-05');

INSERT INTO Inventory VALUES
	(159, 1566, 31),
	(159, 335, 27),
	(247, 145, 56),
	(348, 256, 100),
	(354, 1566, 4),
	(369,3521,113),
	(674,2365,0),
	(674,4587,23),
	(696,12,23),
	(696,658,38),
	(778,84854,350),
	(854,12,10),
	(854,658,10),
	(989,145,560);

INSERT INTO Trans VALUES
	(0, 256, 2),
	(0, 2365, 2),
	(1, 145, 10),
	(2, 4587, 2),
	(3, 4587, 4),
	(4, 1566, 4),
	(4, 145, 3),
	(4, 12, 2),
	(4, 84854, 2),
	(5, 2365, 2),
	(5, 4587, 2),
	(6, 12, 2),
	(6, 658, 2);

ALTER TABLE Store
ADD CONSTRAINT FK_Manager_Employee
FOREIGN KEY (Manager)
REFERENCES Employee(Employee_ID)