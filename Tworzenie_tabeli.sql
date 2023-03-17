-- Tworzenie tabeli Sales i Customers

CREATE TABLE IF NOT EXISTS Sales;
CREATE SCHEMA IF NOT EXISTS Sales;
USE Sales;
Create Table sales
(
purchase_number int not null primary key auto_increment,
date_of_purchase date not null,
customer_id int,
item_code varchar(10) not null
);

CREATE TABLE customers                                                 
(
    customer_id INT,
    first_name varchar(255),
    last_name varchar(255),
    email_address varchar(255),
    number_of_complaints int
); 

DROP TABLE sales;
-- Inny sposób na tworzenie primar key w tabeli
Create Table sales
(
purchase_number int not null auto_increment,
date_of_purchase date not null,
customer_id int,
item_code varchar(10) not null,
Primary key (purchase_number)
);

DROP TABLE customers;
-- Tworzenie 3 tabel 
 CREATE TABLE customers                                                    
(  
    customer_id INT,  
    first_name varchar(255),  
    last_name varchar(255),  
    email_address varchar(255),   
    number_of_complaints int, 
primary key (customer_id)   
);  

   

CREATE TABLE items                                                                                                                        
(  
    item_code varchar(255), 
    item varchar(255),
    unit_price numeric(10,2),
    company_id varchar(255),
primary key (item_code)   
);  

    CREATE TABLE companies 
(
    company_id varchar(255),   
    company_name varchar(255),  
    headquarters_phone_number int(12),   
primary key (company_id)   
); 