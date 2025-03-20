
-- Task 1 : Database Design
-- create database
create database TicketBookingSystem;
use TicketBookingSystem;

-- create Venue table
create table Venue (
    Venue_id int primary key auto_increment,
    Venue_name varchar(255) not null,
    Address text not null
);

-- create Customer table
create table Customer (
    Customer_id int primary key auto_increment,
    Customer_name varchar(255) not null,
    Email varchar(255) unique not null,
    Phone_number varchar(15) unique not null,
    Booking_id int
);

-- create Event table
create table Event (
    Event_id int primary key auto_increment,
    Event_name varchar(255) not null,
    Event_date date not null,
    Event_time time not null,
    Venue_id int,
    Total_seats int not null,
    Available_seats int not null,
    Ticket_price decimal(10,2) not null,
    Event_type enum('Movie', 'Sports', 'Concert') not null,
    Booking_id int,
    foreign key (Venue_id) references Venue(Venue_id)
);

-- create Booking table
create table Booking (
    Booking_id int primary key auto_increment,
    Customer_id int,
    Event_id int,
    Num_tickets int not null,
    Total_cost decimal(10,2) not null,
    Booking_date datetime default current_timestamp,
    foreign key (Customer_id) references Customer(Customer_id),
    foreign key (Event_id) references Event(Event_id)
);

-- 1.Write a SQL query to insert at least 10 sample records into each table
-- Insert into Venue
insert into Venue (Venue_name, Address) values
('Wankhede Stadium', 'Mumbai, Maharashtra'),
('Eden Gardens', 'Kolkata, West Bengal'),
('Jawaharlal Nehru Stadium', 'Delhi, India'),
('Sardar Patel Stadium', 'Ahmedabad, Gujarat'),
('Chidambaram Stadium', 'Chennai, Tamil Nadu'),
('Bangalore Palace Grounds', 'Bengaluru, Karnataka'),
('Hyderabad Convention Center', 'Hyderabad, Telangana'),
('Sree Kanteerava Stadium', 'Bangalore, Karnataka'),
('Salt Lake Stadium', 'Kolkata, West Bengal'),
('India Habitat Centre', 'New Delhi, India');

-- Insert into Customer
insert into Customer (Customer_name, Email, Phone_number) values
('Rahul Sharma', 'rahul.s@gmail.com', '9876543210'),
('Priya Iyer', 'priya.i@gmail.com', '9988776655'),
('Amit Patel', 'amit@gmail.com', '9876123456'),
('Neha Singh', 'neha.s@gmail.com', '9998877665'),
('Rohit Verma', 'rohit.v@gmail.com', '9845123456'),
('Ananya Menon', 'ananya@gmail.com', '9955332211'),
('Vikram Reddy', 'vikram.r@gmail.com', '9988223366'),
('Sanya Kapoor', 'sanya.k@gamil.com', '9876778899'),
('Arjun Das', 'arjun@gmail.com', '9000000000'),
('Meera Nair', 'meera@gmail.com', '9822334455');

-- Insert into Event
insert into Event (Event_name, Event_date, Event_time, Venue_id, Total_seats, Available_seats, Ticket_price, Event_type) values
('IPL Finals', '2025-05-15', '19:30:00', 1, 50000, 5000, 2000.00, 'Sports'),
('Bollywood Concert', '2025-06-20', '20:00:00', 6, 8000, 600, 1500.00, 'Concert'),
('Cricket Match', '2025-07-10', '18:00:00', 2, 68000, 2000, 2500.00, 'Sports'),
('Comedy Show', '2025-08-05', '19:45:00', 10, 3000, 300, 1000.00, 'Movie'),
('Carnatic Music', '2025-09-12', '18:30:00', 5, 2500, 200, 1800.00, 'Concert'),
('Music Fest', '2025-10-01', '20:15:00', 7, 7000, 1000, 2200.00, 'Concert'),
('Kabaddi Finals', '2025-11-20', '18:00:00', 8, 25000, 5000, 1800.00, 'Sports'),
('Classical Dance Event', '2025-12-10', '19:00:00', 9, 1500, 150, 1200.00, 'Movie'),
('Yoga and Wellness Expo', '2025-04-25', '10:00:00', 3, 5000, 4500, 800.00, 'Movie'),
('Indie Rock Festival', '2025-05-30', '17:30:00', 4, 12000, 900, 1700.00, 'Concert');

