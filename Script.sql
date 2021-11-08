/******************************************************************************************************************
 * 1. Creating database and tables 
 * 
 ******************************************************************************************************************/

CREATE DATABASE IF NOT EXISTS `order-directory`;

CREATE TABLE IF NOT EXISTS `order-directory`.supplier (
	`SUPP_ID` INT,
	`SUPP_NAME` varchar(100) NOT NULL,
	`SUPP_CITY` varchar(100) NOT NULL,
	`SUPP_PHONE` varchar(10) NOT NULL,
    PRIMARY KEY(`SUPP_ID`)
);

CREATE TABLE IF NOT EXISTS `order-directory`.customer(
    `CUS_ID` INT,
    `CUS_NAME` VARCHAR(100) NOT NULL,
    `CUS_CITY` VARCHAR(100) NOT NULL,
    `CUS_PHONE` VARCHAR(10) NOT NULL,
    `CUS_GENDER` CHAR(1) NOT NULL,
    PRIMARY KEY(`CUS_ID`)
);

CREATE TABLE IF NOT EXISTS `order-directory`.category(
    `CAT_ID` INT,
    `CAT_NAME` VARCHAR(100) NOT NULL,
    PRIMARY KEY(`CAT_ID`)
);

CREATE TABLE IF NOT EXISTS `order-directory`.product(
    `PRO_ID` INT,
    `PRO_NAME` VARCHAR(100) NOT NULL,
    `PRO_DESC` VARCHAR(100) NOT NULL,
    `CAT_ID` INT NOT NULL,
    PRIMARY KEY(`PRO_ID`),
    FOREIGN KEY(`CAT_ID`) REFERENCES category(`CAT_ID`)
);

CREATE TABLE IF NOT EXISTS `order-directory`.`product_details`(
    `PROD_ID` INT,
    `PRO_ID` INT NOT NULL,
    `SUPP_ID` INT NOT NULL,
    `PRICE` INT NOT NULL,
    PRIMARY KEY(`PROD_ID`),
    FOREIGN KEY(`PRO_ID`) REFERENCES product(`PRO_ID`),
    FOREIGN KEY(`SUPP_ID`) REFERENCES supplier(`SUPP_ID`) 
);

CREATE TABLE IF NOT EXISTS `order-directory`.order(
    `ORD_ID` INT,
    `ORD_AMOUNT` INT NOT NULL,
    `ORD_DATE` DATE,
    `CUS_ID` INT NOT NULL,
    `PROD_ID` INT NOT NULL,
    PRIMARY KEY(`ORD_ID`),
    FOREIGN KEY (`CUS_ID`) REFERENCES customer(`CUS_ID`),
    FOREIGN KEY (`PROD_ID`) REFERENCES product_details(`PROD_ID`)
);

CREATE TABLE IF NOT EXISTS `order-directory`.rating(
    `RAT_ID` INT,
    `CUS_ID` INT NOT NULL,
    `SUPP_ID` INT NOT NULL,
    `RAT_RATSTARS` INT NOT NULL, 
    PRIMARY KEY(`RAT_ID`),
    FOREIGN KEY (`SUPP_ID`) REFERENCES supplier(`SUPP_ID`),
    FOREIGN KEY (`CUS_ID`) REFERENCES customer(`CUS_ID`)
);



/******************************************************************************************************************
 * 
 * 
 * 2. Inserting data
 * 
 ******************************************************************************************************************/

INSERT INTO `order-directory`.supplier 
    (SUPP_ID,SUPP_NAME,SUPP_CITY,SUPP_PHONE)	
VALUES 
    (1,'1 Rajesh Retails','Delhi','1234567890'),
    (2,'Appario Ltd.','Mumbai','2589631470'),
    (3,'Knome products','Banglore','9785462315'),
    (4,'Bansal Retails','Koci','8975463285'),
    (5,'Mittal Ltd.','Lucknow','7898456532');

INSERT INTO `order-directory`.customer 
    (CUS_ID,CUS_NAME,CUS_CITY,CUS_PHONE,CUS_GENDER)
VALUES 
    (1,'AKASH','DELHI','9999999999','M'),
    (2,'AMAN','NOIDA','9785463215','M'),
    (3,'NEHA','MUMBAI','9999999999','F'),
    (4,'MEGHA','KOLKATA','9994562399','F'),
    (5,'PULKIT','LUCKNOW','7895999999','M');

INSERT INTO `order-directory`.category 
    (CAT_ID,CAT_NAME)	
VALUES 
    (1,'BOOKS'),
    (2,'GAMES'),
    (3,'GROCERIES'),
    (4,'ELECTRONICS'),
    (5,'CLOTHS');

INSERT INTO `order-directory`.product 
    (PRO_ID,PRO_NAME,PRO_DESC,CAT_ID)	
VALUES 
    (1,'GTA V','DFJDJFDJFDJFDJFJF',2),
    (2,'TSHIRT','DFDFJDFJDKFD',5),
    (3,'ROG LAPTOP','DFNTTNTNTERND',4),
    (4,'OATS','REURENTBTOTH',3),
    (5,'HARRY POTTER','NBEMCTHTJTH',1);

INSERT INTO `order-directory`.product_details 
    (PROD_ID,PRO_ID,SUPP_ID,PRICE)	
VALUES 
    (1,1,2,1500),
    (2,3,5,30000),
    (3,5,1,3000),
    (4,2,3,2500),
    (5,4,1,1000);

