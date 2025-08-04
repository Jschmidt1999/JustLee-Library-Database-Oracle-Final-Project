/*
========================================================================
  JustLee Library Management System - SQL Build Script		            |
  Version: 2.0								                            |
  Author: S.E.A.L Team Blue - JustLee DBMS Team			            	|
  Purpose: Full database setup with drop, create, seed, and view logic	|
  Normalization Level: 3NF						                        |
========================================================================


===================================================================================================================
  	    				   1_Drop_Tables_All.sql
=================================================================================================================*/

-------------------------------------------------------------------------------------------------------------------
-- Drop tables if they exist for Group
DROP TABLE Borrowing      CASCADE CONSTRAINTS;
DROP TABLE Reservations   CASCADE CONSTRAINTS;
DROP TABLE BookCopies     CASCADE CONSTRAINTS;
DROP TABLE Members        CASCADE CONSTRAINTS;
DROP TABLE Staff          CASCADE CONSTRAINTS;
DROP TABLE Books          CASCADE CONSTRAINTS;
DROP TABLE Authors        CASCADE CONSTRAINTS;
DROP TABLE Categories     CASCADE CONSTRAINTS;
DROP TABLE BorrowingStaff CASCADE CONSTRAINTS;
-------------------------------------------------------------------------------------------------------------------
-- Drop all tables for Class
DROP TABLE BOOKS_1      CASCADE CONSTRAINTS;
DROP TABLE BOOKS_2      CASCADE CONSTRAINTS;
DROP TABLE ORDERS       CASCADE CONSTRAINTS;
DROP TABLE PUBLISHER    CASCADE CONSTRAINTS;
DROP TABLE AUTHOR       CASCADE CONSTRAINTS;
DROP TABLE BOOKS        CASCADE CONSTRAINTS;
DROP TABLE ORDERITEMS   CASCADE CONSTRAINTS;
DROP TABLE BOOKAUTHOR   CASCADE CONSTRAINTS;
DROP TABLE PROMOTION    CASCADE CONSTRAINTS;
DROP TABLE ACCTMANAGER  CASCADE CONSTRAINTS;
DROP TABLE ACCTBONUS    CASCADE CONSTRAINTS;
DROP TABLE TESTING      CASCADE CONSTRAINTS;
DROP TABLE WAREHOUSES   CASCADE CONSTRAINTS;
DROP TABLE PUBLISHER2   CASCADE CONSTRAINTS;
DROP TABLE PUBLISHER3   CASCADE CONSTRAINTS;
DROP TABLE WEBHITS      CASCADE CONSTRAINTS;
DROP TABLE SUPPLIERS    CASCADE CONSTRAINTS;
DROP TABLE CONTACTS     CASCADE CONSTRAINTS;
DROP TABLE EMPLOYEES    CASCADE CONSTRAINTS;
DROP TABLE DEPARTMENT   CASCADE CONSTRAINTS;
DROP TABLE ACCTMANAGER2 CASCADE CONSTRAINTS;
DROP TABLE CUSTOMERS    CASCADE CONSTRAINTS;
-------------------------------------------------------------------------------------------------------------------
-- Drop views if they exist for Class
DROP VIEW CONTACT;
DROP VIEW HOMEWORK13;
DROP VIEW REORDERINFO;
-------------------------------------------------------------------------------------------------------------------
-- Drop views if they exist for Group
DROP VIEW MemberBorrowingHistory    CASCADE CONSTRAINTS;
DROP VIEW MemberActivitySummary     CASCADE CONSTRAINTS;
DROP VIEW BooksByCategory           CASCADE CONSTRAINTS;
DROP VIEW OverdueBooks              CASCADE CONSTRAINTS;
DROP VIEW BorrowingAndReturns       CASCADE CONSTRAINTS;
DROP VIEW WhoReturnedBooksLate      CASCADE CONSTRAINTS;
DROP VIEW ActiveReservations        CASCADE CONSTRAINTS;
DROP VIEW WhatStaffIssuedBorrowings CASCADE CONSTRAINTS;
DROP VIEW StaffBorrowingsLog        CASCADE CONSTRAINTS;
DROP VIEW TopTenBooksBorrowed       CASCADE CONSTRAINTS;
DROP VIEW BooksNeverBorrowed        CASCADE CONSTRAINTS;
DROP VIEW RecentMembersWhoBorrowed  CASCADE CONSTRAINTS;
DROP VIEW PopularAuthors            CASCADE CONSTRAINTS;
DROP VIEW BorrowingDetails          CASCADE CONSTRAINTS;
DROP VIEW MemberBorrowingSummary    CASCADE CONSTRAINTS;
DROP VIEW BookAvailabilityView      CASCADE CONSTRAINTS;
-------------------------------------------------------------------------------------------------------------------
--Queries for tables and views
SELECT TABLE_NAME FROM USER_TABLES;
SELECT VIEW_NAME FROM USER_VIEWS;
-------------------------------------------------------------------------------------------------------------------

/*=================================================================================================================
  				2_Library_Management_System_Tables_Only.sql
=================================================================================================================*/

-------------------------------------------------------------------------------------------------------------------
-- Drop tables if they exist (for rerun purposes)
DROP TABLE Borrowing      CASCADE CONSTRAINTS;
DROP TABLE Reservations   CASCADE CONSTRAINTS;
DROP TABLE BookCopies     CASCADE CONSTRAINTS;
DROP TABLE Members        CASCADE CONSTRAINTS;
DROP TABLE Staff          CASCADE CONSTRAINTS;
DROP TABLE Books          CASCADE CONSTRAINTS;
DROP TABLE Authors        CASCADE CONSTRAINTS;
DROP TABLE Categories     CASCADE CONSTRAINTS;
DROP TABLE BorrowingStaff CASCADE CONSTRAINTS;
-------------------------------------------------------------------------------------------------------------------
-- Display set statements
SET LINESIZE 132;
SET PAGESIZE 50;
-------------------------------------------------------------------------------------------------------------------
-- Create table: Categories
CREATE TABLE Categories (

    CatCode  VARCHAR2(10) PRIMARY KEY,
    CatName  VARCHAR2(30) NOT NULL
    );
-------------------------------------------------------------------------------------------------------------------
CREATE TABLE Authors (  

    AuthorID   NUMBER(5)     PRIMARY KEY,
    FirstName  VARCHAR2(20),
    LastName   VARCHAR2(20)
    );
-------------------------------------------------------------------------------------------------------------------
-- Create table: Books
CREATE TABLE Books (

    BookID     NUMBER(5)     PRIMARY KEY,
    Title      VARCHAR2(40)  NOT NULL,
    AuthorID   NUMBER(5),
    ISBN       VARCHAR2(13)  UNIQUE,
    CatCode    VARCHAR2(10),
    Publisher  VARCHAR2(30),

        CONSTRAINT Books_CatCode_FK  FOREIGN KEY (CatCode)  REFERENCES Categories(CatCode),
        CONSTRAINT Books_AuthorID_FK FOREIGN KEY (AuthorID) REFERENCES    Authors(AuthorID)
    );
-------------------------------------------------------------------------------------------------------------------
-- Create table: BookCopies
CREATE TABLE BookCopies (

    CopyID  NUMBER(5)    PRIMARY KEY,
    Status  VARCHAR2(1)  DEFAULT 'I',
    BookID  NUMBER(5),

        CONSTRAINT BookCopies_BookID_FK FOREIGN KEY (BookID) REFERENCES Books(BookID)
    );
-------------------------------------------------------------------------------------------------------------------
-- Create table: Members
CREATE TABLE Members (

    MemberID        NUMBER(5)     PRIMARY KEY,
    FirstName       VARCHAR2(20),
    LastName        VARCHAR2(20),
    Phone           VARCHAR2(15),
    Email           VARCHAR2(30),
    MembershipDate  DATE
    );
-------------------------------------------------------------------------------------------------------------------
-- Create table: Staff
CREATE TABLE Staff (

    StaffID    NUMBER(3)     PRIMARY KEY,
    FirstName  VARCHAR2(20),
    LastName   VARCHAR2(20),
    JobTitle   VARCHAR2(20),
    Salary     NUMBER(7, 2),
    StartDate  DATE,
    EndDate    DATE          DEFAULT NULL
    );
-------------------------------------------------------------------------------------------------------------------
-- Create table: Borrowing
CREATE TABLE Borrowing (

    BorrowingID      NUMBER(5)  PRIMARY KEY,
    MemberID         NUMBER(5)  NOT NULL,
    CopyID           NUMBER(5)  NOT NULL,
    ReservationDate  DATE,
    DueDate          DATE,
    ReturnDate       DATE,
    IsLate           CHAR(1)    DEFAULT 'N' CHECK (IsLate IN ('Y', 'N')),
    StaffID          NUMBER(3),

        CONSTRAINT Borrowing_MemberID_FK FOREIGN KEY (MemberID) REFERENCES    Members(MemberID),
        CONSTRAINT Borrowing_CopyID_FK   FOREIGN KEY (CopyID)   REFERENCES BookCopies(CopyID),
        CONSTRAINT Borrowing_StaffID_FK  FOREIGN KEY (StaffID)  REFERENCES      Staff(StaffID)
    );
-------------------------------------------------------------------------------------------------------------------
-- Create table: Reservations
CREATE TABLE Reservations (

    ReservationID  NUMBER(5)  PRIMARY KEY,
    MemberID       NUMBER(5)  NOT NULL,
    BookID         NUMBER(5)  NOT NULL,
    BorrowDate     DATE       DEFAULT SYSDATE,
    DueDate        DATE,
    CheckoutDate   DATE,

        CONSTRAINT Reservations_MemberID_FK FOREIGN KEY (MemberID) REFERENCES Members(MemberID),
        CONSTRAINT Reservations_BookID_FK   FOREIGN KEY (BookID)   REFERENCES   Books(BookID)
    );
-------------------------------------------------------------------------------------------------------------------
CREATE TABLE BorrowingStaff (   

    StaffID      NUMBER(3),
    BorrowingID  NUMBER(5),
    ActionType   VARCHAR2(10),
    ActionDate   DATE,

        CONSTRAINT BS_StaffID_FK     FOREIGN KEY (StaffID)     REFERENCES     Staff(StaffID),
        CONSTRAINT BS_BorrowingID_FK FOREIGN KEY (BorrowingID) REFERENCES Borrowing(BorrowingID)
    );  
-------------------------------------------------------------------------------------------------------------------

/*=================================================================================================================
 				 3_Library_Management_System_Inserts_Only.sql
=================================================================================================================*/

