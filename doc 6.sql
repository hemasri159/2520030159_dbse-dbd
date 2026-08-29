DROP DATABASE IF EXISTS sql_views;
#2520030519 hema sri
CREATE DATABASE sql_views;

USE sql_views;

CREATE TABLE Customer (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(100) NOT NULL,
    Phone VARCHAR(15),
    Email VARCHAR(100),
    City VARCHAR(50)
);
#2520030519 hema sri
CREATE TABLE Account (
    Account_No INT PRIMARY KEY,
    Customer_ID INT,
    Account_Type VARCHAR(20),
    Balance DECIMAL(12,2),
    Branch VARCHAR(50),
    FOREIGN KEY (Customer_ID)
    REFERENCES Customer(Customer_ID)
);

CREATE TABLE Bank_Transaction (
    Transaction_ID INT PRIMARY KEY AUTO_INCREMENT,
    Account_No INT,
    Transaction_Type VARCHAR(20),
    Amount DECIMAL(12,2),
    Transaction_Date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (Account_No)
    REFERENCES Account(Account_No)
);

CREATE TABLE Loan (
    Loan_ID INT PRIMARY KEY,
    Customer_ID INT,
    Loan_Type VARCHAR(30),
    Loan_Amount DECIMAL(12,2),
    Interest_Rate DECIMAL(5,2),
    FOREIGN KEY (Customer_ID)
    REFERENCES Customer(Customer_ID)
);

INSERT INTO Customer
(Customer_ID, Customer_Name, Phone, Email, City)
VALUES
(101, 'Manasvi', '9876543210', 'manasvi@gmail.com', 'Hyderabad'),
(102, 'Ananya', '9876543211', 'ananya@gmail.com', 'Vijayawada'),
(103, 'Akhila', '9876543212', 'akhila@gmail.com', 'Bangalore'),
(104, 'Hasini', '9876543213', 'hasini@gmail.com', 'Chennai'),
(105, 'Bhavana', '9876543214', 'bhavana@gmail.com', 'Hyderabad'),
(106, 'Tejaswini', '9876543215', 'teju@gmail.com', 'Delhi'),
(107, 'Aswitha', '9876543216', 'aswitha@gmail.com', 'Mumbai'),
(108, 'Rishika', '9876543217', 'rishika@gmail.com', 'Pune'),
(109, 'Havishaa', '9876543218', 'havishaa@gmail.com', 'Hyderabad'),
(110, 'Pavani', '9876543219', 'pavani@gmail.com', 'Vijayawada');
#2520030519 hema sri
INSERT INTO Account
(Account_No, Customer_ID, Account_Type, Balance, Branch)
VALUES
(10001, 101, 'Savings', 50000, 'Hyderabad'),
(10002, 102, 'Savings', 75000, 'Vijayawada'),
(10003, 103, 'Current', 120000, 'Bangalore'),
(10004, 104, 'Savings', 45000, 'Chennai'),
(10005, 105, 'Current', 90000, 'Hyderabad'),
(10006, 106, 'Savings', 65000, 'Delhi'),
(10007, 107, 'Current', 150000, 'Mumbai'),
(10008, 108, 'Savings', 35000, 'Pune'),
(10009, 109, 'Savings', 85000, 'Hyderabad'),
(10010, 110, 'Current', 110000, 'Vijayawada');

INSERT INTO Bank_Transaction
(Account_No, Transaction_Type, Amount)
VALUES
(10001, 'DEPOSIT', 10000),
(10001, 'WITHDRAW', 5000),
(10002, 'DEPOSIT', 15000),
(10003, 'WITHDRAW', 20000),
(10004, 'DEPOSIT', 5000),
(10005, 'WITHDRAW', 10000),
(10006, 'DEPOSIT', 12000),
(10007, 'DEPOSIT', 25000),
(10008, 'WITHDRAW', 5000),
(10009, 'DEPOSIT', 20000),
(10010, 'WITHDRAW', 15000);

