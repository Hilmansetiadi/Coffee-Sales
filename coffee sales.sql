create database coffee;

select * from sales limit 10;
select * from Menu limit 10;
select * from product_info limit 10;

select * from master_ limit 20;

select 
	coffee_name,
    Count(coffee_name) as Terjual
from menu
group by coffee_name
order by Terjual DESC;

select
    coffee_name,
    count(coffee_name) as Terjual,
    sum(money) as Revenue
from sales
group by coffee_name
order by Terjual DESC;

select
	coffee_name, 
	hour(datetime) as jam,
    count(*) as Jumlah_Transaksi,
    sum(money) as Revenue
from sales
group by coffee_name, jam
order by Revenue DESC;

select
	dayname(datetime) as Hari,
    count(*) as Terjual,
    sum(money) as Revenue
from sales
group by Hari
order by Revenue DESC;

select
	card,
    count(*) as Frekuensi_Beli
from sales
where cash_type = 'Card'
group by card
having frekuensi_beli > 1
order by frekuensi_beli DESC;

SELECT 
    s.coffee_name,
    COUNT(s.coffee_name) AS Transaksi_Sales,
    COUNT(m.coffee_name) AS Transaksi_Menu,
    SUM(s.money) AS Total_Revenue
FROM sales s
JOIN menu m ON s.datetime = m.datetime AND s.coffee_name = m.coffee_name
GROUP BY s.coffee_name
ORDER BY Total_Revenue DESC;

SELECT 
    s.coffee_name,
    COUNT(*) AS Terjual,
    SUM(s.money) AS Revenue,
    SUM(p.cost_per_cup) AS Total_Cost,
    SUM(s.money) - SUM(p.cost_per_cup) AS Profit
FROM sales s
JOIN menu m ON s.coffee_name = m.coffee_name
GROUP BY s.coffee_name;

create table product_info (
	coffee_name VARCHAR(50),
    cost_per_cup DECIMAL(10,2)
);

INSERT INTO product_info (coffee_name, cost_per_cup) Values
('Espresso', 10.0),
('Latte', 15.0),
('Americano', 12.0),
('Americano with Milk', 15.0),
('Hot Chocolate', 18.0),
('Cocoa', 15.0),
('Tea', 8.0),
('Chocolate With Milk', 16.0);

select
	s.coffee_name,
    count(*) as Terjual,
    sum(s.money) as Revenue,
    sum(p.cost_per_cup) as Cost,
    sum(s.money) - sum(p.cost_per_cup) as Net_Profit
from sales s
join product_info p on s.coffee_name = p.coffee_name
group by s.coffee_name
order by Net_Profit DESC;

SELECT 
    s.coffee_name,
    COUNT(DISTINCT s.datetime) AS Transaksi_Sales,
    COUNT(DISTINCT m.datetime) AS Transaksi_Menu,
    SUM(s.money) AS Total_Revenue
FROM sales s
JOIN menu m ON s.coffee_name = m.coffee_name
GROUP BY s.coffee_name
ORDER BY Total_Revenue DESC;

SELECT 
    s.coffee_name,
    DATE(s.datetime) AS Tanggal,
    COUNT(s.coffee_name) AS Jml_Sales
FROM sales s
JOIN menu m ON s.coffee_name = m.coffee_name 
    AND DATE(s.datetime) = DATE(m.datetime) -- Mencocokkan hari yang sama
GROUP BY s.coffee_name, Tanggal;

select
	dayname(datetime) as Hari,
    hour(datetime) as Jam,
    count(*) as Total_transaksi,
    sum(s.money) as Revenue,
    sum(p.cost_per_cup) as Cost,
    (sum(s.money) - sum(p.cost_per_cup)) as Profit
from sales s 
join product_info p on s.coffee_name = p.coffee_name
Group by Hari, Jam
Order by Profit DESC;

create or replace view Master_ as 
select
	s.datetime as Time_Stamp,
    month(s.datetime) as month,
    Date(s.datetime) as date_only,
    dayname(s.datetime) as day_name,
    hour(s.datetime) as sales_hour,
    s.coffee_name,
    s.cash_type,
    s.card as card_id,
    s.money as gross_revenue,
    p.cost_per_cup as cost,
    (s.money - p.cost_per_cup) as profit,
    round(((s.money - cost_per_cup) /s.money) * 100, 2) as profit_margin
from sales s
join product_info p on s.coffee_name = p.coffee_name;
    


    

	