-------------------------------------------------------------------------------------------------------------------
INSERT INTO Categories VALUES ('FIC', 'Fiction');
INSERT INTO Categories VALUES ('SCI', 'Science');
INSERT INTO Categories VALUES ('HIS', 'History');
INSERT INTO Categories VALUES ('BIO', 'Biography');
INSERT INTO Categories VALUES ('MYS', 'Mystery');
INSERT INTO Categories VALUES ('ROM', 'Romance');
INSERT INTO Categories VALUES ('TEC', 'Technology');
INSERT INTO Categories VALUES ('ART', 'Art');
INSERT INTO Categories VALUES ('POE', 'Poetry');
INSERT INTO Categories VALUES ('PHI', 'Philosophy');
INSERT INTO Categories VALUES ('TECH', 'Technology and Coding');
INSERT INTO Categories VALUES ('PHIL', 'Philosophy and Ethics');
INSERT INTO Categories VALUES ('FAN', 'Fantasy Fiction');
INSERT INTO Categories VALUES ('NF', 'Non-Fiction');
INSERT INTO Categories VALUES ('SELF', 'Self-Help and Wellness');
INSERT INTO Categories VALUES ('PSY', 'Psychology and Behavior');
-------------------------------------------------------------------------------------------------------------------
INSERT INTO Authors VALUES (301, 'George', 'Orwell');
INSERT INTO Authors VALUES (302, 'Robert C.', 'Martin');
INSERT INTO Authors VALUES (303, 'Harper', 'Lee');
INSERT INTO Authors VALUES (304, 'F. Scott', 'Fitzgerald');
INSERT INTO Authors VALUES (305, 'Herman', 'Melville');
INSERT INTO Authors VALUES (306, 'Jane', 'Austen');
INSERT INTO Authors VALUES (307, 'Aldous', 'Huxley');
INSERT INTO Authors VALUES (308, 'Leo', 'Tolstoy');
INSERT INTO Authors VALUES (309, 'J.D.', 'Salinger');
INSERT INTO Authors VALUES (310, 'Fyodor', 'Dostoevsky');
INSERT INTO Authors VALUES (311, 'Andy', 'Hunt');
INSERT INTO Authors VALUES (312, 'Emily', 'Bronte');
INSERT INTO Authors VALUES (313, 'Charles', 'Dickens');
INSERT INTO Authors VALUES (314, 'Ray', 'Bradbury');
INSERT INTO Authors VALUES (315, 'Charlotte', 'Bronte');
INSERT INTO Authors VALUES (316, 'Robert', 'C. Martin');
INSERT INTO Authors VALUES (317, 'Mary', 'Shelley');
INSERT INTO Authors VALUES (318, 'Bram', 'Stoker');
INSERT INTO Authors VALUES (319, 'Homer', 'Simpson');
INSERT INTO Authors VALUES (320, 'Dante', 'Alighieri');
INSERT INTO Authors VALUES (321, 'Victor', 'Hugo');
INSERT INTO Authors VALUES (322, 'Oscar', 'Wilde');
INSERT INTO Authors VALUES (323, 'Kurt', 'Vonnegut');
INSERT INTO Authors VALUES (324, 'Joseph', 'Heller');
INSERT INTO Authors VALUES (325, 'Ernest', 'Hemingway');
INSERT INTO Authors VALUES (326, 'John', 'Steinbeck');
INSERT INTO Authors VALUES (327, 'Cormac', 'McCarthy');
INSERT INTO Authors VALUES (328, 'Sylvia', 'Plath');
INSERT INTO Authors VALUES (329, 'Albert', 'Camus');
INSERT INTO Authors VALUES (330, 'Franz', 'Kafka');
INSERT INTO Authors VALUES (331, 'James', 'Joyce');
INSERT INTO Authors VALUES (332, 'H.G.', 'Wells');
INSERT INTO Authors VALUES (333, 'Jules', 'Verne');
INSERT INTO Authors VALUES (334, 'Anthony', 'Hawke');
INSERT INTO Authors VALUES (335, 'Johnathan', 'Query');
INSERT INTO Authors VALUES (336, 'Samuel', 'Soloman');
INSERT INTO Authors VALUES (337, 'Nathan', 'Hall');
INSERT INTO Authors VALUES (338, 'Quedric', 'Simone');
INSERT INTO Authors VALUES (339, 'Connor', 'Bailey');
INSERT INTO Authors VALUES (340, 'Theodore', 'Spade');
INSERT INTO Authors VALUES (341, 'Chuck', 'Hyde');
INSERT INTO Authors VALUES (342, 'Caroline', 'Tenor');
INSERT INTO Authors VALUES (343, 'Sadar', 'Copola');
INSERT INTO Authors VALUES (344, 'Winnie', 'Spade');
INSERT INTO Authors VALUES (345, 'Mitch', 'Holland');
INSERT INTO Authors VALUES (346, 'Arthur', 'Hackwood');
INSERT INTO Authors VALUES (347, 'Jenn', 'Williams');
INSERT INTO Authors VALUES (348, 'Carter', 'Blithe');
INSERT INTO Authors VALUES (349, 'Hasten', 'Milley');
INSERT INTO Authors VALUES (350, 'Suzanne', 'Grady');
-------------------------------------------------------------------------------------------------------------------
INSERT INTO Books VALUES (5000, '1984', 301, '9780000000000', 'FIC', 'Secker and Warburg');
INSERT INTO Books VALUES (5001, 'Clean Code', 302, '9780000000001', 'TECH', 'Prentice Hall');
INSERT INTO Books VALUES (5002, 'To Kill a Mockingbird', 303, '9780000000002', 'PHIL', 'J.B. Lippincott and Co.');
INSERT INTO Books VALUES (5003, 'The Great Gatsby', 304, '9780000000003', 'FAN', 'Scribner');
INSERT INTO Books VALUES (5004, 'Moby Dick', 305, '9780000000004', 'NF', 'Harper and Brothers');
INSERT INTO Books VALUES (5005, 'Pride and Prejudice', 306, '9780000000005', 'SELF', 'T. Egerton');
INSERT INTO Books VALUES (5006, 'Brave New World', 307, '9780000000006', 'PSY', 'Chatto and Windus');
INSERT INTO Books VALUES (5007, 'War and Peace', 308, '9780000000007', 'FIC', 'The Russian Messenger');
INSERT INTO Books VALUES (5008, 'The Catcher in the Rye', 309, '9780000000008', 'TECH', 'Little, Brown and Company');
INSERT INTO Books VALUES (5009, 'Crime and Punishment', 310, '9780000000009', 'PHIL', 'Vintage');
INSERT INTO Books VALUES (5010, 'The Pragmatic Programmer', 311, '9780000000010', 'FAN', 'Secker and Warburg');
INSERT INTO Books VALUES (5011, 'Emma', 306, '9780000000011', 'NF', 'Prentice Hall');
INSERT INTO Books VALUES (5012, 'Animal Farm', 301, '9780000000012', 'SELF', 'J.B. Lippincott and Co.');
INSERT INTO Books VALUES (5013, 'Sense and Sensibility', 306, '9780000000013', 'PSY', 'Scribner');
INSERT INTO Books VALUES (5014, 'Fahrenheit 451', 314, '9780000000014', 'FIC', 'Harper and Brothers');
INSERT INTO Books VALUES (5015, 'Jane Eyre', 315, '9780000000015', 'TECH', 'T. Egerton');
INSERT INTO Books VALUES (5016, 'The Brothers Karamazov', 310, '9780000000016', 'PHIL', 'Chatto and Windus');
INSERT INTO Books VALUES (5017, 'The Clean Coder', 302, '9780000000017', 'FAN', 'The Russian Messenger');
INSERT INTO Books VALUES (5018, 'Wuthering Heights', 312, '9780000000018', 'NF', 'Little, Brown and Company');
INSERT INTO Books VALUES (5019, 'Great Expectations', 313, '9780000000019', 'SELF', 'Vintage');
INSERT INTO Books VALUES (5020, 'The Hobbit', 333, '9780000000020', 'PSY', 'Secker and Warburg');
INSERT INTO Books VALUES (5021, 'Lord of the Flies', 313, '9780000000021', 'FIC', 'Prentice Hall');
INSERT INTO Books VALUES (5022, 'A Tale of Two Cities', 313, '9780000000022', 'TECH', 'J.B. Lippincott and Co.');
INSERT INTO Books VALUES (5023, 'The Scarlet Letter', 313, '9780000000023', 'PHIL', 'Scribner');
INSERT INTO Books VALUES (5024, 'Frankenstein', 317, '9780000000024', 'FAN', 'Harper and Brothers');
INSERT INTO Books VALUES (5025, 'Dracula', 318, '9780000000025', 'NF', 'T. Egerton');
INSERT INTO Books VALUES (5026, 'The Odyssey', 319, '9780000000026', 'SELF', 'Chatto and Windus');
INSERT INTO Books VALUES (5027, 'The Iliad', 319, '9780000000027', 'PSY', 'The Russian Messenger');
INSERT INTO Books VALUES (5028, 'The Divine Comedy', 320, '9780000000028', 'FIC', 'Little, Brown and Company');
INSERT INTO Books VALUES (5029, 'Les Misérables', 321, '9780000000029', 'TECH', 'Vintage');
INSERT INTO Books VALUES (5030, 'The Picture of Dorian Gray', 322, '9780000000030', 'PHIL', 'Secker and Warburg');
INSERT INTO Books VALUES (5031, 'Slaughterhouse-Five', 323, '9780000000031', 'FAN', 'Prentice Hall');
INSERT INTO Books VALUES (5032, 'Catch-22', 324, '9780000000032', 'NF', 'J.B. Lippincott and Co.');
INSERT INTO Books VALUES (5033, 'The Sun Also Rises', 325, '9780000000033', 'SELF', 'Scribner');
INSERT INTO Books VALUES (5034, 'Of Mice and Men', 326, '9780000000034', 'PSY', 'Harper and Brothers');
INSERT INTO Books VALUES (5035, 'The Old Man and the Sea', 325, '9780000000035', 'FIC', 'T. Egerton');
INSERT INTO Books VALUES (5036, 'The Road', 327, '9780000000036', 'TECH', 'Chatto and Windus');
INSERT INTO Books VALUES (5037, 'No Country for Old Men', 327, '9780000000037', 'PHIL', 'The Russian Messenger');
INSERT INTO Books VALUES (5038, 'The Bell Jar', 328, '9780000000038', 'FAN', 'Little, Brown and Company');
INSERT INTO Books VALUES (5039, 'The Stranger', 329, '9780000000039', 'NF', 'Vintage');
INSERT INTO Books VALUES (5040, 'The Metamorphosis', 330, '9780000000040', 'SELF', 'Secker and Warburg');
INSERT INTO Books VALUES (5041, 'The Trial', 330, '9780000000041', 'PSY', 'Prentice Hall');
INSERT INTO Books VALUES (5042, 'Ulysses', 331, '9780000000042', 'FIC', 'J.B. Lippincott and Co.');
INSERT INTO Books VALUES (5043, 'Dubliners', 331, '9780000000043', 'TECH', 'Scribner');
INSERT INTO Books VALUES (5044, 'A Portrait of the Artist as a Young Man', 331, '9780000000044', 'PHIL', 'Harper and Brothers');
INSERT INTO Books VALUES (5045, 'The Time Machine', 332, '9780000000045', 'FAN', 'T. Egerton');
INSERT INTO Books VALUES (5046, 'The War of the Worlds', 332, '9780000000046', 'NF', 'Chatto and Windus');
INSERT INTO Books VALUES (5047, 'Journey to the Center of the Earth', 333, '9780000000047', 'SELF', 'The Russian Messenger');
INSERT INTO Books VALUES (5048, 'Around the World in 80 Days', 333, '9780000000048', 'PSY', 'Little, Brown and Company');
INSERT INTO Books VALUES (5049, '20,000 Leagues Under the Sea', 333, '9780000000049', 'FIC', 'Vintage');
-------------------------------------------------------------------------------------------------------------------
INSERT INTO Members VALUES (401, 'Emma', 'White', '(646) 229-5494', 'emma.white@gmail.com', TO_DATE('26-OCT-2024', 'DD-MON-YYYY'));
INSERT INTO Members VALUES (402, 'Benjamin', 'Hernandez', '(814) 229-9042', 'benjamin.hernandez@gmail.com', TO_DATE('09-FEB-2024', 'DD-MON-YYYY'));
INSERT INTO Members VALUES (403, 'Evelyn', 'Hernandez', '(580) 590-8216', 'evelyn.hernandez@outlook.com', TO_DATE('17-APR-2019', 'DD-MON-YYYY'));
INSERT INTO Members VALUES (404, 'Liam', 'Martinez', '(982) 589-2869', 'liam.martinez@gmail.com', TO_DATE('21-OCT-2020', 'DD-MON-YYYY'));
INSERT INTO Members VALUES (405, 'Olivia', 'Martin', '(744) 802-1878', 'olivia.martin@yahoo.com', TO_DATE('17-JAN-2019', 'DD-MON-YYYY'));
INSERT INTO Members VALUES (406, 'Olivia', 'Davis', '(221) 671-7818', 'olivia.davis@yahoo.com', TO_DATE('06-JUN-2023', 'DD-MON-YYYY'));
INSERT INTO Members VALUES (407, 'Charlotte', 'Thomas', '(553) 404-8025', 'charlotte.thomas@outlook.com', TO_DATE('24-DEC-2021', 'DD-MON-YYYY'));
INSERT INTO Members VALUES (408, 'Liam', 'Lee', '(857) 201-4404', 'liam.lee@yahoo.com', TO_DATE('08-NOV-2019', 'DD-MON-YYYY'));
INSERT INTO Members VALUES (409, 'Olivia', 'Garcia', '(345) 277-2229', 'olivia.garcia@yahoo.com', TO_DATE('07-JAN-2018', 'DD-MON-YYYY'));
INSERT INTO Members VALUES (410, 'Amelia', 'White', '(708) 581-5771', 'amelia.white@gmail.com', TO_DATE('15-AUG-2019', 'DD-MON-YYYY'));
INSERT INTO Members VALUES (411, 'Scarlett', 'Hernandez', '(819) 980-8438', 'scarlett.hernandez@gmail.com', TO_DATE('23-OCT-2022', 'DD-MON-YYYY'));
INSERT INTO Members VALUES (412, 'Isabella', 'Perez', '(703) 777-4241', 'isabella.perez@libmail.org', TO_DATE('21-OCT-2018', 'DD-MON-YYYY'));
INSERT INTO Members VALUES (413, 'Lucas', 'Perez', '(252) 372-3330', 'lucas.perez@gmail.com', TO_DATE('02-JUN-2018', 'DD-MON-YYYY'));
INSERT INTO Members VALUES (414, 'Mason', 'Lee', '(866) 944-5728', 'mason.lee@libmail.org', TO_DATE('14-NOV-2018', 'DD-MON-YYYY'));
INSERT INTO Members VALUES (415, 'Scarlett', 'Wilson', '(378) 612-9847', 'scarlett.wilson@libmail.org', TO_DATE('23-JAN-2021', 'DD-MON-YYYY'));
INSERT INTO Members VALUES (416, 'Sebastian', 'Johnson', '(542) 852-6280', 'sebastian.johnson@outlook.com', TO_DATE('08-MAR-2018', 'DD-MON-YYYY'));
INSERT INTO Members VALUES (417, 'Lucas', 'Thompson', '(956) 981-1339', 'lucas.thompson@outlook.com', TO_DATE('12-JAN-2022', 'DD-MON-YYYY'));
INSERT INTO Members VALUES (418, 'Grace', 'Sanchez', '(279) 581-9502', 'grace.sanchez@libmail.org', TO_DATE('30-MAY-2024', 'DD-MON-YYYY'));
INSERT INTO Members VALUES (419, 'Elijah', 'Martin', '(546) 750-9056', 'elijah.martin@gmail.com', TO_DATE('16-APR-2021', 'DD-MON-YYYY'));
INSERT INTO Members VALUES (420, 'Ethan', 'Lopez', '(428) 786-2713', 'ethan.lopez@yahoo.com', TO_DATE('22-APR-2020', 'DD-MON-YYYY'));
INSERT INTO Members VALUES (421, 'Scarlett', 'Taylor', '(395) 778-7561', 'scarlett.taylor@gmail.com', TO_DATE('08-MAR-2021', 'DD-MON-YYYY'));
INSERT INTO Members VALUES (422, 'Mia', 'Martinez', '(431) 218-7622', 'mia.martinez@gmail.com', TO_DATE('08-AUG-2022', 'DD-MON-YYYY'));
INSERT INTO Members VALUES (423, 'Benjamin', 'Thomas', '(523) 155-4073', 'benjamin.thomas@outlook.com', TO_DATE('11-MAY-2022', 'DD-MON-YYYY'));
INSERT INTO Members VALUES (424, 'James', 'Perez', '(552) 878-1845', 'james.perez@yahoo.com', TO_DATE('14-NOV-2019', 'DD-MON-YYYY'));
INSERT INTO Members VALUES (425, 'Ava', 'Hernandez', '(548) 815-8941', 'ava.hernandez@gmail.com', TO_DATE('15-MAR-2018', 'DD-MON-YYYY'));
INSERT INTO Members VALUES (426, 'Ella', 'Lee', '(918) 345-3594', 'ella.lee@outlook.com', TO_DATE('08-NOV-2021', 'DD-MON-YYYY'));
INSERT INTO Members VALUES (427, 'Benjamin', 'Anderson', '(195) 330-2858', 'benjamin.anderson@libmail.org', TO_DATE('17-AUG-2024', 'DD-MON-YYYY'));
INSERT INTO Members VALUES (428, 'Ella', 'Jones', '(610) 833-5781', 'ella.jones@outlook.com', TO_DATE('27-NOV-2020', 'DD-MON-YYYY'));
INSERT INTO Members VALUES (429, 'James', 'Taylor', '(349) 567-3369', 'james.taylor@libmail.org', TO_DATE('03-MAY-2019', 'DD-MON-YYYY'));
INSERT INTO Members VALUES (430, 'Sebastian', 'Moore', '(864) 239-2143', 'sebastian.moore@outlook.com', TO_DATE('29-MAY-2023', 'DD-MON-YYYY'));
INSERT INTO Members VALUES (431, 'Harper', 'Martinez', '(940) 102-5634', 'harper.martinez@outlook.com', TO_DATE('11-NOV-2023', 'DD-MON-YYYY'));
INSERT INTO Members VALUES (432, 'Evelyn', 'Thompson', '(601) 986-3434', 'evelyn.thompson@libmail.org', TO_DATE('08-OCT-2021', 'DD-MON-YYYY'));
INSERT INTO Members VALUES (433, 'Logan', 'Lopez', '(665) 881-9903', 'logan.lopez@libmail.org', TO_DATE('09-MAR-2021', 'DD-MON-YYYY'));
INSERT INTO Members VALUES (434, 'Mia', 'Miller', '(814) 344-7274', 'mia.miller@yahoo.com', TO_DATE('28-DEC-2023', 'DD-MON-YYYY'));
INSERT INTO Members VALUES (435, 'Ethan', 'Johnson', '(425) 862-8749', 'ethan.johnson@libmail.org', TO_DATE('13-SEP-2020', 'DD-MON-YYYY'));
INSERT INTO Members VALUES (436, 'Jack', 'Perez', '(255) 607-1606', 'jack.perez@yahoo.com', TO_DATE('07-JUL-2021', 'DD-MON-YYYY'));
INSERT INTO Members VALUES (437, 'Evelyn', 'Lopez', '(990) 202-8213', 'evelyn.lopez@gmail.com', TO_DATE('06-SEP-2021', 'DD-MON-YYYY'));
INSERT INTO Members VALUES (438, 'Amelia', 'Smith', '(839) 247-7717', 'amelia.smith@yahoo.com', TO_DATE('11-JUL-2018', 'DD-MON-YYYY'));
INSERT INTO Members VALUES (439, 'Isabella', 'Lopez', '(738) 809-7512', 'isabella.lopez@gmail.com', TO_DATE('18-DEC-2023', 'DD-MON-YYYY'));
INSERT INTO Members VALUES (440, 'Jack', 'Jackson', '(489) 424-8994', 'jack.jackson@gmail.com', TO_DATE('28-APR-2022', 'DD-MON-YYYY'));
INSERT INTO Members VALUES (441, 'Jack', 'Hernandez', '(332) 864-2480', 'jack.hernandez@libmail.org', TO_DATE('05-NOV-2024', 'DD-MON-YYYY'));
INSERT INTO Members VALUES (442, 'Grace', 'Perez', '(820) 993-2646', 'grace.perez@libmail.org', TO_DATE('02-MAR-2019', 'DD-MON-YYYY'));
INSERT INTO Members VALUES (443, 'Mason', 'Smith', '(147) 432-1919', 'mason.smith@outlook.com', TO_DATE('05-JUL-2020', 'DD-MON-YYYY'));
INSERT INTO Members VALUES (444, 'Ethan', 'Jones', '(350) 643-7751', 'ethan.jones@yahoo.com', TO_DATE('11-MAR-2019', 'DD-MON-YYYY'));
INSERT INTO Members VALUES (445, 'Olivia', 'Lee', '(991) 491-4945', 'olivia.lee@libmail.org', TO_DATE('22-MAY-2024', 'DD-MON-YYYY'));
INSERT INTO Members VALUES (446, 'Ava', 'Davis', '(572) 753-5161', 'ava.davis@libmail.org', TO_DATE('15-OCT-2019', 'DD-MON-YYYY'));
INSERT INTO Members VALUES (447, 'Emma', 'Thomas', '(394) 793-9955', 'emma.thomas@yahoo.com', TO_DATE('08-JUL-2018', 'DD-MON-YYYY'));
INSERT INTO Members VALUES (448, 'Logan', 'Martin', '(406) 754-7951', 'logan.martin@outlook.com', TO_DATE('13-MAR-2021', 'DD-MON-YYYY'));
INSERT INTO Members VALUES (449, 'Mason', 'Miller', '(493) 973-8916', 'mason.miller@gmail.com', TO_DATE('30-AUG-2019', 'DD-MON-YYYY'));
INSERT INTO Members VALUES (450, 'Evelyn', 'Gonzalez', '(688) 402-5837', 'evelyn.gonzalez@gmail.com', TO_DATE('04-NOV-2024', 'DD-MON-YYYY'));
-------------------------------------------------------------------------------------------------------------------
INSERT INTO Reservations VALUES (1001, 401, 5000, TO_DATE('17-OCT-23','DD-MON-YY'), TO_DATE('25-APR-22','DD-MON-YY'), NULL);
INSERT INTO Reservations VALUES (1002, 402, 5001, TO_DATE('26-JAN-22','DD-MON-YY'), TO_DATE('30-JAN-24','DD-MON-YY'), NULL);
INSERT INTO Reservations VALUES (1003, 403, 5002, TO_DATE('09-OCT-22','DD-MON-YY'), TO_DATE('08-SEP-22','DD-MON-YY'), NULL);
INSERT INTO Reservations VALUES (1004, 404, 5003, TO_DATE('17-AUG-22','DD-MON-YY'), TO_DATE('23-MAY-22','DD-MON-YY'), NULL);
INSERT INTO Reservations VALUES (1005, 405, 5004, TO_DATE('25-JAN-24','DD-MON-YY'), TO_DATE('15-APR-22','DD-MON-YY'), NULL);
INSERT INTO Reservations VALUES (1006, 406, 5005, TO_DATE('24-NOV-23','DD-MON-YY'), TO_DATE('29-JAN-24','DD-MON-YY'), NULL);
INSERT INTO Reservations VALUES (1007, 407, 5006, TO_DATE('13-JUL-23','DD-MON-YY'), TO_DATE('31-MAR-22','DD-MON-YY'), NULL);
INSERT INTO Reservations VALUES (1008, 408, 5007, TO_DATE('28-AUG-23','DD-MON-YY'), TO_DATE('09-MAR-23','DD-MON-YY'), NULL);
INSERT INTO Reservations VALUES (1009, 409, 5008, TO_DATE('02-FEB-22','DD-MON-YY'), TO_DATE('31-JAN-22','DD-MON-YY'), NULL);
INSERT INTO Reservations VALUES (1010, 410, 5009, TO_DATE('06-APR-22','DD-MON-YY'), TO_DATE('12-AUG-22','DD-MON-YY'), NULL);
INSERT INTO Reservations VALUES (1011, 411, 5010, TO_DATE('27-AUG-22','DD-MON-YY'), TO_DATE('02-JUN-23','DD-MON-YY'), TO_DATE('09-SEP-23','DD-MON-YY'));
INSERT INTO Reservations VALUES (1012, 412, 5011, TO_DATE('28-JAN-22','DD-MON-YY'), TO_DATE('29-JUL-23','DD-MON-YY'), TO_DATE('23-JUL-22','DD-MON-YY'));
INSERT INTO Reservations VALUES (1013, 413, 5012, TO_DATE('04-JAN-24','DD-MON-YY'), TO_DATE('28-OCT-23','DD-MON-YY'), TO_DATE('20-DEC-23','DD-MON-YY'));
INSERT INTO Reservations VALUES (1014, 414, 5013, TO_DATE('13-JUL-23','DD-MON-YY'), TO_DATE('06-MAR-23','DD-MON-YY'), TO_DATE('14-AUG-22','DD-MON-YY'));
INSERT INTO Reservations VALUES (1015, 415, 5014, TO_DATE('05-APR-23','DD-MON-YY'), TO_DATE('27-AUG-23','DD-MON-YY'), TO_DATE('12-OCT-22','DD-MON-YY'));
INSERT INTO Reservations VALUES (1016, 416, 5015, TO_DATE('08-APR-24','DD-MON-YY'), TO_DATE('09-JUN-24','DD-MON-YY'), TO_DATE('07-JAN-22','DD-MON-YY'));
INSERT INTO Reservations VALUES (1017, 417, 5016, TO_DATE('17-FEB-24','DD-MON-YY'), TO_DATE('05-APR-24','DD-MON-YY'), TO_DATE('13-JUN-22','DD-MON-YY'));
INSERT INTO Reservations VALUES (1018, 418, 5017, TO_DATE('16-DEC-23','DD-MON-YY'), TO_DATE('09-MAR-23','DD-MON-YY'), TO_DATE('15-DEC-22','DD-MON-YY'));
INSERT INTO Reservations VALUES (1019, 419, 5018, TO_DATE('12-OCT-22','DD-MON-YY'), TO_DATE('09-JUN-22','DD-MON-YY'), TO_DATE('09-AUG-22','DD-MON-YY'));
INSERT INTO Reservations VALUES (1020, 420, 5019, TO_DATE('21-FEB-24','DD-MON-YY'), TO_DATE('11-DEC-22','DD-MON-YY'), TO_DATE('15-APR-22','DD-MON-YY'));
INSERT INTO Reservations VALUES (1021, 421, 5020, TO_DATE('05-APR-22','DD-MON-YY'), TO_DATE('25-JAN-23','DD-MON-YY'), TO_DATE('10-APR-22','DD-MON-YY'));
INSERT INTO Reservations VALUES (1022, 422, 5021, TO_DATE('03-JAN-23','DD-MON-YY'), TO_DATE('17-MAY-24','DD-MON-YY'), TO_DATE('19-DEC-22','DD-MON-YY'));
INSERT INTO Reservations VALUES (1023, 423, 5022, TO_DATE('11-SEP-23','DD-MON-YY'), TO_DATE('28-SEP-22','DD-MON-YY'), TO_DATE('06-APR-24','DD-MON-YY'));
INSERT INTO Reservations VALUES (1024, 424, 5023, TO_DATE('14-FEB-22','DD-MON-YY'), TO_DATE('18-JAN-24','DD-MON-YY'), TO_DATE('16-APR-23','DD-MON-YY'));
INSERT INTO Reservations VALUES (1025, 425, 5024, TO_DATE('04-JUL-23','DD-MON-YY'), TO_DATE('08-MAY-22','DD-MON-YY'), TO_DATE('23-JAN-23','DD-MON-YY'));
INSERT INTO Reservations VALUES (1026, 426, 5025, TO_DATE('22-MAR-22','DD-MON-YY'), TO_DATE('20-JUL-23','DD-MON-YY'), TO_DATE('28-OCT-22','DD-MON-YY'));
INSERT INTO Reservations VALUES (1027, 427, 5026, TO_DATE('29-APR-24','DD-MON-YY'), TO_DATE('06-OCT-23','DD-MON-YY'), TO_DATE('26-SEP-23','DD-MON-YY'));
INSERT INTO Reservations VALUES (1028, 428, 5027, TO_DATE('01-JUN-24','DD-MON-YY'), TO_DATE('06-JAN-23','DD-MON-YY'), TO_DATE('15-AUG-23','DD-MON-YY'));
INSERT INTO Reservations VALUES (1029, 429, 5028, TO_DATE('16-JUL-22','DD-MON-YY'), TO_DATE('23-DEC-23','DD-MON-YY'), TO_DATE('13-MAR-22','DD-MON-YY'));
INSERT INTO Reservations VALUES (1030, 430, 5029, TO_DATE('16-FEB-22','DD-MON-YY'), TO_DATE('09-NOV-23','DD-MON-YY'), TO_DATE('22-AUG-22','DD-MON-YY'));
INSERT INTO Reservations VALUES (1031, 431, 5030, TO_DATE('02-MAR-24','DD-MON-YY'), TO_DATE('24-OCT-22','DD-MON-YY'), TO_DATE('23-MAR-22','DD-MON-YY'));
INSERT INTO Reservations VALUES (1032, 432, 5031, TO_DATE('25-MAY-24','DD-MON-YY'), TO_DATE('27-AUG-22','DD-MON-YY'), TO_DATE('06-JUN-24','DD-MON-YY'));
INSERT INTO Reservations VALUES (1033, 433, 5032, TO_DATE('14-APR-22','DD-MON-YY'), TO_DATE('25-JAN-23','DD-MON-YY'), TO_DATE('12-OCT-22','DD-MON-YY'));
INSERT INTO Reservations VALUES (1034, 434, 5033, TO_DATE('10-APR-23','DD-MON-YY'), TO_DATE('13-OCT-23','DD-MON-YY'), TO_DATE('04-MAY-24','DD-MON-YY'));
INSERT INTO Reservations VALUES (1035, 435, 5034, TO_DATE('09-JAN-23','DD-MON-YY'), TO_DATE('16-JUN-22','DD-MON-YY'), TO_DATE('15-JAN-23','DD-MON-YY'));
INSERT INTO Reservations VALUES (1036, 436, 5035, TO_DATE('30-DEC-22','DD-MON-YY'), TO_DATE('03-AUG-22','DD-MON-YY'), TO_DATE('18-NOV-23','DD-MON-YY'));
INSERT INTO Reservations VALUES (1037, 437, 5036, TO_DATE('01-OCT-22','DD-MON-YY'), TO_DATE('20-DEC-23','DD-MON-YY'), TO_DATE('01-DEC-23','DD-MON-YY'));
INSERT INTO Reservations VALUES (1038, 438, 5037, TO_DATE('26-OCT-23','DD-MON-YY'), TO_DATE('15-MAR-22','DD-MON-YY'), TO_DATE('16-SEP-23','DD-MON-YY'));
INSERT INTO Reservations VALUES (1039, 439, 5038, TO_DATE('13-OCT-23','DD-MON-YY'), TO_DATE('25-JUN-22','DD-MON-YY'), TO_DATE('01-JUL-23','DD-MON-YY'));
INSERT INTO Reservations VALUES (1040, 440, 5039, TO_DATE('17-JAN-24','DD-MON-YY'), TO_DATE('08-SEP-22','DD-MON-YY'), TO_DATE('17-JUN-22','DD-MON-YY'));
INSERT INTO Reservations VALUES (1041, 441, 5040, TO_DATE('19-APR-23','DD-MON-YY'), TO_DATE('24-JAN-23','DD-MON-YY'), TO_DATE('04-OCT-22','DD-MON-YY'));
INSERT INTO Reservations VALUES (1042, 442, 5041, TO_DATE('18-OCT-23','DD-MON-YY'), TO_DATE('06-DEC-23','DD-MON-YY'), TO_DATE('25-JUL-23','DD-MON-YY'));
INSERT INTO Reservations VALUES (1043, 443, 5042, TO_DATE('13-AUG-22','DD-MON-YY'), TO_DATE('03-DEC-23','DD-MON-YY'), TO_DATE('29-NOV-22','DD-MON-YY'));
INSERT INTO Reservations VALUES (1044, 444, 5043, TO_DATE('13-MAY-24','DD-MON-YY'), TO_DATE('26-FEB-24','DD-MON-YY'), TO_DATE('05-MAR-24','DD-MON-YY'));
INSERT INTO Reservations VALUES (1045, 445, 5044, TO_DATE('27-FEB-22','DD-MON-YY'), TO_DATE('23-AUG-22','DD-MON-YY'), TO_DATE('21-APR-24','DD-MON-YY'));
INSERT INTO Reservations VALUES (1046, 446, 5045, TO_DATE('02-FEB-22','DD-MON-YY'), TO_DATE('04-APR-24','DD-MON-YY'), TO_DATE('20-NOV-22','DD-MON-YY'));
INSERT INTO Reservations VALUES (1047, 447, 5046, TO_DATE('15-FEB-23','DD-MON-YY'), TO_DATE('02-OCT-22','DD-MON-YY'), TO_DATE('09-MAR-22','DD-MON-YY'));
INSERT INTO Reservations VALUES (1048, 448, 5047, TO_DATE('05-AUG-22','DD-MON-YY'), TO_DATE('04-AUG-23','DD-MON-YY'), TO_DATE('16-JUN-24','DD-MON-YY'));
INSERT INTO Reservations VALUES (1049, 449, 5048, TO_DATE('06-JAN-24','DD-MON-YY'), TO_DATE('19-NOV-22','DD-MON-YY'), TO_DATE('06-AUG-22','DD-MON-YY'));
INSERT INTO Reservations VALUES (1050, 450, 5049, TO_DATE('03-NOV-23','DD-MON-YY'), TO_DATE('27-MAY-23','DD-MON-YY'), TO_DATE('10-FEB-23','DD-MON-YY'));
-------------------------------------------------------------------------------------------------------------------
INSERT INTO BookCopies VALUES (6001, 'A', 5001);
INSERT INTO BookCopies VALUES (6002, 'A', 5002);
INSERT INTO BookCopies VALUES (6003, 'I', 5003);
INSERT INTO BookCopies VALUES (6004, 'I', 5004);
INSERT INTO BookCopies VALUES (6005, 'A', 5005);
INSERT INTO BookCopies VALUES (6006, 'I', 5006);
INSERT INTO BookCopies VALUES (6007, 'A', 5007);
INSERT INTO BookCopies VALUES (6008, 'A', 5008);
INSERT INTO BookCopies VALUES (6009, 'I', 5009);
INSERT INTO BookCopies VALUES (6010, 'A', 5010);
INSERT INTO BookCopies VALUES (6011, 'A', 5011);
INSERT INTO BookCopies VALUES (6012, 'A', 5012);
INSERT INTO BookCopies VALUES (6013, 'I', 5013);
INSERT INTO BookCopies VALUES (6014, 'I', 5014);
INSERT INTO BookCopies VALUES (6015, 'A', 5015);
INSERT INTO BookCopies VALUES (6016, 'I', 5016);
INSERT INTO BookCopies VALUES (6017, 'A', 5017);
INSERT INTO BookCopies VALUES (6018, 'A', 5018);
INSERT INTO BookCopies VALUES (6019, 'I', 5019);
INSERT INTO BookCopies VALUES (6020, 'I', 5020);
INSERT INTO BookCopies VALUES (6021, 'I', 5021);
INSERT INTO BookCopies VALUES (6022, 'A', 5022);
INSERT INTO BookCopies VALUES (6023, 'A', 5023);
INSERT INTO BookCopies VALUES (6024, 'A', 5024);
INSERT INTO BookCopies VALUES (6025, 'I', 5025);
INSERT INTO BookCopies VALUES (6026, 'I', 5026);
INSERT INTO BookCopies VALUES (6027, 'A', 5027);
INSERT INTO BookCopies VALUES (6028, 'I', 5028);
INSERT INTO BookCopies VALUES (6029, 'I', 5029);
INSERT INTO BookCopies VALUES (6030, 'I', 5030);
INSERT INTO BookCopies VALUES (6031, 'I', 5031);
INSERT INTO BookCopies VALUES (6032, 'A', 5032);
INSERT INTO BookCopies VALUES (6033, 'I', 5033);
INSERT INTO BookCopies VALUES (6034, 'A', 5034);
INSERT INTO BookCopies VALUES (6035, 'A', 5035);
INSERT INTO BookCopies VALUES (6036, 'A', 5036);
INSERT INTO BookCopies VALUES (6037, 'I', 5037);
INSERT INTO BookCopies VALUES (6038, 'I', 5038);
INSERT INTO BookCopies VALUES (6039, 'A', 5039);
INSERT INTO BookCopies VALUES (6040, 'I', 5040);
INSERT INTO BookCopies VALUES (6041, 'A', 5041);
INSERT INTO BookCopies VALUES (6042, 'I', 5042);
INSERT INTO BookCopies VALUES (6043, 'A', 5043);
INSERT INTO BookCopies VALUES (6044, 'I', 5044);
INSERT INTO BookCopies VALUES (6045, 'I', 5045);
INSERT INTO BookCopies VALUES (6046, 'I', 5046);
INSERT INTO BookCopies VALUES (6047, 'I', 5047);
INSERT INTO BookCopies VALUES (6048, 'I', 5048);
INSERT INTO BookCopies VALUES (6049, 'A', 5049);
INSERT INTO BookCopies VALUES (6050, 'A', 5000);
-------------------------------------------------------------------------------------------------------------------
INSERT INTO Staff VALUES (201, 'Casey', 'Len', 'Archivist', 30750, TO_DATE('01-JAN-23', 'DD-MON-YY'), NULL);
INSERT INTO Staff VALUES (202, 'Rava', 'Joy', 'Assistant', 31500, TO_DATE('02-JAN-23', 'DD-MON-YY'), NULL);
INSERT INTO Staff VALUES (203, 'Gred', 'Smith', 'Technician', 32250, TO_DATE('03-JAN-23', 'DD-MON-YY'), NULL);
INSERT INTO Staff VALUES (204, 'Rogger', 'Tang', 'Manager', 33000, TO_DATE('04-JAN-23', 'DD-MON-YY'), NULL);
INSERT INTO Staff VALUES (205, 'Lucky', 'Steven', 'Librarian', 33750, TO_DATE('05-JAN-23', 'DD-MON-YY'), TO_DATE('06-JAN-24', 'DD-MON-YY'));
INSERT INTO Staff VALUES (206, 'Randy', 'Camble', 'Archivist', 34500, TO_DATE('06-JAN-23', 'DD-MON-YY'), NULL);
INSERT INTO Staff VALUES (207, 'Jarry', 'Best', 'Assistant', 35250, TO_DATE('07-JAN-23', 'DD-MON-YY'), NULL);
INSERT INTO Staff VALUES (208, 'Timmy', 'Jan', 'Technician', 36000, TO_DATE('08-JAN-23', 'DD-MON-YY'), NULL);
INSERT INTO Staff VALUES (209, 'Lorey', 'Govert', 'Manager', 36750, TO_DATE('09-JAN-23', 'DD-MON-YY'), NULL);
INSERT INTO Staff VALUES (210, 'Thomas', 'Evens', 'Librarian', 37500, TO_DATE('10-JAN-23', 'DD-MON-YY'), TO_DATE('11-JAN-24', 'DD-MON-YY'));
INSERT INTO Staff VALUES (211, 'Even', 'Lester', 'Archivist', 38250, TO_DATE('11-JAN-23', 'DD-MON-YY'), NULL);
INSERT INTO Staff VALUES (212, 'Shery', 'Stevens', 'Assistant', 39000, TO_DATE('12-JAN-23', 'DD-MON-YY'), NULL);
INSERT INTO Staff VALUES (213, 'Jaxon', 'Smite', 'Technician', 39750, TO_DATE('13-JAN-23', 'DD-MON-YY'), NULL);
INSERT INTO Staff VALUES (214, 'Lord', 'Vader', 'Manager', 40500, TO_DATE('14-JAN-23', 'DD-MON-YY'), NULL);
INSERT INTO Staff VALUES (215, 'Timmy', 'Robbers', 'Librarian', 41250, TO_DATE('15-JAN-23', 'DD-MON-YY'), TO_DATE('16-JAN-24', 'DD-MON-YY'));
INSERT INTO Staff VALUES (216, 'Greg', 'Ranner', 'Archivist', 42000, TO_DATE('16-JAN-23', 'DD-MON-YY'), NULL);
INSERT INTO Staff VALUES (217, 'Sam', 'Burbary', 'Assistant', 42750, TO_DATE('17-JAN-23', 'DD-MON-YY'), NULL);
INSERT INTO Staff VALUES (218, 'Samantha', 'Winny', 'Technician', 43500, TO_DATE('18-JAN-23', 'DD-MON-YY'), NULL);
INSERT INTO Staff VALUES (219, 'Dean', 'Winchester', 'Manager', 44250, TO_DATE('19-JAN-23', 'DD-MON-YY'), NULL);
INSERT INTO Staff VALUES (220, 'Sam', 'Winchester', 'Librarian', 45000, TO_DATE('20-JAN-23', 'DD-MON-YY'), TO_DATE('21-JAN-24', 'DD-MON-YY'));
-------------------------------------------------------------------------------------------------------------------
INSERT INTO Borrowing VALUES (7001, 402, 6002, TO_DATE('21-OCT-23','DD-MON-YY'), TO_DATE('15-APR-23','DD-MON-YY'), TO_DATE('27-MAY-22','DD-MON-YY'), 'N', 201);
INSERT INTO Borrowing VALUES (7002, 403, 6003, TO_DATE('29-SEP-22','DD-MON-YY'), TO_DATE('23-MAY-22','DD-MON-YY'), TO_DATE('10-SEP-22','DD-MON-YY'), 'N', 202);
INSERT INTO Borrowing VALUES (7003, 404, 6004, TO_DATE('02-FEB-24','DD-MON-YY'), TO_DATE('29-JUL-23','DD-MON-YY'), TO_DATE('06-JUL-23','DD-MON-YY'), 'N', 203);
INSERT INTO Borrowing VALUES (7004, 405, 6005, TO_DATE('27-SEP-22','DD-MON-YY'), TO_DATE('04-FEB-24','DD-MON-YY'), NULL, 'Y', 204);
INSERT INTO Borrowing VALUES (7005, 406, 6006, TO_DATE('22-AUG-23','DD-MON-YY'), TO_DATE('15-MAR-23','DD-MON-YY'), TO_DATE('21-AUG-23','DD-MON-YY'), 'N', 205);
INSERT INTO Borrowing VALUES (7006, 407, 6007, TO_DATE('13-FEB-23','DD-MON-YY'), TO_DATE('06-JAN-23','DD-MON-YY'), TO_DATE('13-AUG-22','DD-MON-YY'), 'N', 206);
INSERT INTO Borrowing VALUES (7007, 408, 6008, TO_DATE('22-MAY-22','DD-MON-YY'), TO_DATE('06-JUN-23','DD-MON-YY'), TO_DATE('21-MAY-23','DD-MON-YY'), 'N', 207);
INSERT INTO Borrowing VALUES (7008, 409, 6009, TO_DATE('11-AUG-24','DD-MON-YY'), TO_DATE('25-AUG-24','DD-MON-YY'), TO_DATE('25-AUG-24','DD-MON-YY'), 'N', 201);
INSERT INTO Borrowing VALUES (7009, 410, 6010, TO_DATE('18-FEB-22','DD-MON-YY'), TO_DATE('31-MAY-24','DD-MON-YY'), TO_DATE('23-APR-22','DD-MON-YY'), 'N', 209);
INSERT INTO Borrowing VALUES (7010, 411, 6011, TO_DATE('06-JUN-22','DD-MON-YY'), TO_DATE('05-OCT-23','DD-MON-YY'), TO_DATE('13-JUN-22','DD-MON-YY'), 'N', 210);
INSERT INTO Borrowing VALUES (7011, 412, 6012, TO_DATE('22-MAR-24','DD-MON-YY'), TO_DATE('28-NOV-23','DD-MON-YY'), TO_DATE('09-MAR-23','DD-MON-YY'), 'N', 201);
INSERT INTO Borrowing VALUES (7012, 413, 6013, TO_DATE('03-SEP-23','DD-MON-YY'), TO_DATE('07-MAR-22','DD-MON-YY'), NULL, 'Y', 202);
INSERT INTO Borrowing VALUES (7013, 414, 6014, TO_DATE('30-JAN-23','DD-MON-YY'), TO_DATE('26-JAN-23','DD-MON-YY'), TO_DATE('03-SEP-23','DD-MON-YY'), 'N', 203);
INSERT INTO Borrowing VALUES (7014, 415, 6015, TO_DATE('25-APR-23','DD-MON-YY'), TO_DATE('26-JUN-23','DD-MON-YY'), TO_DATE('15-SEP-22','DD-MON-YY'), 'N', 204);
INSERT INTO Borrowing VALUES (7015, 416, 6016, TO_DATE('21-JUL-23','DD-MON-YY'), TO_DATE('31-MAY-24','DD-MON-YY'), TO_DATE('12-JAN-22','DD-MON-YY'), 'N', 205);
INSERT INTO Borrowing VALUES (7016, 417, 6017, TO_DATE('28-NOV-23','DD-MON-YY'), TO_DATE('09-JAN-24','DD-MON-YY'), NULL, 'Y', 206);
INSERT INTO Borrowing VALUES (7017, 418, 6018, TO_DATE('28-APR-22','DD-MON-YY'), TO_DATE('30-NOV-23','DD-MON-YY'), TO_DATE('04-JUL-23','DD-MON-YY'), 'N', 207);
INSERT INTO Borrowing VALUES (7018, 419, 6019, TO_DATE('08-FEB-24','DD-MON-YY'), TO_DATE('01-OCT-22','DD-MON-YY'), TO_DATE('27-FEB-24','DD-MON-YY'), 'N', 208);
INSERT INTO Borrowing VALUES (7019, 420, 6020, TO_DATE('19-OCT-23','DD-MON-YY'), TO_DATE('15-DEC-22','DD-MON-YY'), TO_DATE('25-APR-22','DD-MON-YY'), 'N', 209);
INSERT INTO Borrowing VALUES (7020, 421, 6021, TO_DATE('28-OCT-22','DD-MON-YY'), TO_DATE('22-MAR-23','DD-MON-YY'), NULL, 'Y', 201);
INSERT INTO Borrowing VALUES (7021, 422, 6022, TO_DATE('08-DEC-24','DD-MON-YY'), TO_DATE('22-DEC-24','DD-MON-YY'), TO_DATE('19-DEC-24','DD-MON-YY'), 'N', 203);
INSERT INTO Borrowing VALUES (7022, 423, 6023, TO_DATE('10-JAN-24','DD-MON-YY'), TO_DATE('15-JUN-24','DD-MON-YY'), TO_DATE('07-JAN-24','DD-MON-YY'), 'N', 202);
INSERT INTO Borrowing VALUES (7023, 424, 6024, TO_DATE('27-SEP-22','DD-MON-YY'), TO_DATE('28-MAY-23','DD-MON-YY'), TO_DATE('20-FEB-24','DD-MON-YY'), 'N', 203);
INSERT INTO Borrowing VALUES (7024, 425, 6025, TO_DATE('02-JUL-22','DD-MON-YY'), TO_DATE('04-JUN-23','DD-MON-YY'), NULL, 'Y', 204);
INSERT INTO Borrowing VALUES (7025, 426, 6026, TO_DATE('19-APR-22','DD-MON-YY'), TO_DATE('10-JUN-24','DD-MON-YY'), TO_DATE('03-OCT-23','DD-MON-YY'), 'N', 205);
INSERT INTO Borrowing VALUES (7026, 427, 6027, TO_DATE('02-NOV-22','DD-MON-YY'), TO_DATE('11-MAY-24','DD-MON-YY'), TO_DATE('17-OCT-23','DD-MON-YY'), 'N', 206);
INSERT INTO Borrowing VALUES (7027, 428, 6028, TO_DATE('04-JUN-23','DD-MON-YY'), TO_DATE('16-SEP-23','DD-MON-YY'), TO_DATE('23-JUL-22','DD-MON-YY'), 'N', 207);
INSERT INTO Borrowing VALUES (7028, 429, 6029, TO_DATE('06-JUN-22','DD-MON-YY'), TO_DATE('18-JAN-23','DD-MON-YY'), TO_DATE('20-FEB-24','DD-MON-YY'), 'N', 208);
INSERT INTO Borrowing VALUES (7029, 430, 6030, TO_DATE('15-JUN-22','DD-MON-YY'), TO_DATE('07-JUL-23','DD-MON-YY'), TO_DATE('08-MAR-24','DD-MON-YY'), 'N', 209);
INSERT INTO Borrowing VALUES (7030, 431, 6031, TO_DATE('28-JUN-23','DD-MON-YY'), TO_DATE('01-JAN-22','DD-MON-YY'), TO_DATE('06-SEP-23','DD-MON-YY'), 'N', 201);
INSERT INTO Borrowing VALUES (7031, 432, 6032, TO_DATE('28-NOV-22','DD-MON-YY'), TO_DATE('16-MAY-23','DD-MON-YY'), TO_DATE('20-JAN-22','DD-MON-YY'), 'N', 201);
INSERT INTO Borrowing VALUES (7032, 433, 6033, TO_DATE('07-APR-25','DD-MON-YY'), TO_DATE('21-APR-25','DD-MON-YY'), TO_DATE('15-APR-25','DD-MON-YY'), 'N', 202);
INSERT INTO Borrowing VALUES (7033, 434, 6034, TO_DATE('01-MAY-24','DD-MON-YY'), TO_DATE('06-APR-24','DD-MON-YY'), TO_DATE('11-NOV-22','DD-MON-YY'), 'N', 203);
INSERT INTO Borrowing VALUES (7034, 435, 6035, TO_DATE('03-SEP-22','DD-MON-YY'), TO_DATE('01-MAR-22','DD-MON-YY'), TO_DATE('04-SEP-22','DD-MON-YY'), 'N', 204);
INSERT INTO Borrowing VALUES (7035, 436, 6036, TO_DATE('18-JUN-24','DD-MON-YY'), TO_DATE('04-AUG-23','DD-MON-YY'), TO_DATE('22-MAR-22','DD-MON-YY'), 'N', 205);
INSERT INTO Borrowing VALUES (7036, 437, 6037, TO_DATE('29-MAR-22','DD-MON-YY'), TO_DATE('20-JAN-24','DD-MON-YY'), TO_DATE('13-MAY-23','DD-MON-YY'), 'N', 206);
INSERT INTO Borrowing VALUES (7037, 438, 6038, TO_DATE('15-APR-24','DD-MON-YY'), TO_DATE('12-MAR-22','DD-MON-YY'), TO_DATE('18-FEB-24','DD-MON-YY'), 'N', 207);
INSERT INTO Borrowing VALUES (7038, 439, 6039, TO_DATE('30-JUN-23','DD-MON-YY'), TO_DATE('24-FEB-24','DD-MON-YY'), TO_DATE('09-MAY-22','DD-MON-YY'), 'N', 208);
INSERT INTO Borrowing VALUES (7039, 440, 6040, TO_DATE('12-MAY-22','DD-MON-YY'), TO_DATE('07-NOV-23','DD-MON-YY'), TO_DATE('02-MAY-23','DD-MON-YY'), 'N', 209);
INSERT INTO Borrowing VALUES (7040, 441, 6041, TO_DATE('17-JUL-23','DD-MON-YY'), TO_DATE('19-JUN-22','DD-MON-YY'), TO_DATE('29-SEP-22','DD-MON-YY'), 'N', 201);
INSERT INTO Borrowing VALUES (7041, 442, 6042, TO_DATE('25-JUN-23','DD-MON-YY'), TO_DATE('12-JUN-24','DD-MON-YY'), TO_DATE('14-SEP-23','DD-MON-YY'), 'N', 201);
INSERT INTO Borrowing VALUES (7042, 443, 6043, TO_DATE('10-MAR-23','DD-MON-YY'), TO_DATE('05-AUG-22','DD-MON-YY'), TO_DATE('07-JUL-23','DD-MON-YY'), 'N', 202);
INSERT INTO Borrowing VALUES (7043, 444, 6044, TO_DATE('13-FEB-24','DD-MON-YY'), TO_DATE('18-JAN-24','DD-MON-YY'), TO_DATE('08-DEC-23','DD-MON-YY'), 'N', 203);
INSERT INTO Borrowing VALUES (7044, 445, 6045, TO_DATE('25-JUL-22','DD-MON-YY'), TO_DATE('01-JAN-24','DD-MON-YY'), TO_DATE('16-NOV-22','DD-MON-YY'), 'N', 204);
INSERT INTO Borrowing VALUES (7045, 446, 6046, TO_DATE('13-FEB-23','DD-MON-YY'), TO_DATE('19-NOV-23','DD-MON-YY'), TO_DATE('28-OCT-23','DD-MON-YY'), 'N', 205);
INSERT INTO Borrowing VALUES (7046, 447, 6047, TO_DATE('18-JAN-23','DD-MON-YY'), TO_DATE('25-MAR-23','DD-MON-YY'), TO_DATE('14-JUN-23','DD-MON-YY'), 'N', 206);
INSERT INTO Borrowing VALUES (7047, 448, 6048, TO_DATE('08-APR-23','DD-MON-YY'), TO_DATE('04-MAY-22','DD-MON-YY'), TO_DATE('11-SEP-22','DD-MON-YY'), 'N', 207);
INSERT INTO Borrowing VALUES (7048, 449, 6049, TO_DATE('19-AUG-22','DD-MON-YY'), TO_DATE('07-MAR-22','DD-MON-YY'), TO_DATE('13-DEC-22','DD-MON-YY'), 'N', 208);
INSERT INTO Borrowing VALUES (7049, 450, 6050, TO_DATE('22-JAN-22','DD-MON-YY'), TO_DATE('26-AUG-23','DD-MON-YY'), TO_DATE('22-JUL-23','DD-MON-YY'), 'N', 209);
-------------------------------------------------------------------------------------------------------------------
INSERT INTO BorrowingStaff VALUES (201, 7001, 'Returned', TO_DATE('24-AUG-22','DD-MON-YY') + 1);
INSERT INTO BorrowingStaff VALUES (202, 7002, 'Renewed', TO_DATE('26-AUG-23','DD-MON-YY') + 2);
INSERT INTO BorrowingStaff VALUES (203, 7003, 'Issued', TO_DATE('14-AUG-22','DD-MON-YY') + 3);
INSERT INTO BorrowingStaff VALUES (204, 7004, 'Returned', TO_DATE('08-JAN-22','DD-MON-YY') + 4);
INSERT INTO BorrowingStaff VALUES (205, 7005, 'Renewed', TO_DATE('14-MAR-22','DD-MON-YY') + 5);
INSERT INTO BorrowingStaff VALUES (206, 7006, 'Issued', TO_DATE('26-DEC-23','DD-MON-YY') + 6);
INSERT INTO BorrowingStaff VALUES (207, 7007, 'Returned', TO_DATE('09-OCT-23','DD-MON-YY') + 7);
INSERT INTO BorrowingStaff VALUES (208, 7008, 'Renewed', TO_DATE('02-MAR-22','DD-MON-YY') + 8);
INSERT INTO BorrowingStaff VALUES (209, 7009, 'Issued', TO_DATE('23-AUG-22','DD-MON-YY') + 9);
INSERT INTO BorrowingStaff VALUES (210, 7010, 'Returned', TO_DATE('11-MAR-22','DD-MON-YY') + 10);
INSERT INTO BorrowingStaff VALUES (211, 7011, 'Renewed', TO_DATE('02-FEB-22','DD-MON-YY') + 11);
INSERT INTO BorrowingStaff VALUES (212, 7012, 'Issued', TO_DATE('30-MAY-24','DD-MON-YY') + 12);
INSERT INTO BorrowingStaff VALUES (213, 7013, 'Returned', TO_DATE('05-DEC-22','DD-MON-YY') + 13);
INSERT INTO BorrowingStaff VALUES (214, 7014, 'Renewed', TO_DATE('14-MAR-22','DD-MON-YY') + 14);
INSERT INTO BorrowingStaff VALUES (215, 7015, 'Issued', TO_DATE('11-JUN-23','DD-MON-YY') + 15);
INSERT INTO BorrowingStaff VALUES (216, 7016, 'Returned', TO_DATE('01-SEP-22','DD-MON-YY') + 16);
INSERT INTO BorrowingStaff VALUES (217, 7017, 'Renewed', TO_DATE('13-OCT-22','DD-MON-YY') + 17);
INSERT INTO BorrowingStaff VALUES (218, 7018, 'Issued', TO_DATE('17-NOV-23','DD-MON-YY') + 18);
INSERT INTO BorrowingStaff VALUES (219, 7019, 'Returned', TO_DATE('13-MAY-23','DD-MON-YY') + 19);
INSERT INTO BorrowingStaff VALUES (201, 7020, 'Renewed', TO_DATE('08-AUG-22','DD-MON-YY') + 20);
INSERT INTO BorrowingStaff VALUES (201, 7021, 'Issued', TO_DATE('07-JUL-23','DD-MON-YY') + 21);
INSERT INTO BorrowingStaff VALUES (202, 7022, 'Returned', TO_DATE('16-MAY-22','DD-MON-YY') + 22);
INSERT INTO BorrowingStaff VALUES (203, 7023, 'Renewed', TO_DATE('11-JAN-24','DD-MON-YY') + 23);
INSERT INTO BorrowingStaff VALUES (204, 7024, 'Issued', TO_DATE('08-AUG-23','DD-MON-YY') + 24);
INSERT INTO BorrowingStaff VALUES (205, 7025, 'Returned', TO_DATE('14-AUG-23','DD-MON-YY') + 25);
INSERT INTO BorrowingStaff VALUES (206, 7026, 'Renewed', TO_DATE('30-APR-23','DD-MON-YY') + 26);
INSERT INTO BorrowingStaff VALUES (207, 7027, 'Issued', TO_DATE('06-SEP-22','DD-MON-YY') + 27);
INSERT INTO BorrowingStaff VALUES (208, 7028, 'Returned', TO_DATE('14-MAR-24','DD-MON-YY') + 28);
INSERT INTO BorrowingStaff VALUES (209, 7029, 'Renewed', TO_DATE('30-APR-23','DD-MON-YY') + 29);
INSERT INTO BorrowingStaff VALUES (210, 7030, 'Issued', TO_DATE('06-APR-24','DD-MON-YY') + 30);
INSERT INTO BorrowingStaff VALUES (211, 7031, 'Returned', TO_DATE('21-FEB-23','DD-MON-YY') + 31);
INSERT INTO BorrowingStaff VALUES (212, 7032, 'Renewed', TO_DATE('14-JUL-22','DD-MON-YY') + 32);
INSERT INTO BorrowingStaff VALUES (213, 7033, 'Issued', TO_DATE('07-APR-22','DD-MON-YY') + 33);
INSERT INTO BorrowingStaff VALUES (214, 7034, 'Returned', TO_DATE('10-APR-22','DD-MON-YY') + 34);
INSERT INTO BorrowingStaff VALUES (215, 7035, 'Renewed', TO_DATE('06-NOV-23','DD-MON-YY') + 35);
INSERT INTO BorrowingStaff VALUES (216, 7036, 'Issued', TO_DATE('18-MAR-23','DD-MON-YY') + 36);
INSERT INTO BorrowingStaff VALUES (217, 7037, 'Returned', TO_DATE('29-DEC-22','DD-MON-YY') + 37);
INSERT INTO BorrowingStaff VALUES (218, 7038, 'Renewed', TO_DATE('10-MAR-23','DD-MON-YY') + 38);
INSERT INTO BorrowingStaff VALUES (219, 7039, 'Issued', TO_DATE('25-FEB-23','DD-MON-YY') + 39);
INSERT INTO BorrowingStaff VALUES (201, 7040, 'Returned', TO_DATE('24-APR-23','DD-MON-YY') + 40);
INSERT INTO BorrowingStaff VALUES (201, 7041, 'Renewed', TO_DATE('03-JUN-24','DD-MON-YY') + 41);
INSERT INTO BorrowingStaff VALUES (202, 7042, 'Issued', TO_DATE('17-JAN-24','DD-MON-YY') + 42);
INSERT INTO BorrowingStaff VALUES (203, 7043, 'Returned', TO_DATE('25-FEB-22','DD-MON-YY') + 43);
INSERT INTO BorrowingStaff VALUES (204, 7044, 'Renewed', TO_DATE('21-NOV-23','DD-MON-YY') + 44);
INSERT INTO BorrowingStaff VALUES (205, 7045, 'Issued', TO_DATE('01-NOV-23','DD-MON-YY') + 45);
INSERT INTO BorrowingStaff VALUES (206, 7046, 'Returned', TO_DATE('24-OCT-23','DD-MON-YY') + 46);
INSERT INTO BorrowingStaff VALUES (207, 7047, 'Renewed', TO_DATE('11-APR-22','DD-MON-YY') + 47);
INSERT INTO BorrowingStaff VALUES (208, 7048, 'Issued', TO_DATE('04-MAR-22','DD-MON-YY') + 48);
INSERT INTO BorrowingStaff VALUES (209, 7049, 'Returned', TO_DATE('17-FEB-23','DD-MON-YY') + 49);
-------------------------------------------------------------------------------------------------------------------

