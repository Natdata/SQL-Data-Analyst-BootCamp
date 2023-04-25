/*Korzystaj¹c z tabeli Products zaprojektuj zapytanie, które zwróci œredni¹ jednostkow¹ cenê wszystkich
produktów. Wynik zaokr¹glij do dwóch miejsc po przecinku.*/

select round(avg([UnitPrice]),2)
from Products

/*Korzystaj¹c z tabel Products oraz Categories, zaprojektuj zapytanie, które zwróci nazwê kategorii oraz
œredni¹ jednostkow¹ cenê produktów w danej kategorii. Œredni¹ zaokr¹glij do dwóch miejsc po
przecinku. Wynik posortuj alfabetycznie po nazwie kategorii*/

select c.CategoryName, 
round(avg(p.UnitPrice),2) as average_price
from Products p left join Categories c on p.CategoryID=c.CategoryID
group by c.CategoryName
order by c.CategoryName

/*Korzystaj¹c z tabel Products oraz Categories zaprojektuj zapytanie, które zwróci wszystkie produkty
(ProductName) wraz z kategoriami, do których nale¿¹ (CategoryName) oraz œredni¹ jednostkow¹ cenê
dla wszystkich produktów. Analiza powinna obejmowaæ produkty ze wszystkich kategorii z wyj¹tkiem
Beverages. Wynik posortuj alfabetycznie po nazwie produktu*/

select p.ProductName, c.CategoryName, 
round(avg(p.UnitPrice) over(),2) as average_price
from Products p left join Categories c on p.CategoryID=c.CategoryID 
Where c.CategoryName <> 'Beverages'
order by p.ProductName

/*Rozbuduj poprzednie zapytanie o minimaln¹ i maksymaln¹ jednostkow¹ cenê dla wszystkich
produktów. Tym razem interesuj¹ nas wszystkie produkty (usuñ ograniczenie na kategoriê).*/

select p.ProductName, c.CategoryName, 
round(avg(p.UnitPrice) over(),2) as average_price,
min(p.UnitPrice) over() as min_unitprice,
max(p.UnitPrice) over() as max_unitprice
from Products p left join Categories c on p.CategoryID=c.CategoryID 
order by p.ProductName

-- Rozbuduj poprzednie zapytanie o œredni¹ jednostkow¹ cenê w kategorii i dla danego dostawcy

select p.ProductName, c.CategoryName, 
round(avg(p.UnitPrice) over(),2) as average_price,
min(p.UnitPrice) over() as min_unitprice,
max(p.UnitPrice) over() as max_unitprice,
round(avg(p.UnitPrice) over(partition by p.CategoryID),2) as avg_by_cat,
round(avg(p.UnitPrice) over(partition by p.SupplierID),2) as avg_by_supplier
from Products p left join Categories c on p.CategoryID=c.CategoryID 
order by p.ProductName

/*Rozbuduj poprzednie zapytanie o liczbê produktów w danej kategorii*/

select p.ProductName, c.CategoryName, 
round(avg(p.UnitPrice) over(),2) as average_price,
min(p.UnitPrice) over() as min_unitprice,
max(p.UnitPrice) over() as max_unitprice,
round(avg(p.UnitPrice) over(partition by p.CategoryID),2) as avg_by_cat,
round(avg(p.UnitPrice) over(partition by p.SupplierID),2) as avg_by_supplier,
count(p.UnitPrice) over(partition by p.CategoryID) as product_count
from Products p left join Categories c on p.CategoryID=c.CategoryID 
order by p.ProductName


/*
Korzystaj¹c z tabeli Orders oraz Customers przygotuj zapytanie, które wyœwietli identyfikator
zamówienie (OrderID), nazwê klienta (CompanyName) oraz numer rekordu. Numeracja rekordów
powinna byæ zgodna z dat¹ zamówienia posortowan¹ rosn¹co. Wyniki posortuj zgodnie
z identyfikatorem zamówienia (rosn¹co)*/

select o.OrderID, c.CompanyName,
row_number() over (order by o.OrderDate) as row_number_by_date
from Orders o join Customers c on o.CustomerID=c.CustomerID
order by o.OrderID

/*
Zaktualizuj poprzednie zapytanie tak, aby wynik zosta³ posortowany w pierwszej kolejnoœci po nazwie
klienta (rosn¹ca), a w drugiej po dacie zamówienia (malej¹co).*/

select o.OrderID, c.CompanyName,
row_number() over (order by c.CompanyName, o.OrderDate desc) as row_number_by_date
from Orders o join Customers c on o.CustomerID=c.CustomerID
--order by o.OrderID