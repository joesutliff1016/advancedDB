--1.Select the product name, location name, and the quantity for all products. (Tables are in the Production schema).

SELECT Product.Name
	 ,Location.Name
	 ,ProductInventory.Quantity

FROM Production.Product 
	JOIN Production.ProductInventory ON 
	Product.ProductID = ProductInventory.ProductID 
	JOIN Production.Location ON 
	ProductInventory.LocationID = Location.LocationID

--2.Select each product category and the corresponding product sub categories (Tables are in the  Production schema)

SELECT *
FROM Production.Product 
	JOIN Production.ProductSubcategory ON
	Product.ProductSubcategoryID = ProductSubcategory.ProductSubcategoryID
	--I'm not really sure how to do this one. What is the definition of a subcategory? Is it
	--all of the tables that are directly connected to Production.Products?





--3.Using Person.Person, Sales.CreditCard, and Sales.PersonCreditCard. 
--Select the first and last name of every person, their credit card number, and the credit card type. 
--If the person does not have a credit card they should still be in the result set.


SELECT Person.Person.FirstName
		,Person.Person.LastName
		,Sales.CreditCard.CardNumber
		,Sales.CreditCard.CardType
FROM Sales.CreditCard 
	JOIN Sales.PersonCreditCard ON
	CreditCard.CreditCardID = PersonCreditCard.CreditCardID
	JOIN Person.Person ON 
	Person.BusinessEntityID = PersonCreditCard.BusinessEntityID



--4.In the result set, show the employees first and last name 
--(from the Person table), the Department name, and their JobTitle.

SELECT Person.Person.FirstName
		,Person.Person.LastName
		,HumanResources.Department.Name
		,HumanResources.Employee.JobTitle

FROM HumanResources.Department 
	JOIN HumanResources.EmployeeDepartmentHistory ON 
	Department.DepartmentID = EmployeeDepartmentHistory.DepartmentID
	JOIN HumanResources.Employee ON 
	EmployeeDepartmentHistory.BusinessEntityID = Employee.BusinessEntityID
	JOIN Person.Person ON 
	Employee.BusinessEntityID = Person.BusinessEntityID




