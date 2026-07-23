drop table if exists books;

create table books(
	book_id serial primary key,
	title varchar(100),
	author varchar(100),
	genre varchar(50),
	published_year int,
	price	numeric(10,2),
	stock int
	
);

select * from books;


create table customers(
		customer_id serial primary key,
		name varchar(100),
		email varchar(100),
		phone varchar(15),
		city varchar(50),
		country varchar(50)
);

select * from customers;

create table orders(
	order_id serial primary key,
	customer_id int references customers(customer_id),
	book_id int references books(book_id),
	order_date date ,
	quantity int
);

alter table customers
alter column country type varchar(100);

alter table orders
add column total_amount decimal(10,2);

alter table orders
drop column amount;


select * from orders;
select * from  books;
select *from customers;

copy books(Book_ID,	Title,	Author,	Genre,	Published_Year,	Price,	Stock)
from 'C:\SQL\Books.csv'
csv header;

copy customers(Customer_ID,	Name,	Email,	Phone,	City,	Country)
from 'C:\SQL\Customers.csv'
csv header;


copy orders(Order_ID,	Customer_ID,	Book_ID,	Order_Date,	Quantity,	Total_Amount)
from 'C:\SQL\Orders.csv'
csv header;
 truncate table orders;


 --1.retrive all boks in the "fiction genre"

 select * from books 
 where genre='Fiction'

 --2.find books publishes after the year 1950
 select * from books
 where published_year> 1950;

 --3.list all the customers from canada
select * from customers
 where  country='Canada';

 --4.show oreder place in nov 2023 
 select * from orders
 where order_date between '2023-11-01' and '2023-11-30';


--5.retriove the tool stock of books availabe
select sum (stock) as total_stock
from books;


 --6.find the detail of most expensive book
 select * from books
 order by price
 desc limit 1;


--7.show all the customer  who ordered more more tyhan 1 quantity of book
select * from orders
where quantity>1;

--8.retrive all order where the total amount exceed $20
select * from orders
where total_amount>20;


--9.list all genre available in books tavble
select distinct genre from books;


--10.find the book with the lowest stock
select * from books
order by stock asc
limit 1;


--11.calculate the total revenue genrated from all order

SELECT SUM(total_amount) AS REVENUE
FROM orders;

--Advanced questions

--1. retrive the total numer of books sold for each genre
SELECT * FROM orders;

SELECT b.genre , SUM(o.quantity) AS total_book_sold
FROM orders o
JOIN books b ON o.book_id=b.book_id
GROUP BY b.genre;

--2. find the average price of book in the "Fantasy" genre
SELECT AVG(Price) AS average_price
FROM books
WHERE genre= 'Fantasy';

--3. list customer who have placed at least 2 orders
SELECT o.customer_id , c.name ,COUNT(o.order_id) AS order_count
FROM orders o
JOIN customers c ON o.customer_id =c.customer_id
GROUP BY o.customer_id, c.name
HAVING COUNT(order_id)>=2;

--4. find the most frequently order books
SELECT o.book_id ,b.title, COUNT(o.order_id) AS order_count
FROM orders o
JOIN books b ON o.book_id=b.book_id
GROUP BY o.book_id, b.title
ORDER BY order_count DESC LIMIT 1;

--5 show the top 3 most expensive boloks of "Fantasy" genre
SELECT * FROM books
WHERE genre='Fantasy'
ORDER BY price DESC LIMIT 3;


--6 retrive the total quantity of books sold by each author
SELECT b.author , SUM(o.quantity) AS total_book_sold
FROM orders o
JOIN books b ON o.book_id=b.book_id
GROUP BY b.author;

--7 list the city where customers who spent over $30 are loated
SELECT DISTINCT c.city, total_amount
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.total_amount>30;


--8 find the customer who spent the most on orders
SELECT c.customer_id, c.name,SUM(o.total_amount) AS total_spent
FROM orders o
JOIN customers c ON  o.customer_id= c.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_spent DESC;


--9 calculate the stock remaining after fulfilling all orders
SELECT b.book_id, b.title, b.stock , COALESCE(SUM(quantity),0) AS order_quantity,
			b.stock- COALESCE(SUM(o.quantity),0) AS remaining_quantity
FROM books b
LEFT JOIN orders o ON b.book_id=o.book_id
GROUP BY b.book_id ORDER BY b.book_id ;

































































































 
 


 


























