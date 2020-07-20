DECLARE @test varchar(30)
SET @test = ' joe '
PRINT @test

SET @test = REPLACE(@test, ' ', '')
print @test


SET @test = RTRIM(LTRIM(@test))
print @test

----remove trailing white space
--SET @test = RTRIM(@test)
--print @test
----remove leading white space
--SET @test = LTRIM(@test)
--print @test



--CPW210_AP database
SELECT *
FROM Vendors
WHERE LEFT(VendorPhone, 5) =
	'(559)'

SELECT *
FROM Vendors	
WHERE VendorPhone LIKE '(559%'


SELECT *
FROM Vendors
WHERE SUBSTRING(VendorPhone, 2, 3) 
	= '559'

print SUBSTRING('(253) 589-5580', 2, 3)



print 'your order will ship ' 
--print GETDATE() + 5
print DATEADD(dd, 120, GETDATE())


--check if sat or sun--

print DATENAME(weekday, GETDATE())
print DATEPART(weekday, GETDATE())

DECLARE @currDay varchar(15)
SET @currDay = DATENAME(weekday, GETDATE()+3)

IF @currDay = 'Saturday' OR
	@currDay = 'Sunday'

BEGIN
	print 'It is the weekend, allow extra day for processing'
END
ELSE 

	print 'Normal processing time'



print DATEDIFF(HOUR, '7/5/2017'
	, '7/5/2017 10:23')

print YEAR(GETDATE())
print DATENAME(YEAR, GETDATE())

--all invoices that fall on a friday--
SELECT *
FROM Invoices
WHERE DATENAME(WEEKDAY, InvoiceDate)
	= 'Friday'

SELECT COUNT(*)
FROM Invoices
WHERE DATENAME(WEEKDAY, InvoiceDate)
	= 'Friday'

SELECT VendorName
	,ISNULL(VendorAddress1, 'No Address')
	,ISNULL(VendorAddress2, 'No address')
FROM Vendors

print LEN('joe')
print LEN('     joe')
print LEN('     Joe     ')


-- switch to ADVWORKS2014

-- get all people and thier passwords

SELECT p.FirstName
		,pass.PasswordHash
		,pass.PasswordSalt
FROM Person.Person AS p JOIN
	Person.Password AS pass ON
	p.BusinessEntityID = 
	pass.BusinessEntityID

WHERE FirstName LIKE '[ABCE]%' AND
	LastName = 'Diaz'
ORDER BY FirstName DESC












