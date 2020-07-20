SELECT *
FROM Production.Product
WHERE Size > '50' AND 
DaysToManufacture > '1'
AND Color LIKE '[red
				,yellow]%'
 

SELECT * 
FROM Production.Product
WHERE WeightUnitMeasureCode IS NULL


SELECT * 
FROM Person.Person
WHERE FirstName = 'Alex' AND
SUBSTRING(LastName,1,1) LIKE '[a,e,i,o,u]%'



SELECT *
FROM HumanResources.Employee
WHERE JobTitle LIKE 'Design Engineer%'
AND YEAR(BirthDate) BETWEEN '1965' AND '1975'
OR JobTitle LIKE 'Senior Design Engineer%'
AND YEAR(BirthDate) BETWEEN '1965' AND '1975'
OR JobTitle LIKE 'Research and Development Engineer%'
AND YEAR(BirthDate) BETWEEN '1965' AND '1975'
OR JobTitle LIKE 'Engineering Manager%'
AND YEAR(BirthDate) BETWEEN '1965' AND '1975'
OR JobTitle LIKE 'Vice President of Engineering%'
AND YEAR(BirthDate) BETWEEN '1965' AND '1975'
OR JobTitle LIKE 'Engineering Manager%'
AND YEAR(BirthDate) BETWEEN '1965' AND '1975'
OR JobTitle LIKE 'Production Technician%'
AND YEAR(BirthDate) BETWEEN '1965' AND '1975'
OR JobTitle LIKE 'Quality Assurance Technician%'
AND YEAR(BirthDate) BETWEEN '1965' AND '1975'




SELECT * 
FROM Production.ProductPhoto
WHERE DATEPART(YEAR, ModifiedDate) BETWEEN '2011' AND '2013'
ORDER BY ModifiedDate DESC


SELECT *
FROM HumanResources.Employee
WHERE DATEPART(MONTH, HireDate) BETWEEN '06' AND '08'
