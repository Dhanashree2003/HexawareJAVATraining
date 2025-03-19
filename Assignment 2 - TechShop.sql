create database techshop;
use techshop;

-- Task 1
-- create table customer

create table Customers (
    CustomerID int primary key auto_increment,
    Firstname varchar(50),
    Lastname varchar(50),
    Email varchar(100) unique,
    Phone varchar(20),
    Address text
);

-- cretae table product

create table Products (
    ProductID int primary key auto_increment,
    ProductName varchar(100),
    Description varchar(100),
    Price decimal(10,2)
);

-- create table Orders

create table Orders (
    OrderID int primary key auto_increment,
    CustomerID int,
    OrderDate date,
    TotalAmount decimal(10,2),
    foreign key (CustomerID) references Customers(CustomerID) on delete cascade
);

-- create table OrederDetails

create table OrderDetails (
    OrderDetailID int primary key auto_increment,
    OrderID int,
    ProductID int,
    Quantity int,
    foreign key (OrderID) references Orders(OrderID) on delete cascade,
    foreign key (ProductID) references Products(ProductID) on delete cascade
);

-- create table Inventory

create table Inventory (
    InventoryID int primary key auto_increment,
    ProductID int,
    QuantityInStock int,
    LastStockUpdate date,
    foreign key (ProductID) references Products(ProductID) on delete cascade
);


-- insert values in Customers Table
insert into Customers (FirstName, LastName, Email, Phone, Address) values
('Arun', 'Kumar', 'arun.kumar@gmail.com', '9876543210', '12, Gandhi Street, Chennai'),
('Divya', 'Raj', 'divya.raj@gmail.com', '8765432109', '25, Anna Nagar, Madurai'),
('Mohan', 'Babu', 'mohan.babu@gmail.com', '9988776655', '8, Karthik Street, Coimbatore'),
('Priya', 'Venkat', 'priya.venkat@gmail.com', '9871234567', '18, Meenakshi Road, Trichy'),
('Ravi', 'Shankar', 'ravi.shankar@gmail.com', '9765432108', '22, Rajaji Street, Salem'),
('Keerthi', 'Ram', 'keerthi.ram@gmail.com', '9543216789', '14, Periyar Nagar, Vellore'),
('Suresh', 'Gopal', 'suresh.gopal@gmail.com', '9123456780', '30, Nehru Street, Tirunelveli'),
('Lakshmi', 'Narayan', 'lakshmi.narayan@gmail.com', '9234567891', '5, Kannagi Nagar, Erode'),
('Manoj', 'Dev', 'manoj.dev@gmail.com', '9345678902', '16, Chola Street, Thanjavur'),
('Anitha', 'Murthy', 'anitha.murthy@gmail.com', '9456789013', '40, Raman Nagar, Pondicherry');

-- insert values in Products Table
insert into Products (ProductName, Description, Price) values
('Smartwatch', 'Advanced fitness tracking Smartwatch', 5000.00),
('PC', 'High-performance Personal Computer', 45000.00),
('Electronic Vehicle',  'Eco-friendly Electric Vehicle with fast charging', 800000.00),
('Mobile', 'Latest Smartphone with AI Camera', 30000.00),
('Earbuds', 'Noise-canceling Wireless Earbuds', 2500.00),
('Printer',  'Multifunctional Wireless Printer', 15000.00),
('Washing Machine',  'Automatic Washing Machine with Inverter Technology', 30000.00),
('Fridge',  'Double-door Refrigerator with Cooling Technology', 40000.00),
('TV', '4K UHD Smart TV with Voice Control', 55000.00),
('Monitor', '24-inch Full HD display for work and gaming', 15000.00);

-- insert values in Orders Table

insert into Orders (CustomerID,OrderDate, TotalAmount) values
(1, '2024-03-10', 2000.00),
(2, '2024-03-12', 850.00),
(3, '2024-03-15', 1200.00),
(4, '2024-03-18', 600.00),
(5, '2024-03-20', 150.00),
(6, '2024-03-22', 100.00),
(7, '2024-03-25', 80.00),
(8, '2024-03-27', 250.00),
(9, '2024-03-30', 120.00),
(10, '2024-04-01', 400.00);

-- insert values in OrderDetails Table

insert into OrderDetails (OrderID, ProductID, Quantity) values
(1, 1, 1),
(1, 2, 1),
(2, 3, 1),
(2, 4, 1),
(3, 5, 2),
(3, 6, 1),
(4, 7, 1),
(5, 8, 1),
(6, 9, 2),
(7, 10, 1);