/*=================================================================================================================
 				   4_Library_Management_System_Views_Only.sql
=================================================================================================================*/

-------------------------------------------------------------------------------------------------------------------
-- Drop views if they exist (optional safety)
DROP VIEW MemberBorrowingHistory    CASCADE CONSTRAINTS;
DROP VIEW MemberActivitySummary     CASCADE CONSTRAINTS;
DROP VIEW BooksByCategory           CASCADE CONSTRAINTS;
DROP VIEW OverdueBooks              CASCADE CONSTRAINTS;
DROP VIEW BorrowingAndReturns       CASCADE CONSTRAINTS;
DROP VIEW WhoReturnedBooksLate      CASCADE CONSTRAINTS;
DROP VIEW ActiveReservations        CASCADE CONSTRAINTS;
DROP VIEW WhatStaffIssuedBorrowings CASCADE CONSTRAINTS;
DROP VIEW StaffBorrowingsLog        CASCADE CONSTRAINTS;
DROP VIEW TopTenBooksBorrowed       CASCADE CONSTRAINTS;
DROP VIEW BooksNeverBorrowed        CASCADE CONSTRAINTS;
DROP VIEW RecentMembersWhoBorrowed  CASCADE CONSTRAINTS;
DROP VIEW PopularAuthors            CASCADE CONSTRAINTS;
DROP VIEW BorrowingDetails          CASCADE CONSTRAINTS;
DROP VIEW MemberBorrowingSummary    CASCADE CONSTRAINTS;
DROP VIEW BookAvailabilityView      CASCADE CONSTRAINTS;
-------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW MemberBorrowingHistory                                         AS
SELECT 
    -- Member Info
    Members.MemberID                                                                  AS "Member ID",
    INITCAP(LPAD(Members.FirstName, 9)) || ' ' || INITCAP(RPAD(Members.LastName, 10)) AS "Member Name",
    -- Book Info
    RPAD(Books.Title, 30)                                                             AS "Book Title",
    -- Category Info
    INITCAP(Categories.CatName)                                                       AS "Category",
    -- Borrowing Info
    LPAD(Borrowing.BorrowingID, 10)                                                   AS "Borrowing Number",
    TO_CHAR(Borrowing.ReservationDate, 'DD-MON-YY')                                   AS "Date Reserved",
    TO_CHAR(Borrowing.DueDate, 'DD-MON-YY')                                           AS "Due Date",
    CASE 
        WHEN Borrowing.DueDate < SYSDATE 
            AND 
             Borrowing.ReturnDate IS NULL 
            THEN LPAD('Y', 4) 
        ELSE LPAD('N', 4) 
    END                                                                               AS "Late?",
    NVL(TO_CHAR(Borrowing.ReturnDate, 'DD-MON-YY'), 'Not Avail.')                     AS "Return Date",
    CASE 
        WHEN Borrowing.ReturnDate IS NULL 
            THEN 'Not Returned' 
        ELSE LPAD('Returned', 10) 
    END                                                                               AS "Return Status",
    INITCAP(LPAD(Staff.FirstName, 6)) || ' ' || INITCAP(RPAD(Staff.LastName, 9))      AS "Handled By"

