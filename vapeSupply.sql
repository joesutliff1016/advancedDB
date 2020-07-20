--Author: Joe Sutliff
--Description: Creates the Vape Supply database
--Date: 8/5/2017


IF DB_ID('VapeSupplyDB') IS NOT NULL
BEGIN
	DROP DATABASE VapeSupplyDB
END
GO
CREATE DATABASE VapeSupplyDB
GO

USE VapeSupplyDB
GO


CREATE TABLE Vendors 
(	

	vendorID int PRIMARY KEY IDENTITY(1, 1) NOT NULL

	,VendorName				     varchar(100) NOT NULL
	,vendorContactFirstName	     varchar(50)  NOT NULL
	,vendorContactLastName       varchar(50)  NOT NULL
	,vendorContactPhoneNumber    varchar(50)  NOT NULL
	,vendorEmail				 varchar(100) NULL
	,addressLine1				 varchar(50)  NOT NULL
	,addressLine2				 varchar(50)  NULL
	,city						 varchar(50)  NOT NULL
	,vendorState				 varchar(50)  NOT NULL
	,postalCode					 varchar(15)  NOT NULL
	,country				     varchar(50)  NOT NULL						 

)
GO
CREATE TABLE ProductLines
(	

	productLine varchar(50) PRIMARY KEY NOT NULL 
	,textDescription varchar(400)		NULL
	,htmlDescription varchar(400)	    NULL
	,productImage    varchar(300)		NULL
	,vendorID        int				NOT NULL
	REFERENCES Vendors(VendorID)
			

)
GO

CREATE TABLE Products
(
	productID int PRIMARY KEY IDENTITY(1, 1)  NOT NULL
	,productName		varchar(50)	  NOT NULL
	,productDescription varchar(400)  NULL
	,quantityInStock	int			  NOT NULL
	,productPrice		money         NOT NULL
	,productLine		varchar(50)	  NOT NULL 
	REFERENCES ProductLines(productLine)

)
GO

CREATE TABLE GiftCards
(
	cardID int PRIMARY KEY IDENTITY(1,1) NOT NULL
	,cardNumber     varchar(50)	  NOT NULL
	,cardAmount     money	      NOT NULL
		CHECK(cardAmount > 0)
	,cardBalance    money         NOT NULL
		CHECK(cardBalance > 0)
	,dateSold       datetime	  NOT NULL 
	,expirationDate datetime      NOT NULL
	,productID      int			  NOT NULL

	


	REFERENCES Products(productID)


)
GO

CREATE TABLE Cart
(
		cartID int PRIMARY KEY IDENTITY(1,1)  NOT NULL
		,quantity     int		    NOT NULL
		,productPrice money         NOT NULL
			CHECK(productPrice > 0)
		,productID    int           NOT NULL
		REFERENCES Products(productID)

)

GO

CREATE TABLE Stores
(
	storeID int PRIMARY KEY	IDENTITY(1,1) NOT NULL
	,addressLine1 varchar(50)  NOT NULL
	,addressLine2 varchar(50)  NULL
	,city		  varchar(50)  NOT NULL
	,storeState   varchar(50)  NOT NULL
	,postalCode   varchar(15)  NOT NULL
	,country      varchar(50)  NOT NULL
	,storePhone       varchar(50)  NOT NULL
	,storeEmail       varchar(100) NOT NULL

)
GO

CREATE TABLE Employees 
(
	salesRepEmployeeID int PRIMARY KEY IDENTITY(1,1) NOT NULL
	,lastName  varchar(50)  NOT NULL
	,firstName varchar(50)  NOT NULL
	,employeePhone     varchar(50)  NOT NULL
	,employeeEmail     varchar(100) NOT NULL
	,storeID   int          NOT NULL
	REFERENCES Stores(storeID) 


)
GO

CREATE TABLE Customer
(
	customerID int PRIMARY KEY IDENTITY(1,1) NOT NULL
	,customerFirstName varchar(50) NOT NULL
	,customerLastName  varchar(50) NOT NULL
	,phone             varchar(50) NOT NULL
	,email             varchar(100) NOT NULL
	,addressLine1      varchar(50) NOT NULL
	,addressLine2      varchar(50) NULL
	,city              varchar(50) NOT NULL
	,customerState     varchar(50) NOT NULL
	,zipCode           varchar(15) NOT NULL
	,salesRepEmployeeID int        NOT NULL
	REFERENCES Employees(salesRepEmployeeID)


)
GO
CREATE TABLE registeredUsers
(
	userID int PRIMARY KEY IDENTITY(1,1) NOT NULL
	,Username	varchar(50)	UNIQUE NOT NULL
		CHECK(LEN(Username) >= 5)
	,PasswordHash	varchar(255)   NOT NULL
	,PasswordSalt	varchar(100)   NOT NULL
	,customerID int				   NOT NULL
	REFERENCES Customer(customerID)



)

