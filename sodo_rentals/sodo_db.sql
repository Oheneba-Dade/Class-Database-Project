DROP DATABASE IF EXISTS sodo_rentals;
CREATE DATABASE sodo_rentals;
USE sodo_rentals;

CREATE TABLE Department (
   department_id INT PRIMARY KEY AUTO_INCREMENT,
   department_name VARCHAR(55)
);

CREATE TABLE Employee (
   employee_id INT PRIMARY KEY AUTO_INCREMENT,
   department_id INT,
   first_name VARCHAR(55),
   last_name VARCHAR(55),
   date_of_birth DATE,
   email VARCHAR(50) UNIQUE,
   date_of_employment DATE,
   FOREIGN KEY (department_id) REFERENCES Department(department_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Partners (
   partner_id INT PRIMARY KEY AUTO_INCREMENT,
   partner_name VARCHAR(55),
   partner_location VARCHAR(55)
);

CREATE TABLE Suppliers(
  supplier_id INT PRIMARY KEY AUTO_INCREMENT,
  supplier_name VARCHAR(50),
  supplier_email varchar(50) UNIQUE
);

CREATE TABLE Insurance(
  insurance_id INT PRIMARY KEY AUTO_INCREMENT,
  insurance_name VARCHAR(50),
  amount DECIMAL(10, 2)
);

CREATE TABLE Customers(
  customer_id INT PRIMARY KEY AUTO_INCREMENT,
  first_name VARCHAR(55) NOT NULL,
  last_name VARCHAR(55) NOT NULL,
  email VARCHAR(50) UNIQUE,
  phone_number VARCHAR(15) UNIQUE
);

ALTER TABLE Customers AUTO_INCREMENT = 0001;

CREATE TABLE PremiumCustomers(
  customer_id INT PRIMARY KEY,
  date_of_subscription DATE NOT NULL,
  subscription_renewal_date DATE NOT NULL,
  FOREIGN KEY(customer_id) REFERENCES Customers(customer_id) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Vehicle(
  vehicle_name VARCHAR(50),
  vehicle_id INT PRIMARY KEY AUTO_INCREMENT,
  seating_capacity INT NOT NULL,
  fuel_capacity FLOAT NOT NULL,
  transmission_type VARCHAR(10) NOT NULL,
  horsepower VARCHAR(10) NOT NULL
);


CREATE TABLE Supplied_Vehicles(
   number_plate VARCHAR(20) PRIMARY KEY,
   supplier_id INT,
   vehicle_id INT,
   chassis_number VARCHAR(15),
   gps_health_life INT,
   gps_date_purchased DATE,
   FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id) ON DELETE CASCADE ON UPDATE CASCADE,
   FOREIGN KEY (vehicle_id) REFERENCES Vehicle(vehicle_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Serviced_Vehicles(
   serviced_vehicle_id INT AUTO_INCREMENT PRIMARY KEY,
   number_plate VARCHAR(15),
   reason_for_service VARCHAR(255),
   return_date DATE,
   FOREIGN KEY (number_plate) REFERENCES Supplied_Vehicles(number_plate) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Reservation(
   reservation_id INT PRIMARY KEY AUTO_INCREMENT,
   reservation_end_date DATE,
   reservation_start_date DATE,
   payment_date DATE,
   amount DECIMAL(10,2),
   duration INT,
   customer_id INT,
   employee_id INT,
   insurance_id INT,
   number_plate VARCHAR(15),
   review_score INT,
   review_description VARCHAR(20),
   FOREIGN KEY(customer_id) REFERENCES Customers(customer_id) ON DELETE CASCADE ON UPDATE CASCADE,
   FOREIGN KEY(employee_id) REFERENCES Employee(employee_id) ON DELETE CASCADE ON UPDATE CASCADE,
   FOREIGN KEY(insurance_id) REFERENCES Insurance(insurance_id) ON DELETE CASCADE ON UPDATE CASCADE,
   FOREIGN KEY(number_plate) REFERENCES Supplied_Vehicles(number_plate) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Contract_Employee(
   employee_id INT PRIMARY KEY,
   contract_start_date DATE,
   contract_termination_date DATE,
   FOREIGN KEY(employee_id) REFERENCES Employee(employee_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Drives(
	employee_id INT,
    reservation_id INT,
    review_score INT,
    review_description VARCHAR(15),
    FOREIGN KEY (reservation_id) REFERENCES Reservation(reservation_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id) ON DELETE CASCADE ON UPDATE CASCADE
);

Insert into Department(department_id, department_name) VALUES(1,'Marketing');
insert into Department(department_id, department_name) VALUES(2, 'Purchasing');
insert into Department(department_id, department_name) VALUES(3,'Finance');
insert into Department(department_id, department_name) VALUES(4,'Human Resource');
insert into Department(department_id, department_name) VALUES(5, 'Drivers');

Insert into Employee(department_id, first_name, last_name, date_of_birth, email, date_of_employment)VALUES(1, 'Aaron', 'Ramsdale', '1995-10-05', 'aaron.ramsdale@gmail.com', '2020-01-07');
Insert into Employee(department_id, first_name, last_name, date_of_birth, email, date_of_employment)VALUES(1, 'Selom', 'Caleb', '1990-04-10', 'selom.caleb@gmail.com', '2020-03-17');
Insert into Employee(department_id, first_name, last_name, date_of_birth, email, date_of_employment)VALUES(1, 'Akua', 'Aidoo', '1984-02-01', 'akua.aidoo@gmail.com', '2020-01-07');
Insert into Employee(department_id, first_name, last_name, date_of_birth, email, date_of_employment)VALUES(2, 'Mary', 'Asare', '1989-11-29', 'mary.asare@gmail.com', '2020-01-07');
Insert into Employee(department_id, first_name, last_name, date_of_birth, email, date_of_employment)VALUES(2, 'Thomas', 'Ansah', '1988-12-27', 'thomas.ansah@gmail.com', '2020-01-07');
Insert into Employee(department_id, first_name, last_name, date_of_birth, email, date_of_employment)VALUES(2, 'Kofi', 'Baako', '1986-09-12', 'kofi.baako@gmail.com', '2020-01-07');
Insert into Employee(department_id, first_name, last_name, date_of_birth, email, date_of_employment)VALUES(3, 'Ama', 'Boadi', '1989-04-25', 'ama.boadi@gmail.com', '2020-01-07');
Insert into Employee(department_id, first_name, last_name, date_of_birth, email, date_of_employment)VALUES(3, 'Sharon', 'Mensah', '1990-07-11', 'sharon.mensah@gmail.com', '2020-01-07');
Insert into Employee(department_id, first_name, last_name, date_of_birth, email, date_of_employment)VALUES(3, 'Philip', 'Mensah', '1986-03-28', 'philip.mensah@gmail.com', '2020-01-07');
Insert into Employee(department_id, first_name, last_name, date_of_birth, email, date_of_employment)VALUES(4, 'Mercy', 'Osei', '1987-08-02', 'mercy.osei@gmail.com', '2020-01-07');
Insert into Employee(department_id, first_name, last_name, date_of_birth, email, date_of_employment)VALUES(4, 'Cynthia', 'Obadai', '1991-05-02', 'cynthia.obadai@gmail.com', '2020-01-07');
Insert into Employee(department_id, first_name, last_name, date_of_birth, email, date_of_employment)VALUES(4, 'Naa', 'Khadijah', '1991-12-22', 'naa.khadijah@gmail.com', '2020-01-07');
Insert into Employee(department_id, first_name, last_name, date_of_birth, email, date_of_employment)VALUES(5, 'Ben', 'Boakye', '1987-01-06', 'ben.boakye@gmail.com', '2020-01-07');
Insert into Employee(department_id, first_name, last_name, date_of_birth, email, date_of_employment)VALUES(5, 'Akwasi', 'Ofori', '1991-06-17', 'akwasi.ofori@gmail.com', '2020-01-07');
Insert into Employee(department_id, first_name, last_name, date_of_birth, email, date_of_employment)VALUES(5, 'Kwame', 'Dapaah', '1991-01-13', 'kwame.dapaah@gmail.com', '2020-01-07');


insert into Customers(first_name, last_name, email, phone_number) VALUES ( 'Daniel', 'Nkansah', 'daniel@thismail.com', '0591674329');
insert into Customers(first_name, last_name, email, phone_number) VALUES ( 'Esther', 'Owusu', 'esther.owusu@thismail.com', '0591483950');
insert into Customers(first_name, last_name, email, phone_number) VALUES ( 'Eric', 'Opana', 'ericdon@viewmail.com', '0244395760');
insert into Customers(first_name, last_name, email, phone_number) VALUES ( 'Sevilla', 'Jones', 'sjoines@viewmail.com', '0264456739');
insert into Customers(first_name, last_name, email, phone_number) VALUES ( 'Delali', 'Fiawoo', 'defiawoo@rixmail.com', '0264567489');
insert into Customers(first_name, last_name, email, phone_number) VALUES ( 'Leroy', 'Okomfo', 'okomfootoo@rixmail.com', '0592456783');
insert into Customers(first_name, last_name, email, phone_number) VALUES ( 'Deing', 'Osei', 'deingoseing@rixmail.com', '0544578345');
insert into Customers(first_name, last_name, email, phone_number) VALUES ( 'Ama', 'Gyatowa', 'gyats.ama@thismail.com', '0244478125');
insert into Customers(first_name, last_name, email, phone_number) VALUES ( 'Giftie', 'Osei', 'giftieosei@thismail.com', '0264356789');
insert into Customers(first_name, last_name, email, phone_number) VALUES ( 'Goldie', 'Locks', 'golds.porridge@hotmail.com', '0591356789');

insert into PremiumCustomers(customer_id, date_of_subscription, subscription_renewal_date) VALUES (0002, '2021-4-15', '2021-11-25');
insert into PremiumCustomers(customer_id, date_of_subscription, subscription_renewal_date) VALUES (0004, '2021-7-19', '2022-3-5');
insert into PremiumCustomers(customer_id, date_of_subscription, subscription_renewal_date) VALUES (0006, '2020-4-19', '2022-3-5');
insert into PremiumCustomers(customer_id, date_of_subscription, subscription_renewal_date) VALUES (0008, '2020-2-27', '2022-3-5');

insert into Partners(partner_name,partner_location) VALUES('AutoSure Detailing','Nungua');
insert into Partners(partner_name,partner_location) VALUES('Caress Carcare','Dansoman');
insert into Partners(partner_name,partner_location) VALUES('Okplongo Carwash','Okplongo');
insert into Partners(partner_name,partner_location) VALUES('Kingsby Auto Mechanic','Teshie');
insert into Partners(partner_name,partner_location) VALUES('Power Star Auto Technic','Accra');

insert into Suppliers(supplier_name,supplier_email) VALUES ('Erata Motors','erata.motors@gmail.com');
insert into Suppliers(supplier_name,supplier_email) VALUES ('De Georgia Motors','degeorgia.motors@gmail.com');
insert into Suppliers(supplier_name,supplier_email) VALUES ('MAC Motors','mac.motors@gmail.com');
insert into Suppliers(supplier_name,supplier_email) VALUES ('Swizz Motors','swizz.motors@gmail.com');
insert into Suppliers(supplier_name,supplier_email) VALUES ('AutoPlaza Motors','autoplaza.motors@gmail.com');

insert into Insurance(insurance_name,amount) VALUES ('Individual Risk',1500.00);
insert into Insurance(insurance_name,amount) VALUES ('Family Risk',1700.20);
insert into Insurance(insurance_name,amount) VALUES ('Personal Risk Premium',1890.35);
insert into Insurance(insurance_name,amount) VALUES ('Family Risk Premium',2000.00);
insert into Insurance(insurance_name,amount) VALUES ('Extreme Protection',4000.00);

insert into Vehicle(vehicle_name,seating_capacity, fuel_capacity, transmission_type, horsepower) VALUES ('Hyundai Elantra',5, 2.0, 'automatic', '150hp');
insert into Vehicle(vehicle_name,seating_capacity, fuel_capacity, transmission_type, horsepower) VALUES ('Mercedes Benz',5, 1.4, 'automatic', '110hp');
insert into Vehicle(vehicle_name,seating_capacity, fuel_capacity, transmission_type, horsepower) VALUES ('Kia Serato',7, 5.4, 'automatic', '750hp');
insert into Vehicle(vehicle_name,seating_capacity, fuel_capacity, transmission_type, horsepower) VALUES ('Toyota-Yaris',5, 5.4, 'manual', '750hp');
insert into Vehicle(vehicle_name,seating_capacity, fuel_capacity, transmission_type, horsepower) VALUES ('Dodge Charger RT',5, 3.0, 'manual', '250hp');
insert into Vehicle(vehicle_name,seating_capacity, fuel_capacity, transmission_type, horsepower) VALUES ('Hyundai Civic',5, 5.4, 'manual', '750hp');

ALTER TABLE Vehicle AUTO_INCREMENT = 0001;

Insert into Supplied_Vehicles(number_plate, supplier_id, vehicle_id, chassis_number,gps_health_life,gps_date_purchased) VALUES('GW-4455-21', 1, 0001, 'SVO30-0169266',3,'2019-11-23');
Insert into Supplied_Vehicles(number_plate, supplier_id, vehicle_id, chassis_number,gps_health_life,gps_date_purchased) VALUES('GW-4002-20', 2, 0002, 'NSP12-7464899',4, '2022-10-23');
Insert into Supplied_Vehicles(number_plate, supplier_id, vehicle_id, chassis_number,gps_health_life,gps_date_purchased) VALUES('GX-1147-22', 3, 0003,'JUQ87-9947430', 5, '2021-01-23');
Insert into Supplied_Vehicles(number_plate, supplier_id, vehicle_id, chassis_number,gps_health_life,gps_date_purchased) VALUES('GN-4665-20', 4, 0001,'HEW98-8762920', 5, '2021-01-24');
Insert into Supplied_Vehicles(number_plate, supplier_id, vehicle_id, chassis_number,gps_health_life,gps_date_purchased) VALUES('GT-1455-21', 5, 0002, 'YEX17-9993873', 5, '2021-01-23');
Insert into Supplied_Vehicles(number_plate, supplier_id, vehicle_id, chassis_number,gps_health_life,gps_date_purchased) VALUES('GW-4452-20', 1, 0003, 'BBH33-9883362', 4, '2022-05-17');
Insert into Supplied_Vehicles(number_plate, supplier_id, vehicle_id, chassis_number,gps_health_life,gps_date_purchased) VALUES('GW-4955-20', 2, 0002,'IGR22-9937373', 4, '2022-05-17');
Insert into Supplied_Vehicles(number_plate, supplier_id, vehicle_id, chassis_number,gps_health_life,gps_date_purchased) VALUES('GB-4015-20', 3, 0003,'OPW22-2272667', 2, '2020-10-15');
Insert into Supplied_Vehicles(number_plate, supplier_id, vehicle_id, chassis_number,gps_health_life,gps_date_purchased) VALUES('GN-1098-21', 4, 0002,'ZAS47-8373390', 2, '2020-11-25');
Insert into Supplied_Vehicles(number_plate, supplier_id, vehicle_id, chassis_number,gps_health_life,gps_date_purchased) VALUES('GW-4186-21', 5, 0001,'PQW63-9938330', 2, '2020-11-09');


Insert into Serviced_Vehicles(number_plate, reason_for_service, return_date)VALUES('GW-4455-21', 'general checkup', '2022-07-27');
Insert into Serviced_Vehicles(number_plate, reason_for_service, return_date)VALUES('GW-4002-20', 'general checkup', '2022-06-25');
Insert into Serviced_Vehicles(number_plate, reason_for_service, return_date)VALUES('GX-1147-22', 'coolant replacement', '2022-05-30');
Insert into Serviced_Vehicles(number_plate, reason_for_service, return_date)VALUES('GX-1147-22', 'radiator leak', '2022-08-22');
Insert into Serviced_Vehicles(number_plate, reason_for_service, return_date)VALUES('GX-1147-22', 'faulty spark plugs', '2022-04-12');
Insert into Serviced_Vehicles(number_plate, reason_for_service, return_date)VALUES('GX-1147-22', 'faulty spark plugs', '2022-04-15');
Insert into Serviced_Vehicles(number_plate, reason_for_service, return_date)VALUES('GX-1147-22', 'torn fan belt', '2022-06-22');
Insert into Serviced_Vehicles(number_plate, reason_for_service, return_date)VALUES('GN-4665-20' , 'general checkup', '2022-04-01');
Insert into Serviced_Vehicles(number_plate, reason_for_service, return_date)VALUES('GT-1455-21', 'general checkup','2022-08-30');
Insert into Serviced_Vehicles(number_plate, reason_for_service, return_date)VALUES('GW-4452-20', 'oil change','2022-09-12');
Insert into Serviced_Vehicles(number_plate, reason_for_service, return_date)VALUES('GW-4955-20', 'general checkup','2022-09-18');
Insert into Serviced_Vehicles(number_plate, reason_for_service, return_date)VALUES('GB-4015-20','coolant replacement', '2022-11-27');
Insert into Serviced_Vehicles(number_plate, reason_for_service, return_date)VALUES('GN-1098-21', 'general checkup', '2022-10-21');
Insert into Serviced_Vehicles(number_plate, reason_for_service, return_date)VALUES('GW-4186-21', 'general checkup','2022-12-13');
Insert into Serviced_Vehicles(number_plate, reason_for_service, return_date)VALUES('GW-4186-21', 'oil change','2022-08-10');

insert into Reservation(reservation_id, reservation_end_date, reservation_start_date, payment_date, amount, duration, customer_id, employee_id, insurance_id, number_plate) VALUES (0001, '2022-11-15', '2022-10-15', '2022-10-15', 2500.00, 1, 1, 2, 1, 'GT-1455-21');
insert into Reservation(reservation_id, reservation_end_date, reservation_start_date, payment_date, amount, duration, customer_id, employee_id, insurance_id, number_plate) VALUES (0002, '2021-10-20', '2021-10-10', '2021-10-20', 4000.00, 1, 4, 5, 3,'GW-4455-21');
insert into Reservation(reservation_id, reservation_end_date, reservation_start_date, payment_date, amount, duration, customer_id, employee_id, insurance_id, number_plate) VALUES (0003, '2022-09-20', '2022-09-2', '2022-09-20', 7000.00, 18, 1, 6, 1,'GW-4455-21');
insert into Reservation(reservation_id, reservation_end_date, reservation_start_date, payment_date, amount, duration, customer_id, employee_id, insurance_id, number_plate) VALUES (0004, '2022-09-20', '2022-09-20', '2022-09-20', 7000.00, 18, 7, 7, 1,'GW-4455-21');
insert into Reservation(reservation_id, reservation_end_date, reservation_start_date, payment_date, amount, duration, customer_id, employee_id, insurance_id, number_plate) VALUES (0005, '2022-12-30', '2022-11-15', '2022-11-30', 6000.00, 15 , 10, 8, 2,'GW-4002-20');
insert into Reservation(reservation_id, reservation_end_date, reservation_start_date, payment_date, amount, duration, customer_id, employee_id, insurance_id, number_plate) VALUES (0006, '2022-08-19', '2022-08-15', '2022-08-14', 3500.00, 4, 2, 9, 3,'GX-1147-22');
insert into Reservation(reservation_id, reservation_end_date, reservation_start_date, payment_date, amount, duration, customer_id, employee_id, insurance_id, number_plate) VALUES (0007, '2022-10-26', '2022-10-20', '2022-10-20', 1200.00, 6, 2, 10, 4,'GX-1147-22');
insert into Reservation(reservation_id, reservation_end_date, reservation_start_date, payment_date, amount, duration, customer_id, employee_id, insurance_id, number_plate) VALUES (0008, '2022-10-27', '2022-11-26', '2022-10-26', 2000.00, 1, 6, 11, 5,'GN-4665-20');
insert into Reservation(reservation_id, reservation_end_date, reservation_start_date, payment_date, amount, duration, customer_id, employee_id, insurance_id, number_plate) VALUES (0009, '2022-10-13', '2022-10-5', '2022-10-5', 9000.00, 8, 2, 12, 2,'GT-1455-21');
insert into Reservation(reservation_id, reservation_end_date, reservation_start_date, payment_date, amount, duration, customer_id, employee_id, insurance_id, number_plate) VALUES (0010, '2022-10-7', '2022-10-5', '2022-10-5', 1400.00, 2, 9, 14, 1,'GW-4452-20');






INSERT INTO Drives(employee_id, reservation_id, review_score, review_description) VALUES(4,7,3,'mid');
INSERT INTO Drives(employee_id, reservation_id, review_score, review_description) VALUES(13,8,4,'good');
INSERT INTO Drives(employee_id, reservation_id, review_score, review_description) VALUES(3,9,3,'mid');
INSERT INTO Drives(employee_id, reservation_id, review_score, review_description) VALUES(4,10,2,'bad');
INSERT INTO Drives(employee_id, reservation_id, review_score, review_description) VALUES(13,1,5,'best');
INSERT INTO Drives(employee_id, reservation_id, review_score, review_description) VALUES(4,2,3,'mid');
INSERT INTO Drives(employee_id, reservation_id, review_score, review_description) VALUES(3,3, 3, 'mid');
INSERT INTO Drives(employee_id, reservation_id, review_score, review_description) VALUES(13,4,5,'best');
INSERT INTO Drives(employee_id, reservation_id, review_score, review_description) VALUES(3,5,4,'good');
INSERT INTO Drives(employee_id, reservation_id, review_score, review_description) VALUES(13,6,5,'best');

-- Produces in descending order, the average ratings of drivers in the company
SELECT concat(first_name, " ", last_name) as 'Driver', AVG(CAST(review_score as Float)) as average_rating
FROM Drives
LEFT OUTER JOIN Employee ON
Employee.employee_id = Drives.employee_id
GROUP BY concat(first_name, last_name)
ORDER BY AVG(Cast(review_score as Float)) DESC;

-- Produces a list of all vehicles along with number plates whose GPS need servicing or replacement because of expiry 
SELECT vehicle_name, A.number_plate FROM Vehicle V
INNER JOIN
(SELECT vehicle_id, number_plate FROM Supplied_Vehicles WHERE number_plate IN
(SELECT number_plate FROM Supplied_Vehicles
WHERE ROUND((CURDATE() - gps_date_purchased) / 365) > gps_health_life)) A
ON V.vehicle_id = A.vehicle_id;

-- Returns the customers with the most reservations under a certain period of time (in this case 120 days)
SELECT concat(first_name, " ", last_name) as 'Loyal Customer', COUNT(*) AS number_of_reservations
FROM Customers 
INNER JOIN Reservation ON
Customers.customer_id = Reservation.customer_id
WHERE CURDATE() - reservation_start_date < 120
GROUP BY concat(first_name, last_name) ORDER BY number_of_reservations DESC;

-- Obtain the different cars that have been rented along with their count 
SELECT vehicle_name, COUNT(*) AS vehicle_count FROM Vehicle
INNER JOIN
(SELECT vehicle_id FROM Supplied_Vehicles
INNER JOIN
(SELECT number_plate FROM Reservation) A
ON A.number_plate = Supplied_Vehicles.number_plate) B
ON Vehicle.vehicle_id = B.vehicle_id
GROUP BY vehicle_name;

-- To obtain all the insurance packages with their count to direct management as to which to revise or remove 
SELECT insurance_name, COUNT(*) AS insurance_count FROM Insurance
INNER JOIN
(SELECT insurance_id FROM Reservation) A
ON Insurance.insurance_id = A.insurance_id
GROUP BY insurance_name;

-- To show cars that have been taken to the repair shop for reasons other than general check up, with count to inform management decision to get rid of bad cars.
SELECT number_plate, COUNT(*) AS repair_count FROM Serviced_Vehicles
WHERE reason_for_service NOT IN ('general checkup')
GROUP BY number_plate;