FROM Members
     JOIN Borrowing      ON        Members.MemberID    =      Borrowing.MemberID
     JOIN BookCopies     ON      Borrowing.CopyID      =     BookCopies.CopyID
     JOIN Books          ON     BookCopies.BookID      =          Books.BookID
     JOIN Categories     ON          Books.CatCode     =     Categories.CatCode
LEFT JOIN BorrowingStaff ON      Borrowing.BorrowingID = BorrowingStaff.BorrowingID
LEFT JOIN Staff          ON BorrowingStaff.StaffID     =          Staff.StaffID

ORDER BY Borrowing.ReservationDate DESC, "Handled By" ASC;
-------------------------------------------------------------------------------------------------------------------
-- View: MemberActivitySummary
CREATE OR REPLACE VIEW MemberActivitySummary                                                   AS
SELECT
    -- Member Info
    Members.MemberID                                                                           AS "Member ID",
    INITCAP(LPAD(Members.FirstName, 9)) || ' ' || INITCAP(RPAD(Members.LastName, 10))          AS "Member Name",
    -- Borrowing Info
    COUNT(Borrowing.BorrowingID)                                                               AS "Total Borrowed",
    SUM(CASE 
            WHEN Borrowing.IsLate IS NOT NULL 
                AND 
                 Borrowing.IsLate != 'No' 
                THEN 1 
            ELSE 0 
        END)                                                                                   AS "Overdue Count",
    SUM(CASE 
            WHEN Borrowing.ReturnDate IS NULL 
                THEN 1 
            ELSE 0 
        END)                                                                                   AS "Active Loans"

