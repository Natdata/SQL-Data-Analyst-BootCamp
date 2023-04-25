/*Korzystaj�c z tabeli Products zaprojektuj zapytanie, kt�re zwr�ci �redni� jednostkow� cen� wszystkich
produkt�w. Wynik zaokr�glij do dw�ch miejsc po przecinku.*/

select round(avg([UnitPrice]),2)
from Products

/*Korzystaj�c z tabel Products oraz Categories, zaprojektuj zapytanie, kt�re zwr�ci nazw� kategorii oraz
�redni� jednostkow� cen� produkt�w w danej kategorii. �redni� zaokr�glij do dw�ch miejsc po
przecinku. Wynik posortuj alfabetycznie po nazwie kategorii*/

select c.CategoryName, 
round(avg(p.UnitPrice),2) as average_price
from Products p left join Categories c on p.CategoryID=c.CategoryID
group by c.CategoryName
order by c.CategoryName

/*Korzystaj�c z tabel Products oraz Categories zaprojektuj zapytanie, kt�re zwr�ci wszystkie produkty
(ProductName) wraz z kategoriami, do kt�rych nale�� (CategoryName) oraz �redni� jednostkow� cen�
dla wszystkich produkt�w. Analiza powinna obejmowa� produkty ze wszystkich kategorii z wyj�tkiem
Beverages. Wynik posortuj alfabetycznie po nazwie produktu*/

select p.ProductName, c.CategoryName, 
round(avg(p.UnitPrice) over(),2) as average_price
from Products p left join Categories c on p.CategoryID=c.CategoryID 
Where c.CategoryName <> 'Beverages'
order by p.ProductName

/*Rozbuduj poprzednie zapytanie o minimaln� i maksymaln� jednostkow� cen� dla wszystkich
produkt�w. Tym razem interesuj� nas wszystkie produkty (usu� ograniczenie na kategori�).*/

select p.ProductName, c.CategoryName, 
round(avg(p.UnitPrice) over(),2) as average_price,
min(p.UnitPrice) over() as min_unitprice,
max(p.UnitPrice) over() as max_unitprice
from Products p left join Categories c on p.CategoryID=c.CategoryID 
order by p.ProductName

-- Rozbuduj poprzednie zapytanie o �redni� jednostkow� cen� w kategorii i dla danego dostawcy

select p.ProductName, c.CategoryName, 
round(avg(p.UnitPrice) over(),2) as average_price,
min(p.UnitPrice) over() as min_unitprice,
max(p.UnitPrice) over() as max_unitprice,
round(avg(p.UnitPrice) over(partition by p.CategoryID),2) as avg_by_cat,
round(avg(p.UnitPrice) over(partition by p.SupplierID),2) as avg_by_supplier
from Products p left join Categories c on p.CategoryID=c.CategoryID 
order by p.ProductName

/*Rozbuduj poprzednie zapytanie o liczb� produkt�w w danej kategorii*/

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
Korzystaj�c z tabeli Orders oraz Customers przygotuj zapytanie, kt�re wy�wietli identyfikator
zam�wienie (OrderID), nazw� klienta (CompanyName) oraz numer rekordu. Numeracja rekord�w
powinna by� zgodna z dat� zam�wienia posortowan� rosn�co. Wyniki posortuj zgodnie
z identyfikatorem zam�wienia (rosn�co)*/

select o.OrderID, c.CompanyName,
row_number() over (order by o.OrderDate) as row_number_by_date
from Orders o join Customers c on o.CustomerID=c.CustomerID
order by o.OrderID

/*
Zaktualizuj poprzednie zapytanie tak, aby wynik zosta� posortowany w pierwszej kolejno�ci po nazwie
klienta (rosn�ca), a w drugiej po dacie zam�wienia (malej�co).*/

select o.OrderID, c.CompanyName,
row_number() over (order by c.CompanyName, o.OrderDate desc) as row_number_by_date
from Orders o join Customers c on o.CustomerID=c.CustomerID
--order by o.OrderID