create database adsl7;
use adsl7;

CREATE TABLE DimCustomer (
CustomerID INT PRIMARY KEY,
CustomerAltID VARCHAR(50),
CustomerName VARCHAR(100),
Gender CHAR(1)
);

CREATE TABLE DimDate (
DateKey INT PRIMARY KEY,
Date DATE,
FullDateUK VARCHAR(50),
FullDateUSA VARCHAR(50),
DayOfMonth INT,
DaySuffix VARCHAR(2),
DayName VARCHAR(20),
DayOfWeekUSA INT,
DayOfWeekUK INT,
DayOfWeekInMonth INT,
DayOfWeekInYear INT,
DayOfQuarter INT,
DayOfYear INT,
WeekOfMonth INT,
WeekOfQuarter INT,
WeekOfYear INT,
Month INT,
MonthName VARCHAR(20),
Quarter INT,
QuarterName VARCHAR(20),
Year INT,
YearName VARCHAR(20),
MonthOfQuarter INT,
MonthYear VARCHAR(6),
IsHolidayUSA INT,
IsWeekday INT,
HolidayUSA VARCHAR(50),
IsHolidayUK INT,
HolidayUK VARCHAR(50),
FiscalDayOfYear INT,
FiscalWeekOfYear INT,
FiscalMonth INT,
FiscalQuarter INT,
FiscalQuarterName VARCHAR(20),
FiscalYear INT,
FiscalYearName VARCHAR(20),
FiscalMonthYear VARCHAR(6),
FiscalMMYYYY VARCHAR(6),
FiscalFirstDayOfMonth DATE,
FiscalLastDayOfMonth DATE,
FiscalFirstDayOfQuarter DATE,
FiscalLastDayOfQuarter DATE,
FiscalFirstDayOfYear DATE,
FiscalLastDayOfYear DATE
);

CREATE TABLE DimStores (
StoreID INT PRIMARY KEY,
StoreAltID VARCHAR(50),
StoreName VARCHAR(100),
StoreLocation VARCHAR(100),
City VARCHAR(50),
State VARCHAR(50),
Country VARCHAR(50)
);

CREATE TABLE DimTime (
TimeKey INT PRIMARY KEY,
Time TIME,
TimeAltKey VARCHAR(50),
Hour30 VARCHAR(50),
MinuteNumber INT,
SecondNumber INT,
TimeInSecond INT,
HourlyBucket VARCHAR(50),
DayTimeBucketGroupKey VARCHAR(50),
DayTimeBucket VARCHAR(50)
);

CREATE TABLE DimSalesPerson (
SalesPersonKey INT(11) NOT NULL AUTO_INCREMENT,
SalesPersonAltKey VARCHAR(50),
SalesPersonName VARCHAR(100) NOT NULL,
StoreID INT(11) NOT NULL,
City VARCHAR(50),
State VARCHAR(50),
Country VARCHAR(50),
PRIMARY KEY (SalesPersonKey)
);

CREATE TABLE DimProduct(
	ProductKey INT(10) primary key,
    ProductAltKey INT(10),
    ProductName VARCHAR(50),
    ProductCost INT(10)
);

CREATE TABLE FactProductSales (
	TransactionID INT PRIMARY KEY,
	SalesInvoiceNumber INT,
	SalesDateKey INT,
	SalesTimeKey INT,
	SalesTimeAltKey INT(50),
	StoreID INT,
	CustomerID INT,
	ProductID INT,
	SalesPersonID INT,
	Quantity INT,
	TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (StoreID) references dimstores(StoreID),
    FOREIGN KEY (CustomerID) references dimcustomer(CustomerID),
	FOREIGN KEY (ProductID) references dimproduct(ProductKey),
	FOREIGN KEY (SalesPersonID) references dimsalesperson(SalesPersonkey)
);



show tables;