FROM Members
LEFT JOIN Borrowing ON Members.MemberID = Borrowing.MemberID

GROUP BY Members.MemberID, Members.FirstName, Members.LastName

ORDER BY "Total Borrowed" DESC;
-------------------------------------------------------------------------------------------------------------------
-- View: BooksByCategory
CREATE OR REPLACE VIEW BooksByCategory AS
SELECT
    -- Category Info
    INITCAP(Categories.CatName)        AS "Category",
    -- Book Info
    COUNT(DISTINCT Books.BookID)       AS "Total Books",
    -- Borrowing Info
    COUNT(Borrowing.BorrowingID)       AS "Total Borrowings"

FROM Categories
LEFT JOIN Books      ON Categories.CatCode =      Books.CatCode
LEFT JOIN BookCopies ON      Books.BookID  = BookCopies.BookID
LEFT JOIN Borrowing  ON BookCopies.CopyID  =  Borrowing.CopyID

GROUP BY Categories.CatName

ORDER BY "Total Borrowings" DESC;
-------------------------------------------------------------------------------------------------------------------
-- View: OverdueBooks
CREATE OR REPLACE VIEW OverdueBooks                                                   AS
SELECT
    -- Member Info
    Members.MemberID                                                                  AS "Member ID",
    INITCAP(LPAD(Members.FirstName, 9)) || ' ' || INITCAP(RPAD(Members.LastName, 10)) AS "Member Name",
    -- Book Info
    RPAD(Books.Title, 30)                                                             AS "Book Title",
    -- Borrowing Info
    TO_CHAR(Borrowing.DueDate, 'DD-MON-YY')                                           AS "Due Date",
    NVL(TO_CHAR(Borrowing.ReturnDate, 'DD-MON-YY'), LPAD('N/A', 7))                   AS "Return Date",
    CASE 
        WHEN Borrowing.ReturnDate IS NULL 
            THEN 'Not Returned' 
        ELSE LPAD('Returned', 10)
    END                                                                               AS "Return Status",
    CASE 
        WHEN Borrowing.ReturnDate IS NULL 
            THEN TRUNC(SYSDATE - Borrowing.DueDate)
        ELSE GREATEST(TRUNC(Borrowing.ReturnDate - Borrowing.DueDate), 0) 
    END                                                                               AS "Days Overdue"
