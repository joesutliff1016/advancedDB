


SELECT VendorName
FROM Vendors
WHERE VendorID IN
     (SELECT VendorID FROM Invoices)
ORDER BY VendorName;



SELECT InvoiceNumber
	,InvoiceTotal
FROM Invoices
WHERE PaymentTotal >
     (SELECT AVG(PaymentTotal)
FROM Invoices
WHERE PaymentTotal <> 0);



SELECT InvoiceNumber
	,InvoiceTotal
FROM Invoices
WHERE PaymentTotal > ALL
     (SELECT TOP 50 PERCENT PaymentTotal
FROM Invoices
WHERE PaymentTotal <> 0
ORDER BY PaymentTotal);


SELECT AccountNo
	,AccountDescription
FROM GLAccounts
WHERE NOT EXISTS
(SELECT *
FROM InvoiceLineItems
WHERE InvoiceLineItems.AccountNo = GLAccounts.AccountNo)
ORDER BY AccountNo;



SELECT VendorName
	,Invoices.InvoiceID
	,InvoiceSequence
	,InvoiceLineItemAmount
FROM Vendors JOIN Invoices 
ON Vendors.VendorID = Invoices.VendorID
JOIN InvoiceLineItems
ON Invoices.InvoiceID = InvoiceLineItems.InvoiceID
WHERE Invoices.InvoiceID IN
(SELECT InvoiceID
FROM InvoiceLineItems
WHERE InvoiceSequence > 1)
ORDER BY VendorName
	,Invoices.InvoiceID
	,InvoiceSequence;