--Author: Joe Sutliff
--Description: Creates the Pizza DataBase
--Date: 8/28/2017


IF DB_ID('PizzaDB') IS NOT NULL
BEGIN
	DROP DATABASE PizzaDB
END
GO
CREATE DATABASE PizzaDB
GO

USE PizzaDB
GO


CREATE TABLE Products
(	

	productID int PRIMARY KEY IDENTITY(1, 1) NOT NULL

	,productName				 varchar(100)  NOT NULL
	,productPrice				 money         NOT NULL
	,productDescription          varchar(400)  NULL
	,productThumbnailPhoto       varchar(300)  NULL
	,productLargerPhoto			 varchar(300)  NULL
	,productPhotoAltText		 varchar(100)  NULL
	,productIngredients		     varchar(300)  NULL
	
					 
)
GO

CREATE TABLE Categories
(	
	categoryID int PRIMARY KEY IDENTITY  NOT NULL

   ,productName					varchar(100) NOT NULL
   ,quantityInStock				int			 NOT NULL
   ,priceEach				    money        NOT NULL
   ,productID				    int			 NOT NULL
   REFERENCES Products(productID)


)
GO

CREATE TABLE Customer
(
	customerID int PRIMARY KEY IDENTITY(1,1) NOT NULL

	,customerFirstName varchar(50) NOT NULL
	,customerLastName  varchar(50) NOT NULL
	,phone             varchar(50) NOT NULL
	,email             varchar(100)NULL
	,addressLine1      varchar(50) NOT NULL
	,addressLine2      varchar(50) NULL
	,city              varchar(50) NOT NULL
	,customerState     varchar(50) NOT NULL
	,zipCode           varchar(15) NOT NULL

)
GO

CREATE TABLE Cart
(
	cartID int PRIMARY KEY IDENTITY(1, 1)  NOT NULL

	,quantity					int	       NOT NULL
	,price						money	   NOT NULL
	,productID					int		   NOT NULL
	REFERENCES Products(productID)
	,customerID					int		   NOT NULL
	REFERENCES Customer(customerID)

)
GO

CREATE TABLE Orders 
(
	orderID	int PRIMARY KEY IDENTITY(1, 1)	NOT NULL
	,orderDate	 datetime	 NOT NULL
	,orderStatus varchar(15) NOT NULL
	,comments    text		 NULL
	,customerID  int		 NOT NULL
	REFERENCES Customer(customerID)

)
GO



INSERT INTO Products(productName,productPrice,productDescription,productThumbnailPhoto,productLargerPhoto,productPhotoAltText,productIngredients)
		VALUES('Pepperoni Pizza','12.99','Pepperoni&Cheese Pizza','pepperoni-t.jpg','pepperoni.jpg','pepperoni pizza','Cheese, pepperoni, and pizza sauce.')

INSERT INTO Products(productName,productPrice,productDescription,productThumbnailPhoto,productLargerPhoto,productPhotoAltText,productIngredients)
		VALUES('Cheese Pizza','9.99','Cheese Pizza','cheese-t.jpg','cheese.jpg','cheese pizza','Cheese and pizza sauce.')



INSERT INTO Categories(productName,quantityInStock,priceEach,productID)
		VALUES('Pepperoni Pizza','200','12.99','1')

INSERT INTO Categories(productName,quantityInStock,priceEach,productID)
		VALUES('Cheese Pizza','300','9.99','2')


INSERT INTO Customer(customerFirstName,customerLastName,phone,email,addressLine1,city,customerState,zipCode)
		VALUES('Joseph','Williams','(253)661-4319','206williams@hotmail.com','6040 Pine Lane','Kent','WA','98055') 

INSERT INTO Customer(customerFirstName,customerLastName,phone,email,addressLine1,city,customerState,zipCode)
		VALUES('Mike','Tyson','(317)322-4512','koking@gmail.com','21008 Boxer Ave','Kent','WA','98055')           



INSERT INTO Cart(quantity,price,productID,customerID)
		VALUES('2','25.98','1','1')	
		
INSERT INTO Cart(quantity,price,productID,customerID)
		VALUES('1','9.99','2','2')
		
		
INSERT INTO Orders(orderDate,orderStatus,comments,customerID)
		VALUES('8/28/17 8:30:00 PM','delivered','parking around back.','1')	
		
		
INSERT INTO Orders(orderDate,orderStatus,customerID)
		VALUES('8/28/17 8:33:00 PM','delivered','2')
		
		
				
SELECT productName, priceEach
FROM Categories WHERE categoryID ='1'

SELECT productName, priceEach
FROM Categories WHERE categoryID ='2'

SELECT * FROM Products
ORDER BY productPrice DESC

SELECT * FROM Products
ORDER BY productPrice ASC

SELECT * FROM Products
ORDER BY productName DESC

SELECT * FROM Products
ORDER BY productName ASC

SELECT * FROM Products