FROM Borrowing
    JOIN Members    ON  Borrowing.MemberID =    Members.MemberID
    JOIN BookCopies ON  Borrowing.CopyID   = BookCopies.CopyID
    JOIN Books      ON BookCopies.BookID   =      Books.BookID

WHERE 
    (Borrowing.ReturnDate > Borrowing.DueDate)
    OR 
    (Borrowing.ReturnDate IS NULL
     AND
     Borrowing.DueDate < SYSDATE)

ORDER BY Borrowing.DueDate DESC;
-------------------------------------------------------------------------------------------------------------------
-- Additional views omitted from this section due to space; they will be appended below

-- View: BorrowingAndReturns
CREATE OR REPLACE VIEW BorrowingAndReturns                                          AS
SELECT
    -- Member Info
    Members.MemberID                                                                AS "Member ID",
    INITCAP(LPAD(Members.FirstName,9)) || ' ' || INITCAP(RPAD(Members.LastName,10)) AS "Member Name",
    -- Book Info
    RPAD(Books.Title,30)                                                            AS "Book Title",
    -- Borrowing Info
    TO_CHAR(Borrowing.DueDate, 'DD-MON-YY')                                         AS "Due Date",
    NVL(TO_CHAR(Borrowing.ReturnDate, 'DD-MON-YY'), LPAD('N/A', 7))                 AS "Return Date",
    CASE 
        WHEN Borrowing.ReturnDate IS NULL 
            THEN 'Not Returned' 
        ELSE LPAD('Returned', 11) 
    END                                                                             AS "Return Status",
    CASE 
        WHEN Borrowing.ReturnDate IS NULL 
            AND 
             Borrowing.DueDate < SYSDATE 
            THEN TRUNC(SYSDATE - Borrowing.DueDate)
        WHEN Borrowing.ReturnDate > Borrowing.DueDate 
            THEN TRUNC(Borrowing.ReturnDate - Borrowing.DueDate)
        ELSE 0 
    END                                                                             AS "Days Overdue",
    CASE 
        WHEN Borrowing.ReturnDate IS NULL 
            AND 
             Borrowing.DueDate < SYSDATE 
            THEN LPAD('Y', 5)
        WHEN Borrowing.ReturnDate > Borrowing.DueDate 
            THEN LPAD('Y', 5)
        ELSE LPAD('N', 5)
    END                                                                             AS "Late?"

