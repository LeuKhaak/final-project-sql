create view other_clients as
select cl.title, c.city, p.order_type, sum(i.invoice_sum) as INV_SUM, count(i.id) as INV_COUNT
from invoices i
INNER JOIN clients cl ON i.client_id = cl.id
INNER JOIN cities c ON cl.city = c.id
INNER JOIN payment_orders p ON cl.payment_order = p.id
group by cl.title, c.city, p.order_type having count(i.id) < 6 or sum(i.invoice_sum) < 4001
order by INV_SUM desc;

select * from other_clients;

create view good_clients as
select cl.title, c.city, p.order_type,
sum(case when i.invoice_date between to_date('2017-12-31', 'yyyy-mm-dd') and to_date('2019-01-01', 'yyyy-mm-dd')
then i.invoice_sum else 0 end) as INV_SUM_18,
count(case when i.invoice_date between to_date('2017-12-31', 'yyyy-mm-dd') and to_date('2019-01-01', 'yyyy-mm-dd')
then i.id else null end) as INV_COUNT_18,
sum(case when i.invoice_date between to_date('2018-12-31', 'yyyy-mm-dd') and to_date('2020-01-01', 'yyyy-mm-dd')
then i.invoice_sum else 0 end) as INV_SUM_19,
count(case when i.invoice_date between to_date('2018-12-31', 'yyyy-mm-dd') and to_date('2020-01-01', 'yyyy-mm-dd')
then i.id else null end) as INV_COUNT_19
from invoices i
INNER JOIN clients cl ON i.client_id = cl.id
INNER JOIN cities c ON cl.city = c.id
INNER JOIN payment_orders p ON cl.payment_order = p.id
group by cl.title, c.city, p.order_type having count(i.id) > 5 and sum(i.invoice_sum) > 4000
order by INV_SUM_18 desc;

select * from good_clients;