INSERT INTO Loan
(Loan_ID, Customer_ID, Loan_Type, Loan_Amount, Interest_Rate)
VALUES
(501, 101, 'Home Loan', 5000000, 7.5),
(502, 102, 'Education Loan', 1000000, 6.5),
(503, 103, 'Car Loan', 800000, 8.2),
(504, 104, 'Personal Loan', 500000, 10.5),
(505, 105, 'Home Loan', 4000000, 7.2),
(506, 106, 'Car Loan', 900000, 8.5),
(507, 107, 'Business Loan', 3000000, 9.0),
(508, 109, 'Personal Loan', 600000, 10.0);

SELECT * FROM Customer;

SELECT * FROM Account;

SELECT * FROM Bank_Transaction;
#2520030519 hema sri
SELECT * FROM Loan;

CREATE VIEW Customer_View AS
SELECT *
FROM Customer;

SELECT * FROM Customer_View;

CREATE VIEW High_Balance_View AS
SELECT
    Account_No,
    Customer_ID,
    Account_Type,
    Balance
FROM Account
WHERE Balance > 100000;

SELECT * FROM High_Balance_View;
#2520030519 hema sri
CREATE VIEW Customer_Account_View AS
SELECT
    C.Customer_ID,
    C.Customer_Name,
    C.City,
    A.Account_No,
    A.Account_Type,
    A.Balance,
    A.Branch
FROM Customer C
JOIN Account A
ON C.Customer_ID = A.Customer_ID;

SELECT * FROM Customer_Account_View;

CREATE VIEW Average_Account_Balance AS
SELECT
    AVG(Balance) AS Average_Balance
FROM Account;

SELECT * FROM Average_Account_Balance;

CREATE VIEW Minimum_Balance_View AS
SELECT
    MIN(Balance) AS Minimum_Balance
FROM Account;
#2520030519 hema sri
SELECT * FROM Minimum_Balance_View;

CREATE VIEW Account_Type_Balance AS
SELECT
    Account_Type,
    SUM(Balance) AS Total_Balance
FROM Account
GROUP BY Account_Type;

SELECT * FROM Account_Type_Balance;

CREATE VIEW Rich_Branches AS
SELECT
    Branch,
    SUM(Balance) AS Total_Balance
FROM Account
GROUP BY Branch
HAVING SUM(Balance) > 100000;

SELECT * FROM Rich_Branches;

CREATE VIEW Deposit_Transaction_View AS
SELECT *
FROM Bank_Transaction
WHERE Transaction_Type = 'DEPOSIT';

SELECT * FROM Deposit_Transaction_View;

CREATE VIEW Customer_Name_View AS
SELECT
    Customer_ID,
    Customer_Name,
    City
FROM Customer
ORDER BY Customer_Name;

SELECT * FROM Customer_Name_View;

CREATE VIEW Loan_Total_Amount_View AS
SELECT
    Loan_ID,
    Customer_ID,
    Loan_Type,
    Loan_Amount,
    Interest_Rate,
    Loan_Amount + (Loan_Amount * Interest_Rate / 100) AS Total_Amount
FROM Loan;

SELECT * FROM Loan_Total_Amount_View;

SELECT *
FROM Customer_Account_View
ORDER BY Balance DESC;
#2520030519 hema sri
CREATE VIEW Simple_Account_View AS
SELECT
    Account_No,
    Customer_ID,
    Account_Type,
    Balance,
    Branch
FROM Account;

INSERT INTO Simple_Account_View
VALUES
(10011, 101, 'Savings', 55000, 'Hyderabad');

SELECT * FROM Account;

DELETE FROM Simple_Account_View
WHERE Account_No = 10011;
#2520030519 hema sri
SELECT * FROM Account;
#2520030519 hema sri
SHOW FULL TABLES
WHERE TABLE_TYPE = 'VIEW';