FROM Borrowing
    JOIN Members    ON  Borrowing.MemberID =    Members.MemberID
    JOIN BookCopies ON  Borrowing.CopyID   = BookCopies.CopyID
    JOIN Books      ON BookCopies.BookID   =      Books.BookID

ORDER BY Borrowing.DueDate DESC;
-------------------------------------------------------------------------------------------------------------------
-- View: WhoReturnedBooksLate
CREATE OR REPLACE VIEW WhoReturnedBooksLate                                         AS
SELECT
    -- Member Info
    Members.MemberID                                                                AS "Member ID",
    INITCAP(LPAD(Members.FirstName,9)) || ' ' || INITCAP(RPAD(Members.LastName,10)) AS "Member Name",
    -- Book Info
    Books.Title                                                                     AS "Book Title",
    -- Borrowing Info
    TO_CHAR(Borrowing.DueDate, 'DD-MON-YY')                                         AS "Due Date",
    TO_CHAR(Borrowing.ReturnDate, 'DD-MON-YY')                                      AS "Return Date",
    'Returned Late'                                                                 AS "Return Status",
    TRUNC(Borrowing.ReturnDate - Borrowing.DueDate)                                 AS "Days Late"

FROM Borrowing
    JOIN Members    ON  Borrowing.MemberID =    Members.MemberID
    JOIN BookCopies ON  Borrowing.CopyID   = BookCopies.CopyID
    JOIN Books      ON BookCopies.BookID   =      Books.BookID

WHERE Borrowing.ReturnDate > Borrowing.DueDate

ORDER BY Borrowing.ReturnDate DESC;
-------------------------------------------------------------------------------------------------------------------
-- View: ActiveReservations
CREATE OR REPLACE VIEW ActiveReservations                                           AS
SELECT
    -- Member Info
    Members.MemberID                                                                AS "Member ID",
    INITCAP(LPAD(Members.FirstName,9)) || ' ' || INITCAP(RPAD(Members.LastName,10)) AS "Member Name",
    -- Book Info
    RPAD(Books.Title,30)                                                            AS "Book Title",
    -- Reservation Info
    TO_CHAR(Reservations.BorrowDate, 'DD-MON-YY')                                   AS "Date Reserved",
    TO_CHAR(Reservations.DueDate, 'DD-MON-YY')                                      AS "Due Date",
    NVL(TO_CHAR(Reservations.CheckoutDate, 'DD-MON-YY'), 'Not Checked Out')         AS "Checkout Date"