-- Insert into Booking
insert into Booking (Customer_id, Event_id, Num_tickets, Total_cost) values
(1, 1, 3, 6000.00),
(2, 2, 2, 3000.00),
(3, 3, 5, 12500.00),
(4, 4, 1, 1000.00),
(5, 5, 2, 3600.00),
(6, 6, 3, 6600.00),
(7, 7, 4, 7200.00),
(8, 8, 5, 6000.00),
(9, 9, 1, 800.00),
(10, 10, 2, 3400.00);


-- 2. List all Events
select * from Event;

-- 3. Select events with available tickets
select * from Event where Available_seats > 0;

-- 4. Select events name partial match with ‘cup’
select * from Event where Event_name like '%dance%';

-- 5. Select events with ticket price between 1000 to 2500
select * from Event where Ticket_price between 1000 and 2500;

-- 6. Retrieve events with dates in a specific range
select * from Event where Event_date between '2025-06-01' and '2025-08-31';

-- 7. Retrieve events with available tickets that also have "Concert" in their name
select * from Event where Available_seats > 0 and Event_type = 'Concert';

-- 8. Retrieve users in batches of 5, starting from the 6th user
select * from Customer limit 5 offset 5;

-- 9. Retrieve bookings with booked tickets more than 4
select * from Booking where Num_tickets > 4;

-- 10. Retrieve customer information whose phone number ends with ‘000’
select * from Customer where Phone_number like '%000';

-- 11. Retrieve events in order whose seat capacity more than 15000
select * from Event where Total_seats > 15000 order by Total_seats desc;

-- 12. Select events name not starting with ‘X’, ‘Y’, ‘Z’
select * from Event where Event_name not like 'X%' 
and Event_name not like 'Y%' 
and Event_name not like 'Z%';

-- TASK 3: Aggregate Functions, HAVING, ORDER BY, GROUP BY, and Joins

-- 1. List Events and Their Average Ticket Prices
select Event_name, avg(Ticket_price) as Avg_Ticket_Price 
from Event 
group by Event_name;

-- 2️.Calculate the Total Revenue Generated by Events
select e.Event_name, sum(b.Total_cost) as Total_Revenue
from Booking b
join Event e on b.Event_id = e.Event_id
group by e.Event_name;

-- 3️.Find the Event with the Highest Ticket Sales
select e.Event_name, sum(b.Num_tickets) as Tickets_Sold
from Booking b
join Event e on b.Event_id = e.Event_id
group by e.Event_name
order by Tickets_Sold desc
limit 1;

-- 4️.Calculate the Total Number of Tickets Sold for Each Event
select e.Event_name, sum(b.Num_tickets) as Total_Tickets_Sold
from Booking b
join Event e on b.Event_id = e.Event_id
group by e.Event_name;

-- 5️.Find Events with No Ticket Sales
select e.Event_name
from Event e
left join Booking b on e.Event_id = b.Event_id
where b.Booking_id is null;

-- 6️.Find the User Who Has Booked the Most Tickets
select c.Customer_name, sum(b.Num_tickets) as Total_Tickets
from Booking b
join Customer c on b.Customer_id = c.Customer_id
group by c.Customer_name
order by Total_Tickets desc
limit 1;

-- 7️.List Events and the Total Number of Tickets Sold for Each Month
select date_format(e.Event_date, '%Y-%m') as Event_Month, e.Event_name, sum(b.Num_tickets) as Total_Tickets_Sold
from Booking b
join Event e on b.Event_id = e.Event_id
group by Event_Month, e.Event_name;

-- 8️.Calculate the Average Ticket Price for Events in Each Venue
select v.Venue_name, avg(e.Ticket_price) as Avg_Ticket_Price
from Event e
join Venue v on e.Venue_id = v.Venue_id
group by v.Venue_name;

-- 9️.Calculate the Total Number of Tickets Sold for Each Event Type
select e.Event_type, sum(b.Num_tickets) as Total_Tickets_Sold
from Booking b
join Event e on b.Event_id = e.Event_id
group by e.Event_type;

-- 10. Calculate the Total Revenue Generated by Events in Each Year
select year(e.Event_date) as Event_Year, sum(b.Total_cost) as Total_Revenue
from Booking b
join Event e on b.Event_id = e.Event_id
group by Event_Year;

