-- Interview questions

--moving/rolling average or sum 

with order_amount
as
(select o.orderID, o.OrderDate, sum(od.UnitPrice*od.Quantity) as order_amount
from [dbo].[Orders] o
left join [dbo].[Order Details] od on o.orderID = od.orderID
group by o.orderID, o.OrderDate)
select orderID, convert(varchar(10), OrderDate, 103) as order_date, order_amount,
--7 days moving sum
sum(order_amount) over(order by OrderDate rows between 2 preceding and current row) as moving_sum,
--7 days moving average
round(avg(order_amount) over(order by OrderDate rows between 2 preceding and current row),2) as moving_avg
from order_amount
where year(OrderDate) = 1997 and month(OrderDate) = 12

-- YTD year to date - wa¿ne jest, ¿eby zastosowaæ tu okno unbounded preceding and current row, poniewa¿ bez tego wartoœci
--o tej samej dacie zostan¹ pominiête i nie wliczone w sumê
-- partition by year(orderdate) powoduje, ¿e nowy rok zlicza siê od nowa
-- MTD month to date - wystarczy dodaæ partition by year(orderdate), month(orderdate) 

with order_amount
as
(
select o.orderID, cast(o.OrderDate as date) as OrderDate, sum(od.UnitPrice*od.Quantity) as order_amount
from [dbo].[Orders] o
left join [dbo].[Order Details] od on o.orderID = od.orderID
group by o.orderID, o.OrderDate
)
select orderID, OrderDate, order_amount,
sum(order_amount) over(partition by year(OrderDate) order by OrderDate) as YTD_Ÿle_liczony, -- tu widaæ, ¿e nie zlicza wartoœci z tê sam¹ dat¹!!!
sum(order_amount) over(partition by year(OrderDate) order by OrderDate rows between unbounded preceding and current row) as YTD_frame,
sum(order_amount) over(partition by year(OrderDate), month(OrderDate) order by OrderDate rows between unbounded preceding and current row) as MTD_frame
from order_amount

-- Last and First value


with order_amount
as
(
select o.orderID, cast(o.OrderDate as date) as OrderDate, sum(od.UnitPrice*od.Quantity) as order_amount
from [dbo].[Orders] o
left join [dbo].[Order Details] od on o.orderID = od.orderID
group by o.orderID, o.OrderDate
)
select orderID, OrderDate, order_amount,
sum(order_amount) over(partition by year(OrderDate) order by OrderDate) as YTD_Ÿle_liczony, -- tu widaæ, ¿e nie zlicza wartoœci z tê sam¹ dat¹!!!
sum(order_amount) over(partition by year(OrderDate) order by OrderDate 
rows between unbounded preceding and current row) as YTD_frame,
sum(order_amount) over(partition by year(OrderDate), month(OrderDate) order by OrderDate 
rows between unbounded preceding and current row) as MTD_frame,
FIRST_VALUE(orderID) over(partition by year(OrderDate) order by OrderDate) as first_order_no,--nie trzeba dodaæ frame
Last_VALUE(orderID) over(partition by year(OrderDate) order by OrderDate) as last_order_wrong, -- tak nie zadzia³a poprawnie, trzeba dodaæ frame
Last_VALUE(orderID) over(partition by year(OrderDate) order by OrderDate
rows between current row and unbounded following) as last_order_no_correct
from order_amount