FROM Reservations
    JOIN Members ON Reservations.MemberID = Members.MemberID
    JOIN Books   ON Reservations.BookID   =   Books.BookID

WHERE Reservations.CheckoutDate IS NULL

ORDER BY Reservations.BorrowDate ASC;
-------------------------------------------------------------------------------------------------------------------
-- View: WhatStaffIssuedBorrowings
CREATE OR REPLACE VIEW WhatStaffIssuedBorrowings                               AS
SELECT
    -- Staff Info
    Staff.StaffID                                                              AS "Staff ID",
    INITCAP(LPAD(Staff.FirstName,7)) || ' ' || INITCAP(RPAD(Staff.LastName,9)) AS "Staff Name",
    COUNT(*)                                                                   AS "Total Issued"
    
FROM BorrowingStaff
    JOIN Staff ON BorrowingStaff.StaffID = Staff.StaffID

WHERE UPPER(BorrowingStaff.ActionType) = 'ISSUED'

GROUP BY Staff.StaffID, Staff.FirstName, Staff.LastName

ORDER BY "Total Issued" DESC;
-------------------------------------------------------------------------------------------------------------------
-- View: StaffBorrowingsLog
CREATE OR REPLACE VIEW StaffBorrowingsLog                                             AS
SELECT 
    -- Borrowing Info
    LPAD(Borrowing.BorrowingID, 10)                                                   AS "Borrowing Number",
    LPAD(Borrowing.IsLate, 4)                                                         AS "Late?",
    -- Book Info
    RPAD(Books.Title, 30)                                                             AS "Book Title",
    -- Member Info
    LPAD(Members.MemberID, 9)                                                         AS "Member ID",
    INITCAP(LPAD(Members.FirstName, 9)) || ' ' || INITCAP(RPAD(Members.LastName, 10)) AS "Borrower Name",
    -- Staff Info
    LPAD(INITCAP(Staff.FirstName), 8)                                                 AS "Handled By",
    -- Borrowing Staff Info
    LPAD(BorrowingStaff.ActionType, 9)                                                AS "Action Type",
    TO_CHAR(BorrowingStaff.ActionDate, 'DD-MON-YY')                                   AS "Action Date"

FROM BorrowingStaff
    JOIN Borrowing  ON BorrowingStaff.BorrowingID =  Borrowing.BorrowingID
    JOIN BookCopies ON      Borrowing.CopyID      = BookCopies.CopyID
    JOIN Books      ON     BookCopies.BookID      =      Books.BookID
    JOIN Members    ON      Borrowing.MemberID    =    Members.MemberID
    JOIN Staff      ON BorrowingStaff.StaffID     =      Staff.StaffID

ORDER BY BorrowingStaff.ActionDate DESC;
-------------------------------------------------------------------------------------------------------------------
-- View: TopTenBooksBorrowed
CREATE OR REPLACE VIEW TopTenBooksBorrowed AS
SELECT
    -- Book Info
    RPAD(Books.Title, 30)                  AS "Book Title",
    COUNT(*)                               AS "Times Borrowed"

FROM Borrowing
    JOIN BookCopies ON  Borrowing.CopyID = BookCopies.CopyID
    JOIN Books      ON BookCopies.BookID =      Books.BookID

GROUP BY Books.Title

ORDER BY COUNT(*) DESC

FETCH FIRST 10 ROWS ONLY;
-------------------------------------------------------------------------------------------------------------------
-- View: BooksNeverBorrowed
CREATE OR REPLACE VIEW BooksNeverBorrowed AS
SELECT 
    -- Book Info
    RPAD(Books.Title, 30)                 AS "Book Title"

FROM Books 

WHERE NOT EXISTS (

        SELECT 1
        FROM BookCopies
        JOIN Borrowing ON BookCopies.CopyID = Borrowing.CopyID
        WHERE BookCopies.BookID = Books.BookID
    );
-------------------------------------------------------------------------------------------------------------------
-- View: RecentMembersWhoBorrowed
CREATE OR REPLACE VIEW RecentMembersWhoBorrowed                                       AS
SELECT 
    -- Member Info
    Members.MemberID                                                                  AS "Member ID",
    INITCAP(LPAD(Members.FirstName, 9)) || ' ' || INITCAP(RPAD(Members.LastName, 10)) AS "Member Name",
    -- Book Info
    RPAD(Books.Title, 30)                                                             AS "Book Title",
    -- Reservation Info
    TO_CHAR(Borrowing.ReservationDate, 'DD-MON-YY')                                   AS "Reservation Date"

FROM Borrowing
    JOIN Members    ON Borrowing.MemberID =    Members.MemberID
    JOIN BookCopies ON Borrowing.CopyID   = BookCopies.CopyID
    JOIN Books      ON BookCopies.BookID  =      Books.BookID

WHERE Borrowing.ReservationDate >= SYSDATE - 360

ORDER BY "Reservation Date";
-------------------------------------------------------------------------------------------------------------------
-- View: PopularAuthors
CREATE OR REPLACE VIEW PopularAuthors                              AS
SELECT  
    -- Author Info
    Authors.AuthorID                                               AS "Author ID",
    INITCAP(Authors.FirstName) || ' ' || INITCAP(Authors.LastName) AS "Author Name",
    COUNT(DISTINCT Books.BookID)                                   AS "Books Published",
    COUNT(Borrowing.BorrowingID)                                   AS "Total Borrowings"

FROM Authors
    JOIN Books      ON    Authors.AuthorID =      Books.AuthorID
    JOIN BookCopies ON      Books.BookID   = BookCopies.BookID
    JOIN Borrowing  ON BookCopies.CopyID   =  Borrowing.CopyID

GROUP BY Authors.AuthorID, Authors.FirstName, Authors.LastName

ORDER BY "Total Borrowings" DESC;
-------------------------------------------------------------------------------------------------------------------
-- View: BorrowingDetails
CREATE OR REPLACE VIEW BorrowingDetails                             AS
SELECT
    -- Member Info
    Members.MemberID                                                AS "Member ID",
    Members.FirstName || ' ' || Members.LastName                    AS "Member Name",
    -- Book Info
    Books.Title                                                     AS "Book Title",
    Borrowing.BorrowingID                                           AS "Borrowing Number",
    -- Borrowing Info
    Borrowing.ReservationDate                                       AS "Date Reserved",
    Borrowing.DueDate                                               AS "Due Date",
    Borrowing.IsLate                                                AS "Is it late?",
    NVL(TO_CHAR(Borrowing.ReturnDate, 'DD-MON-YY'), 'Not Returned') AS "Return Date",
    CASE 
        WHEN Borrowing.ReturnDate IS NULL 
            THEN 'Not Returned'
        WHEN Borrowing.ReturnDate > Borrowing.DueDate 
            THEN 'Returned Late'
        ELSE 'Returned On Time'
    END                                                             AS "Return Status"

FROM Borrowing 
    JOIN Members    ON  Borrowing.MemberID =    Members.MemberID
    JOIN BookCopies ON  Borrowing.CopyID   = BookCopies.CopyID
    JOIN Books      ON BookCopies.BookID   =      Books.BookID

ORDER BY Borrowing.ReservationDate DESC;
-------------------------------------------------------------------------------------------------------------------
-- View: MemberBorrowingSummary
CREATE OR REPLACE VIEW MemberBorrowingSummary    AS
SELECT
    -- Member Info
    Members.MemberID                             AS "Member ID",
    Members.FirstName || ' ' || Members.LastName AS "Member Name",
    -- Borrowing Info
    COUNT(Borrowing.BorrowingID)                 AS "Total Borrowings",
    SUM(CASE 
            WHEN Borrowing.IsLate = 'Y' 
                THEN 1 
            ELSE 0 
        END)                                     AS "Late Returns"

FROM Members 
LEFT JOIN Borrowing br ON Members.MemberID = Borrowing.MemberID

GROUP BY Members.MemberID, Members.FirstName, Members.LastName;
-------------------------------------------------------------------------------------------------------------------
-- View: BookAvailabilityView
CREATE OR REPLACE VIEW BookAvailabilityView      AS
SELECT 
    -- Book Info
    Books.BookID                                 AS "Book ID",
    Books.Title                                  AS "Book Title",
    Authors.FirstName || ' ' || Authors.LastName AS "Author Name",
    COUNT(BookCopies.CopyID)                     AS "Total Copies",
    SUM(CASE 
            WHEN BookCopies.Status = 'I' 
                THEN 1 
            ELSE 0 
        END)                                     AS "Available Copies",
    SUM(CASE 
            WHEN BookCopies.Status = 'O' 
                THEN 1 
            ELSE 0 
        END)                                     AS "Checked Out Copies"

FROM Books 
     JOIN Authors  ON Books.AuthorID = Authors.AuthorID
LEFT JOIN  BookCopies ON Books.BookID = BookCopies.BookID

GROUP BY Books.BookID, Books.Title, Authors.FirstName, Authors.LastName;
-------------------------------------------------------------------------------------------------------------------

/*=================================================================================================================
 			     5_Library_Management_System_Display_with_Pauses.sql
=================================================================================================================*/

-------------------------------------------------------------------------------------------------------------------
-- Set formatting options
SET LINESIZE 132
SET PAGESIZE 50
SET PAUSE ON
SET PAUSE 'Press Enter to continue...'
-------------------------------------------------------------------------------------------------------------------
						-- DISPLAY FOR TABLES
-------------------------------------------------------------------------------------------------------------------
PROMPT Displaying: Authors Table
SELECT * FROM Authors;

PROMPT Displaying: Books Table
SELECT * FROM Books;

PROMPT Displaying: BookCopies Table
SELECT * FROM BookCopies;

PROMPT Displaying: Categories Table
SELECT * FROM Categories;

PROMPT Displaying: Members Table
SELECT * FROM Members;

PROMPT Displaying: Staff Table
SELECT * FROM Staff;

PROMPT Displaying: Reservations Table
SELECT * FROM Reservations;

PROMPT Displaying: Borrowing Table
SELECT * FROM Borrowing;

PROMPT Displaying: BorrowingStaff Table
SELECT * FROM BorrowingStaff;
-------------------------------------------------------------------------------------------------------------------
						-- DISPLAY FOR VIEWS
-------------------------------------------------------------------------------------------------------------------
PROMPT Displaying: Member Borrowing History
SELECT * FROM MemberBorrowingHistory;

PROMPT Displaying: Member Activity Summary
SELECT * FROM MemberActivitySummary;

PROMPT Displaying: Books By Category
SELECT * FROM BooksByCategory;

PROMPT Displaying: Overdue Books
SELECT * FROM OverdueBooks;

PROMPT Displaying: Borrowing and Returns
SELECT * FROM BorrowingAndReturns;

PROMPT Displaying: Who Returned Books Late
SELECT * FROM WhoReturnedBooksLate;

PROMPT Displaying: Active Reservations
SELECT * FROM ActiveReservations;

PROMPT Displaying: What Staff Issued Borrowings
SELECT * FROM WhatStaffIssuedBorrowings;

PROMPT Displaying: Staff Borrowings Log
SELECT * FROM StaffBorrowingsLog;

PROMPT Displaying: Top Ten Books Borrowed
SELECT * FROM TopTenBooksBorrowed;

PROMPT Displaying: Books Never Borrowed
SELECT * FROM BooksNeverBorrowed;

PROMPT Displaying: Recent Members Who Borrowed
SELECT * FROM RecentMembersWhoBorrowed;

PROMPT Displaying: Popular Authors
SELECT * FROM PopularAuthors;

PROMPT Displaying: Borrowing Details
SELECT * FROM BorrowingDetails;

PROMPT Displaying: Member Borrowing Summary
SELECT * FROM MemberBorrowingSummary;

PROMPT Displaying: Book Availability View
SELECT * FROM BookAvailabilityView;
-------------------------------------------------------------------------------------------------------------------