-- 1️1. List Users Who Have Booked Tickets for Multiple Events
select c.Customer_name, count(distinct b.Event_id) as Events_Booked
from Booking b
join Customer c on b.Customer_id = c.Customer_id
group by c.Customer_name
having Events_Booked > 1;

-- 1️2.Calculate the Total Revenue Generated by Events for Each User
select c.Customer_name, sum(b.Total_cost) as Total_Revenue
from Booking b
join Customer c on b.Customer_id = c.Customer_id
group by c.Customer_name;

-- 1️3.Calculate the Average Ticket Price for Events in Each Category and Venue
select e.Event_type, v.Venue_name, avg(e.Ticket_price) as Avg_Ticket_Price
from Event e
join Venue v on e.Venue_id = v.Venue_id
group by e.Event_type, v.Venue_name;

-- 1️4.List Users and the Total Number of Tickets They've Purchased in the Last 30 Days
select c.Customer_name, sum(b.Num_tickets) as Total_Tickets
from Booking b
join Customer c on b.Customer_id = c.Customer_id
where b.Booking_date >= curdate() - interval 30 day
group by c.Customer_name;

-- TASK 4: Subqueries

-- 1️.Calculate the Average Ticket Price for Events in Each Venue Using a Subquery
select Venue_name, 
(select avg(Ticket_price) from Event e where e.Venue_id = v.Venue_id) as Avg_Ticket_Price
from Venue v;

-- 2️.Find Events with More Than 50% of Tickets Sold Using a Subquery
select e.Event_name, e.Total_seats, e.Available_seats
from Event e
where (Total_seats - Available_seats) > (Total_seats * 0.5);

-- 3️.Calculate the Total Number of Tickets Sold for Each Event
select Event_name, 
(select sum(Num_tickets) from Booking b where b.Event_id = e.Event_id) as Total_Tickets_Sold
from Event e;

-- 4️.Find Users Who Have Not Booked Any Tickets Using a NOT EXISTS Subquery
select c.Customer_name
from Customer c
where not exists (select 1 from Booking b where b.Customer_id = c.Customer_id);

-- 5️.List Events with No Ticket Sales Using a NOT IN Subquery
select Event_name
from Event
where Event_id not in (select distinct Event_id from Booking);

-- 6️.Calculate the Total Number of Tickets Sold for Each Event Type Using a Subquery in the FROM Clause
select e.Event_type, sum(Num_tickets) as Total_Tickets_Sold
from (select Event_id, Num_tickets from Booking) as sub
join Event e on sub.Event_id = e.Event_id
group by e.Event_type;

-- 7️.Find Events with Ticket Prices Higher Than the Average Ticket Price Using a Subquery in the WHERE Clause
select Event_name, Ticket_price
from Event
where Ticket_price > (select avg(Ticket_price) from Event);

-- 8️.Calculate the Total Revenue Generated by Events for Each User Using a Correlated Subquery
select c.Customer_name, 
(select sum(b.Total_cost) from Booking b where b.Customer_id = c.Customer_id) as Total_Revenue
from Customer c;

-- 9️.List Users Who Have Booked Tickets for Events in a Given Venue Using a Subquery in the WHERE Clause
select distinct c.Customer_name
from Customer c
join Booking b on c.Customer_id = b.Customer_id
where b.Event_id in (select Event_id from Event where Venue_id = 1);  -- Change Venue_id accordingly

-- 10. Calculate the Total Number of Tickets Sold for Each Event Category Using a Subquery with GROUP BY
select e.Event_type, sum(b.Num_tickets) as Total_Tickets_Sold
from Booking b
join Event e on b.Event_id = e.Event_id
group by e.Event_type;

-- 1️1.Find Users Who Have Booked Tickets for Events in Each Month Using a Subquery with DATE_FORMAT
select c.Customer_name, date_format(b.Booking_date, '%Y-%m') as Booking_Month, sum(b.Num_tickets) as Total_Tickets
from Booking b
join Customer c on b.Customer_id = c.Customer_id
group by c.Customer_name, Booking_Month;

-- 12.Calculate the Average Ticket Price for Events in Each Venue Using a Subquery
select Venue_name, 
(select avg(Ticket_price) from Event e where e.Venue_id = v.Venue_id) as Avg_Ticket_Price
from Venue v;