-- insert values in Inventory Table

insert into Inventory (ProductID, QuantityInStock, LastStockUpdate) values
(1, 50, '2024-03-05'),
(2, 40, '2024-03-06'),
(3, 30, '2024-03-07'),
(4, 20, '2024-03-08'),
(5, 60, '2024-03-09'),
(6, 25, '2024-03-10'),
(7, 15, '2024-03-11'),
(8, 10, '2024-03-12'),
(9, 35, '2024-03-13'),
(10, 45, '2024-03-14');

-- Tasks 2: Select, Where, Between, AND, LIKE:
-- 1. Retrieve the names and emails of all customers
select Firstname, Lastname, Email from Customers;

-- 2. List all orders with their order dates and corresponding customer names
select o.OrderID, o.OrderDate, c.Firstname, c.Lastname 
from Orders o 
join Customers c on o.CustomerID = c.CustomerID;

-- 3. Insert a new customer record into the "Customers" table
insert into Customers (Firstname, Lastname, Email, Phone, Address) 
values ('Kiran', 'Rao', 'kiran@gmail.com', '9876543211', '50, Park Street, Bangalore');

select *from orders;
-- 4. Update the prices of all electronic gadgets in the "Products" table by increasing them by 10%
update Products 
set Price = Price * 1.10 
where ProductName in ('Smartwatch', 'PC', 'Mobile', 'Earbuds', 'Printer', 'Monitor', 'TV');

-- 5. Delete a specific order and its associated order details from the "Orders" and "OrderDetails" tables
delete from OrderDetails where OrderID = 10;
delete from Orders where OrderID = 10;

-- 6. Insert a new order into the "Orders" table
insert into Orders (CustomerID, OrderDate, TotalAmount) 
values (15, '2025-03-19', 3000);

select * from customers;
-- 7. Update the contact information of a specific customer
update Customers 
set Email = 'john12@gmail.com', 
    Phone = 9863424578, 
    Address = '65, Cross cut Street, Chennai' 
where CustomerID = 12;

-- 8. Recalculate and update the total cost of each order
update Orders o
set TotalAmount = (
    select sum(od.Quantity * p.Price) 
    from OrderDetails od
    join Products p on od.ProductID = p.ProductID
    where od.OrderID = o.OrderID
);

-- 9. Delete all orders and their associated order details for a specific customer
delete from OrderDetails where OrderID in (select OrderID from Orders where CustomerID = 3);
delete from Orders where CustomerID = 3;

-- 10. Insert a new electronic gadget product into the "Products" table
insert into Products (ProductName, Description, Price) 
values ('Gaming Laptop', 'High-end laptop with dedicated GPU', 120000.00);

-- 11. Update the status of a specific order in the "Orders" table
update Orders 
set TotalAmount = 3500 
where OrderID = 5;

-- 12. Calculate and update the number of orders placed by each customer in the "Customers" table
alter table Customers add column TotalOrders int default 0;

update Customers c
set TotalOrders = (
    select count(o.OrderID) 
    from Orders o 
    where o.CustomerID = c.CustomerID
);

-- Task 3. Aggregate functions, Having, Order By, GroupBy and Joins:

-- 1. Retrieve a list of all orders along with customer information
select o.OrderID, o.OrderDate, c.Firstname, c.Lastname, c.Email, c.Phone 
from Orders o 
join Customers c on o.CustomerID = c.CustomerID;

-- 2. Find the total revenue generated by each electronic gadget product
select p.ProductName, sum(od.Quantity * p.Price) as TotalRevenue
from OrderDetails od 
join Products p on od.ProductID = p.ProductID
where p.ProductName = 'Electronic Vehicle'
group by p.ProductName;

-- 3. List all customers who have made at least one purchase
select distinct c.CustomerID, c.Firstname, c.Lastname, c.Email, c.Phone 
from Customers c 
join Orders o on c.CustomerID = o.CustomerID;

-- 4. Find the most popular electronic gadget (highest total quantity ordered)
select p.ProductName, sum(od.Quantity) as TotalQuantityOrdered
from OrderDetails od 
join Products p on od.ProductID = p.ProductID
group by p.ProductName
order by TotalQuantityOrdered desc
limit 1;