CREATE TABLE Orders
(
	orderID int PRIMARY KEY IDENTITY(1,1) NOT NULL
	,orderDate   datetime    NOT NULL
	,shippedDate datetime    NULL
	,orderStatus varchar(15) NOT NULL
	,comments    text        NULL
	,customerID  int         NOT NULL
	REFERENCES Customer(customerID)


)
GO

CREATE TABLE OrderDetails
(
		orderID int PRIMARY KEY NOT NULL
		REFERENCES Orders(orderID)
		,quantityOrdered int    NOT NULL
		,priceEach       money  NOT NULL
			CHECK(priceEach > 0)
		,cartID          int    NOT NULL
		REFERENCES Cart(cartID)
		,productID       int    NOT NULL
		REFERENCES Products(productID)

)
GO

CREATE TRIGGER Vendors_UPSERT_CaseVendorState
	ON Vendors
	AFTER INSERT, UPDATE
AS
BEGIN
	UPDATE Vendors
	SET vendorState = UPPER(vendorState)
	WHERE vendorID IN
		(
			SELECT vendorID 
			FROM inserted
		)

END

SELECT *
FROM Vendors


INSERT INTO Vendors(VendorName,vendorContactFirstName,vendorContactLastName,vendorContactPhoneNumber,vendorEmail,addressLine1,city,vendorState,postalCode,country) 
		VALUES('KangerTech', 'Hong', 'Lee','(372)439-3409','honglee@hotmail.com','20139 51st ave ne','Compton','California','81009','United States')

INSERT INTO Vendors(VendorName,vendorContactFirstName,vendorContactLastName,vendorContactPhoneNumber,vendorEmail,addressLine1,city,vendorState,postalCode,country) 
		VALUES('VapeNW', 'Jill', 'Jenson','(253)626-3213','jill@gmail.com','2307 s pinebrook lane','Kent','Washington','98409','United States')

INSERT INTO Vendors(VendorName,vendorContactFirstName,vendorContactLastName,vendorContactPhoneNumber,vendorEmail,addressLine1,city,vendorState,postalCode,country) 
		VALUES('CardSolutions', 'Russel', 'Wilson','(425)391-4000','hawkman@gmail.com','10007 Football lane','Bellevue','Washington','97006','United States')


INSERT INTO ProductLines(productLine, vendorID)
VALUES ('Coils', '1')

INSERT INTO ProductLines(productLine, vendorID)
VALUES ('Batteries', '2')

INSERT INTO ProductLines(productLine, vendorID)
VALUES ('GiftCards', '3')


INSERT INTO Products(productName,quantityInStock,productPrice,productLine)
VALUES ('TR100','1000','20.00','Batteries')

INSERT INTO Products(productName,quantityInStock,productPrice,productLine)
VALUES ('J159','857','1.99','Coils')

INSERT INTO Products(productName,quantityInStock,productPrice,productLine)
VALUES ('Card1','500','100','GiftCards')


INSERT INTO GiftCards(cardNumber,cardAmount,cardBalance,dateSold,expirationDate,productID)
VALUES ('8127837101','100.00','20.43','8/3/2017','8/3/18','3')

INSERT INTO GiftCards(cardNumber,cardAmount,cardBalance,dateSold,expirationDate,productID)
VALUES ('8127837103','100.00','80','8/2/2017','8/2/18','3')

INSERT INTO Cart (quantity,productPrice,productID)
VALUES ('1','1.99','1')

INSERT INTO Cart (quantity,productPrice,productID)
VALUES ('4','60.00','2')


INSERT INTO Stores(addressLine1,city,storeState,postalCode,country,storePhone,storeEmail)
VALUES('3232 Bilberry Ave s','Hollywood','California','78999','United States','(619)327-9999','corpHeadquarters@hotmail.com')

INSERT INTO Stores(addressLine1,city,storeState,postalCode,country,storePhone,storeEmail)
VALUES('20399','Los Angeles','California','77888','United States','(720)419-8759','store1@gmail.com')


INSERT INTO Employees(lastName,firstName,employeePhone,employeeEmail,storeID)
VALUES('Johnson','Dave','(427)798-6544','johnson@yahoo.com','1')


INSERT INTO Employees(lastName,firstName,employeePhone,employeeEmail,storeID)
VALUES('Marshall','Jim','(427)232-4279','marshall@gmail.com','2')


INSERT INTO Customer(customerFirstName,customerLastName,phone,email,addressLine1,city,customerState,zipCode,salesRepEmployeeID)
VALUES('Bruce','Lee','(206)559-3135','kungfufighter@comcast.net','45466 s g st','Seattle','Washington','98146','1')

INSERT INTO Customer(customerFirstName,customerLastName,phone,email,addressLine1,city,customerState,zipCode,salesRepEmployeeID)
VALUES('Chuck','Nelson','(206)395-4754','nels@gmail.com','2166 s Camdon st','Seattle','Washington','98146','2')



INSERT INTO Orders(orderDate,shippedDate,orderStatus,customerID)
VALUES('8/3/2017','8/5/17','shipped','1')

