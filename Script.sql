/*
 * 1. Creating database and tables 
 * 
 */

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



/*
 * 2. Inserting data
 * 
 */


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
    