-- 5. Retrieve a list of electronic gadgets along with their corresponding categories
select ProductName, Description from Products;

-- 6. Calculate the average order value for each customer
select c.CustomerID, c.Firstname, c.Lastname, avg(o.TotalAmount) as AvgOrderValue
from Customers c 
join Orders o on c.CustomerID = o.CustomerID
group by c.CustomerID, c.Firstname, c.Lastname;

-- 7. Find the order with the highest total revenue
select o.OrderID, c.Firstname, c.Lastname, o.TotalAmount
from Orders o 
join Customers c on o.CustomerID = c.CustomerID
order by o.TotalAmount desc
limit 1;

-- 8. List electronic gadgets and the number of times each product has been ordered
select p.ProductName, count(od.OrderID) as OrderCount
from OrderDetails od 
join Products p on od.ProductID = p.ProductID
group by p.ProductName
order by OrderCount desc;

-- 9. Find customers who have purchased a specific electronic gadget
select distinct c.CustomerID, c.Firstname, c.Lastname, c.Email, c.Phone
from Customers c 
join Orders o on c.CustomerID = o.CustomerID
join OrderDetails od on o.OrderID = od.OrderID
join Products p on od.ProductID = p.ProductID
where p.ProductName = 'Monitor';
select * from orders;


-- 10. Calculate the total revenue generated by all orders placed within a specific time period
select sum(od.Quantity * p.Price) as TotalRevenue
from Orders o
join OrderDetails od on o.OrderID = od.OrderID
join Products p on od.ProductID = p.ProductID
where o.OrderDate between '2024-01-01' and '2024-12-31';

-- Task 4 : Subquery and its type:

-- 1. Find customers who have not placed any orders.
select CustomerID, FirstName, LastName  
from Customers  
where CustomerID not in (select distinct CustomerID from Orders);

-- 2. Find the total number of products available for sale.
select count(*) as TotalProducts  
from Products;

-- 3. Calculate the total revenue generated by TechShop.
select sum(od.Quantity * p.Price) as TotalRevenue  
from OrderDetails od  
join Products p on od.ProductID = p.ProductID;

-- 4. Calculate the average quantity ordered for products in a specific category.
select avg(od.Quantity) as AvgQuantityOrdered  
from OrderDetails od  
join Products p on od.ProductID = p.ProductID  
where p.productName = 'electronic vehicle';

-- 5. Calculate the total revenue generated by a specific customer.
select sum(od.Quantity * p.Price) as CustomerTotalRevenue  
from Orders o  
join OrderDetails od on o.OrderID = od.OrderID  
join Products p on od.ProductID = p.ProductID  
where o.CustomerID = 5;

-- 6. Find the customers who have placed the most orders.
select c.CustomerID, c.FirstName, c.LastName, count(o.OrderID) as OrderCount  
from Customers c  
join Orders o on c.CustomerID = o.CustomerID  
group by c.CustomerID, c.FirstName, c.LastName  
order by OrderCount desc  
limit 1;

-- 7. Find the most popular product category based on total quantity ordered.
select p.ProductName, sum(od.Quantity) as TotalQuantityOrdered  
from OrderDetails od  
join Products p on od.ProductID = p.ProductID  
group by p.ProductName  
order by TotalQuantityOrdered desc  
limit 1;

-- 8. Find the customer who has spent the most money.
select c.CustomerID, c.FirstName, c.LastName, sum(od.Quantity * p.Price) as TotalSpending  
from Customers c  
join Orders o on c.CustomerID = o.CustomerID  
join OrderDetails od on o.OrderID = od.OrderID  
join Products p on od.ProductID = p.ProductID  
group by c.CustomerID, c.FirstName, c.LastName  
order by TotalSpending desc  
limit 1;

-- 9. Calculate the average order value for all customers.
select avg(OrderTotal) as AvgOrderValue  
from (  
    select o.OrderID, sum(od.Quantity * p.Price) as OrderTotal  
    from Orders o  
    join OrderDetails od on o.OrderID = od.OrderID  
    join Products p on od.ProductID = p.ProductID  
    group by o.OrderID  
) as OrderSummary;

-- 10. Find the total number of orders placed by each customer.
select c.CustomerID, c.FirstName, c.LastName, count(o.OrderID) as TotalOrders  
from Customers c  
left join Orders o on c.CustomerID = o.CustomerID  
group by c.CustomerID, c.FirstName, c.LastName  
order by TotalOrders desc;