INSERT INTO Orders(orderDate,shippedDate,orderStatus,customerID)
VALUES('8/2/2017','8/4/17','shipped','2')

INSERT INTO OrderDetails(orderID,quantityOrdered,priceEach,cartID,productID)
VALUES('1','2','6.00','1','1')

INSERT INTO OrderDetails(orderID,quantityOrdered,priceEach,cartID,productID)
VALUES('2','2','10.00','2','2')


/*This would be useful if I were trying to locate all of the vendors in a particular state.*/
SELECT *
FROM Vendors WHERE vendorState = 'Washington'



/*It would be useful to see how many gift cards in circulation have a particular balance:*/
SELECT * 
FROM GiftCards 
WHERE cardBalance < '80'

/*If I wanted to take a look at customer spending habits when the quantity is greater than 1 item:*/
SELECT * 
FROM Cart 
WHERE quantity > '1'

/*If I wanted a list of sales reps at a particular store location:*/
SELECT salesRepEmployeeID,firstName,lastName
FROM Employees
WHERE storeID = '2'

/*If I wanted to see a client list for a particular sales rep:  */
SELECT customerID,customerFirstName,customerLastName,phone,salesRepEmployeeID
FROM Customer
WHERE salesRepEmployeeID ='2'


/* If I wanted to see the status of all orders on a particular day:*/
SELECT orderID,orderStatus
FROM Orders
WHERE orderDate = '8/3/2017'

/* If I wanted to send out special offers to all of my customers via email*/
SELECT email
FROM Customer






Views

--1.This one pulls up customer contact information which I think is useful.
GO
CREATE VIEW contactCustomer
AS
SELECT customerFirstName
	,customerLastName
	,phone
	,email

FROM Customer
GO

--2.This view makes it easy to take a look at product qauntity.
GO
CREATE VIEW productQuantity
AS 
SELECT productName
	,quantityInStock

FROM products


--3.This view is useful because it returns product and vendor information for every product in the database.
GO
CREATE VIEW vendorProducts
AS 
SELECT vendorName
	,productName
	,productDescription
	,quantityInStock

FROM Products JOIN ProductLines
ON Products.productLine = ProductLines.productLine
JOIN Vendors ON ProductLines.vendorID = Vendors.vendorID
GO

--4.I thought that this one would be useful if you wanted to take a look at customer spending.
GO
CREATE VIEW	customerOrders
AS
SELECT quantityOrdered
	,priceEach
	,customerFirstName
	,customerLastName
	,phone
	,email

FROM OrderDetails JOIN Orders
ON OrderDetails.orderID = Orders.orderID
JOIN Customer ON Orders.customerID = Customer.customerID
GO

--5.If I wanted a list of employee information with the location that they work at, this would be useful.
GO
CREATE VIEW employeeStores
AS
SELECT lastName
	,firstName
	,employeePhone
	,employeeEmail
	,city
	,storeState
FROM Employees JOIN Stores
ON Employees.storeID = Stores.storeID
GO





--Stored Procedures


--1.I thought that this would be useful if I wanted to check how many orders weren't shipped yet. 
--I pulled the customer information just in case we wanted to contact them.
GO
CREATE PROC ordersNotShipped
AS
SELECT orderDate
	,orderStatus
	,customerFirstName
	,customerLastName
	,email
	,phone
FROM Orders JOIN Customer
ON Orders.customerID = Customer.customerID
WHERE orderStatus = 'not shipped'
GO



--2.This stored procedure makes it easy to examine the products that your selling online.
GO
CREATE PROC onlineProducts
AS
SELECT htmlDescription
	,productImage
	,productName
FROM Products JOIN ProductLines
ON Products.productLine = ProductLines.productLine
GO

--3.This stored procedure makes it easy to pull up the customer contact list.
GO
CREATE PROC customerContact
AS
SELECT customerFirstName
	,customerLastName
	,phone
	,email

FROM Customer
GO


--4.This stored procedure makes it easy to pull up the employee contact list.
GO
CREATE PROC employeeContact
AS
SELECT firstName
	,lastName
	,employeePhone
	,employeeEmail

FROM Employees
GO


--5.This stored procedure makes it easy to look at the Orders data.
GO
CREATE PROC allOrders
AS
SELECT orderDate
	,shippedDate
	,orderStatus
	

FROM Orders
GO


--6.This stored procedure makes it easy to look at productPrice and quantity.
GO
CREATE PROC orderInfo
	@quantity int
	,@productPrice money

AS 
SELECT productPrice
	,quantityOrdered

FROM OrderDetails JOIN Cart
ON OrderDetails.productID = Cart.productID
GO


--7.This procedure is useful because it allows you to easily look at product name and html description.
GO
CREATE PROC onlineProduct
	@productName varchar(50)
	,@htmlDescription varchar(400)

AS 
SELECT productName
	,htmlDescription

FROM Products JOIN ProductLines

ON Products.productLine = ProductLines.productLine
WHERE productName = @productName
AND 
htmlDescription = @htmlDescription
GO


