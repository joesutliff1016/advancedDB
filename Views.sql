--1. Write a Create View statement that defines a view named InvoiceBasic that returns three columns: 
--VendorName, InvoiceNumber, and InvoiceTotal. Then, write a SELECT statement that returns all of the 
--columns in the view, sorted by VendorName, where the first letter of the vendor name is N, O, or P.

GO

CREATE VIEW InvoiceBasic
AS
SELECT VendorName
		,InvoiceNumber
		,InvoiceTotal
FROM  Vendors 
	JOIN Invoices ON 
	Vendors.VendorID = Invoices.VendorID;
GO
SELECT *
FROM InvoiceBasic
WHERE VendorName LIKE '[N-P]%'
ORDER BY VendorName;




--2. Create a view named Top10PaidInvoices that returns three columns for each vendor: VendorName,
-- LastInvoice (the most recent invoice date), and SumOfInvoices (the sum of the InvoiceTotal column). 
-- Return only the 10 vendors with the largest SumOfInvoices and include only paid invoices. *Paid invoices do not have a balance due.

GO
CREATE VIEW Top10PaidInvoices
AS
SELECT TOP 10 VendorName,
       MAX(InvoiceDate) AS LastInvoice,
       SUM(InvoiceTotal) AS SumOfInvoices
FROM  Vendors JOIN Invoices
  ON Vendors.VendorID = Invoices.VendorID
WHERE InvoiceTotal - CreditTotal - PaymentTotal = 0
GROUP BY VendorName
ORDER BY SUM(InvoiceTotal) DESC;




--3. Create an updatable view named VendorAddress that returns the VendorID, both address columns, and the city, state, 
--and zip code columns for each vendor. Then, write a SELECT query to examine the result set where VendorID = 4. Next, 
--write an UPDATE statement that changes the address so that the suite number (Ste 260) is stored in the VendorAddress2
-- rather than in the VendorAddress1. To verify the change, rerun your SELECT query.

GO
CREATE VIEW VendorAddress
AS
SELECT VendorID
		,VendorAddress1
		,VendorAddress2
		,VendorCity
		,VendorState
		,VendorZipCode
FROM Vendors;
GO
SELECT *
FROM VendorAddress
WHERE VendorID = 4;
UPDATE VendorAddress
SET VendorAddress1 = '1990 Westwood Blvd',
    VendorAddress2 = 'Ste 260'
WHERE VendorID = 4;




--4. Modify (using ALTER VIEW) the InvoiceBasic view created in exercise 1 to get the first 10 vendors sorted by VendorName is ascending order.

GO

ALTER VIEW InvoiceBasic
AS
SELECT TOP 10 VendorName 
FROM Vendors
GO
SELECT *
FROM InvoiceBasic
ORDER BY VendorName ASC



--5. Given the following view, add column alias's for each column WITHOUT modifying the SELECT clause. 
--(You will need to refer to the textbook for this one, or the official docs)

GO
CREATE VIEW InvoiceInfo
AS
SELECT VendorName
,VendorCity + ', ' + VendorState
,InvoiceTotal - PaymentTotal - CreditTotal
FROM Vendors JOIN Invoices ON
Vendors.VendorID = Invoices.VendorID

GO