INSERT INTO `order-directory`.`order` 
    (ORD_ID,ORD_AMOUNT,ORD_DATE,CUS_ID,PROD_ID)	
VALUES 
    (20,1500,'2021-10-12',3,5),
    (25,30500,'2021-09-16',5,2),
    (26,2000,'2021-10-05',1,1),
    (30,3500,'2021-08-16',4,3),
    (50,2000,'2021-10-06',2,1);

INSERT INTO `order-directory`.rating 
    (RAT_ID,CUS_ID,SUPP_ID,RAT_RATSTARS)	
VALUES 
    (1,2,2,4),
    (2,3,4,3),
    (3,5,1,5),
    (4,1,3,2),
    (5,4,5,4);
    
   
   
   
 
/******************************************************************************************************************
 * 
 * 3. Display the number of the customer group by their genders who have placed any order
  of amount greater than or equal to Rs.3000.
 *
 *
 ******************************************************************************************************************/

SELECT cus_gender,
       Count(cus_gender)
FROM   customer c
       INNER JOIN `order` o
               ON o.cus_id = c.cus_id
WHERE  o.ord_amount >= 3000
GROUP  BY cus_gender; 


/******************************************************************************************************************
 * 
 * 
 * 4. Display all the orders along with the product name ordered by a customer having
Customer_Id=2.
 * 
 *
 ******************************************************************************************************************/

select
	o.*,
	p.PRO_NAME
from
	`order` o
inner join product_details pd 
	on
	pd.PROD_ID = o.PROD_ID
inner join product p 
	on
	p.PRO_ID = pd.PRO_ID
where
	CUS_ID = 2;

/******************************************************************************************************************
 * 
 * 
 * 5. Display the Supplier details who can supply more than one product.
 * 
 * 
******************************************************************************************************************/

SELECT
	s.*
FROM
	supplier s
where
	SUPP_ID in (
	SELECT
		SUPP_ID
	from
		product_details pd
	group by
		SUPP_ID
	HAVING
		count(SUPP_ID) > 1);



/******************************************************************************************************************
 * 
 * 
 * 6. Find the category of the product whose order amount is minimum
 * 
 * 
 * 
 ******************************************************************************************************************/


SELECT
	c.*
FROM
	`order` o
INNER JOIN product_details pd 
ON
	o.PROD_ID = pd.PROD_ID
inner join product p 
on
	p.PRO_ID = pd.PRO_ID
inner join category c 
on
	c.CAT_ID = p.CAT_ID
where
	o.ORD_AMOUNT = (
	select
		min(ORD_AMOUNT)
	from
		`order`);
	
	
/******************************************************************************************************************
 * 
 * 
 * 7. Display the Id and Name of the Product ordered after “2021-10-05”.
 * 
 * 
 * 
 ******************************************************************************************************************/

SELECT
	p.PRO_ID,
	p.PRO_NAME
FROM
	`order` o
INNER JOIN product_details pd 
ON
	pd.PROD_ID = o.PROD_ID
inner join product p 
ON
	p.PRO_ID = pd.PRO_ID
WHERE
	o.ORD_DATE > '2021-10-05';


/******************************************************************************************************************
 * 
 * 
 * 8. Print the top 3 supplier name and id and their rating on the basis of their rating along
with the customer name who has given the rating.
 * 
 * 
 * 
 ******************************************************************************************************************/

SELECT
	s.SUPP_ID,
	s.SUPP_NAME,
	c.CUS_NAME,
	r.RAT_RATSTARS
FROM
	supplier s
INNER JOIN rating r 
ON
	s.SUPP_ID = r.SUPP_ID
INNER JOIN customer c 
ON
	c.CUS_ID = r.CUS_ID
ORDER BY
	r.RAT_RATSTARS desc
LIMIT 3;



/******************************************************************************************************************
 * 
 * 
 * 9. Display customer name and gender whose names start or end with character 'A'
 * 
 * 
 * 
 ******************************************************************************************************************/

SELECT * FROM customer c WHERE CUS_NAME LIKE '%A%';


/******************************************************************************************************************
 * 
 * 10.  Display the total order amount of the male customers.
 * 
 *  
 ******************************************************************************************************************/

SELECT SUM(ORD_AMOUNT) FROM `order` o 
INNER JOIN customer c 
ON o.CUS_ID = c.CUS_ID AND c.CUS_GENDER = 'M';


/******************************************************************************************************************
 * 
 * 11.  Display all the Customers left outer join with the orders.
 *  
 ******************************************************************************************************************/



SELECT
	*
FROM
	customer c
LEFT OUTER JOIN `order` o 
ON
	c.CUS_ID = o.CUS_ID ;



/******************************************************************************************************************
 * 
 * 12.  Create a stored procedure to display the Rating for a Supplier if any along with the
Verdict on that rating if any like if rating >4 then “Genuine Supplier” if rating >2 “Average
Supplier” else “Supplier should not be considered”.
 *  
 ******************************************************************************************************************/

CREATE DEFINER = `root@localhost` PROCEDURE `supplierRating`()
BEGIN
	SELECT
	supplier.SUPP_ID ,
	supplier.SUPP_NAME,
	rating.RAT_RATSTARS,
	CASE
		WHEN rating.RAT_RATSTARS > 4 then 'Genuine'
		WHEN rating.RAT_RATSTARS > 2 then 'Average'
		ELSE 'Not Ok'
	END AS VERDICT
FROM
	rating
INNER JOIN supplier
	ON
	rating.SUPP_ID = supplier.SUPP_ID ;

END
