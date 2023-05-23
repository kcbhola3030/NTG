CREATE TABLE test_table(
recordNumber Number(3) NOT NULL,
currentDate DATE NOT NULL
);

DECLARE
    Id_val INT := 1;
    curDate DATE;
BEGIN
    LOOP
        EXIT WHEN Id_val>50;
        curDate := SYSTIMESTAMP;
        INSERT INTO test_table(recordNumber, currentDate) VALUES(Id_val, curDate);
        Id_val := Id_val + 1;
    END LOOP;
END;

CREATE TABLE products(
productID NUMBER(4) NOT NULL,
category CHAR(3) NOT NULL,
detail VARCHAR2(30) NOT NULL,
price NUMBER(10,2) NOT NULL,
stock NUMBER(5) NOT NULL
);

INSERT INTO products(productID,category,detail,price,stock) VALUES('1','V','Vegetable','2000','15');
INSERT INTO products(productID,category,detail,price,stock) VALUES('2','V','Green Vegetable','2500','25');
INSERT INTO products(productID,category,detail,price,stock) VALUES('3','V','Leafy Vegetable','3000','20');
INSERT INTO products(productID,category,detail,price,stock) VALUES('4','F','Fruits','2000','50');
INSERT INTO products(productID,category,detail,price,stock) VALUES('5','G','Groceries','3000','20');

CREATE OR REPLACE PROCEDURE PRICING ( X in number, Y in products.category%TYPE)
AS 
BEGIN
UPDATE products SET price = price + price*(X/100) WHERE Y=category;
END;

BEGIN
    PRICING(4,'V');
END;


CREATE OR REPLACE TYPE person_object AS OBJECT
(
   person_name VARCHAR2(50),
   MEMBER FUNCTION countNoOfWords RETURN NUMBER
)NOT FINAL;

CREATE OR REPLACE TYPE BODY person_object AS 
    MEMBER FUNCTION countNoOfWords RETURN NUMBER IS
       BEGIN
        DBMS_OUTPUT.PUT('LENGTH');
        RETURN LENGTH(person_name)-LENGTH(REPLACE(person_name,' ', ''))+1;
       END;
END;

CREATE TABLE person_table(
    person_name person_object
)

INSERT INTO person_table VALUES (person_object('Razi Parviz Shaikh'));
INSERT INTO person_table VALUES (person_object('Sanjana Kondalwade'));
INSERT INTO person_table VALUES (person_object('Divyashree Kiran Chavan'));

SELECT
    p.person_name.countNoOfWords()
FROM
    person_table p;
    
create or replace TYPE address AS Object(
    city VARCHAR2(40),
    state_ VARCHAR2(40),
    pincode NUMBER(6),
    MEMBER FUNCTION getCity RETURN VARCHAR2,
    MEMBER FUNCTION getState RETURN VARCHAR2,
    MEMBER FUNCTION getPincode RETURN NUMBER,
    MEMBER FUNCTION getNoOfWords(str VARCHAR2) RETURN NUMBER
) NOT FINAL;

CREATE OR REPLACE TYPE BODY address IS 
    MEMBER FUNCTION getPincode RETURN NUMBER IS 
      BEGIN 
        RETURN pincode; 
      END;
    MEMBER FUNCTION getCity RETURN VARCHAR2 IS 
      BEGIN 
        RETURN city; 
      END;
    MEMBER FUNCTION getState RETURN VARCHAR2 IS 
      BEGIN 
        RETURN state_; 
      END;
    MEMBER FUNCTION getNoOfWords(str VARCHAR2) RETURN NUMBER IS 
      BEGIN 
        RETURN LENGTH(str);
      END;
END;

CREATE TABLE addresses(
    person_address address
)

insert into addresses values(address('Solapur', 'Maharashtra', 413006));
insert into addresses values(address('Sangli', 'Maharashtra', 416416));

Select p.person_address.getCity() from addresses p;
Select p.person_address.getState() from addresses p;
Select p.person_address.getPincode() from addresses p;
Select p.person_address.getNoOfWords(p.person_address.getCity()) from addresses p;




CREATE OR REPLACE TYPE course_type AS OBJECT(
    course_id NUMBER,
    course_description VARCHAR2(100)
);

create TYPE course_tb AS TABLE OF course_Type;

CREATE TYPE course  AS OBJECT (
    course_id NUMBER(4),
    course_description VARCHAR2(100)
)

CREATE TABLE course_table(
    course course_type
)

CREATE SEQUENCE customers_seq
 START WITH     100
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;

INSERT INTO course_table VALUES (course_type(customers_seq.NEXTVAL, 'DATABASE MANAGEMENT SYSTEM '));
INSERT INTO course_table VALUES(course_type(customers_seq.NEXTVAL, 'AI AND ML '));
INSERT INTO course_table VALUES(course_type(customers_seq.NEXTVAL, 'COMPUTER NETWORK'));
INSERT INTO course_table VALUES(course_type(customers_seq.NEXTVAL, 'OPERATING SYSTEM'));
INSERT INTO course_table VALUES(course_type(customers_seq.NEXTVAL, 'DEEP LEARNING'));

SELECT * FROM course_table;
SELECT CT.course.course_id, CT.course.course_description FROM course_table CT;


