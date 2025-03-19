-- Create table DOCTOR_MASTER

create table DOCTOR_MASTER(
doctor_id varchar(15) primary key,
doctor_name varchar(215) not null,
Dept varchar(215) not null
);
drop table Doctor_Master;
-- Insert values
insert into DOCTOR_MASTER(doctor_id,doctor_name,Dept) values(
'D001' ,'Ram','ENT'),('D002','Rajan','ENT'),('D003','Smita','Eye'),('D004','Bhavan','Surgery'),('D005','Sheela','Surgery'),('D006','Nethra','Surgery');


-- create table ROOM_MASTER
create table ROOM_MASTER(
room_no varchar(15) primary key,
room_type varchar(215) not null,
status varchar(215) not null

);
drop  table ROOM_MASTER;

-- Insert values
insert into ROOM_MASTER(room_no,room_type,status) values('R0001','AC','occupied'),('R0002','Suite','vacant'),('R0003','NonAC','vacant'),('R0004','NonAC','occupied'),('R0005','AC','vacant'),('R0006','AC','occupied');

drop table PATIENT_MASTER;

-- create table PATIENT_MASTER
create table PATIENT_MASTER(
pid varchar(15) primary key unique not null,
name varchar(215) not null,
age  int not null,
Weight int  not null,
Gender varchar(10) not null,
Address varchar(50) not null,
phoneno varchar(10) not null,
Disease varchar(50) not null,
Doctor_id varchar(5), 
Foreign key (Doctor_id) references DOCTOR_MASTER(doctor_id)

);



-- insert values
insert into PATIENT_MASTER (pid, name, age, Weight, Gender, Address, phoneno, Disease, Doctor_id) 
value
('P001', 'John Doe', 35, 70, 'Male', '123 Main St', '9876543210', 'Flu', 'D001'),
('P002', 'Jane Smith', 28, 55, 'Female', '456 Elm St', '9123456789', 'Cold', 'D002'),
('P003', 'Alice Brown', 40, 60, 'Female', '789 Oak St', '9234567890', 'Diabetes', 'D001'),
('P004', 'Bob Johnson', 50, 80, 'Male', '101 Pine St', '9345678901', 'Hypertension', 'D003'),
('P005', 'Charlie White', 33, 72, 'Male', '202 Cedar St', '9456789012', 'Asthma', 'D002');



drop table ROOM_ALLOCATION;

-- create table ROOM_ALLOCATION 
create table ROOM_ALLOCATION 
(room_no varchar(15),
foreign key(room_no) references ROOM_MASTER(room_no),
pid varchar(15) not null,
foreign key (pid) references PATIENT_MASTER(pid),
admission_date date not null,
Release_date date);

drop table ROOM_ALLOCATION;

-- insert values
insert into ROOM_ALLOCATION(room_no,pid,admission_date,Release_date) values('R0001','P001',STR_TO_DATE('15-oct-16', '%d-%b-%y'),STR_TO_DATE('26-oct-16', '%d-%b-%y')),
('R0002','P002',STR_TO_DATE('15-nov-16', '%d-%b-%y'),STR_TO_DATE('26-nov-16', '%d-%b-%y')),
('R0002','P003',STR_TO_DATE('01-dec-16', '%d-%b-%y'),STR_TO_DATE('30-dec-16', '%d-%b-%y')),
('R0004','P001',STR_TO_DATE('01-jan-17', '%d-%b-%y'),STR_TO_DATE('30-jan-17', '%d-%b-%y'));

-- Query #1: Display the patients who were admitted in the month of january.

select p.name from PATIENT_MASTER p
join ROOM_ALLOCATION r ON p.pid = r.pid
where DATE_FORMAT(r.admission_date, '%b') = 'jan';


-- Query #2: Display the female patient who is not suffering from ashma

select name from PATIENT_MASTER 
where Gender = 'Female' 
and Disease not in ('Asthma');


-- Query #3: Count the number of male and female patients.

select Gender, COUNT(*) AS Patients_Count
from PATIENT_MASTER
group by Gender;


-- Query #4: Display the patient_id,patient_name, doctor_id, doctor_name, room_no, room_type and admission_date.

select p.pid as Patient_ID, 
    p.name as Patient_Name, 
    d.doctor_id as Doctor_ID, 
    d.doctor_name as Doctor_Name, 
    r.room_no as Room_No, 
    rm.room_type as Room_Type, 
    r.admission_date as Admission_Date
from ROOM_ALLOCATION r
join PATIENT_MASTER p on r.pid = p.pid
join DOCTOR_MASTER d on p.Doctor_id = d.doctor_id
join ROOM_MASTER rm on r.room_no = rm.room_no;


-- Query #5: Display the room_no which was never allocated to any patient.

select room_no from ROOM_MASTER 
where room_no not in(select distinct room_no from ROOM_ALLOCATION);


--- Query #6: Display the room_no, room_type which are allocated more than once.

select r.room_no, rm.room_type, count(*) AS Allocation_Count
from ROOM_ALLOCATION r
join ROOM_MASTER rm ON r.room_no = rm.room_no
group by r.room_no, rm.room_type
having count(*) > 1;







