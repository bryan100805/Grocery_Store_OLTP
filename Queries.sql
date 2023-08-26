--part(i)
SELECT cu.Cust_Name, s.Store_ID, s.Address as 'Store Address',
er.Employee_Name as 'Manager of the Store', ch.Trans_Date as 'Transaction Date', it.Brand, 
it.Item_Description, t.Quantity as 'Quantity Purchased', e.Employee_Name as 'Served By'
FROM Customer cu, Checkout ch, Store s, Trans t, Item_Info it, Employee e, Employee er
WHERE cu.Cust_ID = ch.Cust_ID AND ch.Store_ID = s.Store_ID AND s.Store_ID = e.Store_ID  
AND ch.Checkout_ID = t.Checkout_ID AND it.Item_ID=t.Item_ID AND s.Manager = er.Employee_ID 
AND ch.Employee_ID = e.Employee_ID
ORDER BY 1, 6

--part(ii)
SELECT s.Manager as 'Store Manage ID', e.Employee_Name as 'Name of Manager', 
s.Store_ID as 'Store managed', it.Item_ID as 'Item', i.Quantity as 'Quantity on inventory'
FROM Employee e, Store s, Inventory i, Item_Info it
WHERE s.Manager = e.Employee_ID AND i.Store_ID = s.Store_ID AND it.Item_ID = i.Item_ID
ORDER BY 3, 4 DESC

--part(iii)
SELECT c.Cust_Name as 'Customer Name', COUNT(t.Quantity) as 'Number of Items Bought'
FROM Customer c, Checkout ch, Trans t
WHERE c.Cust_ID = ch.Cust_ID AND ch.Checkout_ID = t.Checkout_ID
GROUP BY t.Checkout_ID, c.Cust_Name
HAVING COUNT(t.Quantity)<=2
ORDER BY 1

--part(iv)
SELECT it.Item_ID, it.Item_Description, SUM(it.Price * i.Quantity ) as 'Retail', SUM(it.Cost * i.Quantity) as 'Wholesale'
FROM Item_Info it, Inventory i
WHERE it.Item_ID = i.Item_ID 
GROUP BY it.Item_ID, it.Item_Description
HAVING COUNT(i.Store_ID) >= 2
ORDER BY 1

--part(v)
SELECT e.Employee_ID as 'Employee ID', e.Employee_Name as 'Employee Name', e.Manager as 'Manager ID', er.Employee_Name as 'Manager Name'
FROM Employee e, Employee er
WHERE er.Employee_ID = e.Manager
ORDER BY 1,3

--part(vi)
SELECT e.Employee_ID, e.Employee_Name, er.Employee_ID, er.Employee_Name, s.Store_ID, s.Address
FROM Employee e, Employee er, Store s
WHERE e.Store_ID = s.Store_ID AND er.Store_ID = e.Store_ID AND er.Employee_ID = e.Manager AND er.Manager IS NULL