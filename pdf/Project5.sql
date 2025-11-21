DROP TABLE MatchingGift1 CASCADE CONSTRAINTS;
DROP TABLE EventParticipation1 CASCADE CONSTRAINTS;
DROP TABLE Payment1 CASCADE CONSTRAINTS;
DROP TABLE Pledge1 CASCADE CONSTRAINTS;
DROP TABLE Event1 CASCADE CONSTRAINTS;
DROP TABLE Donor1 CASCADE CONSTRAINTS;
DROP TABLE DonorCircle1 CASCADE CONSTRAINTS;


CREATE TABLE DonorCircle1(
    circleType VARCHAR2(50),
    minAmount NUMBER(10,2),
    maxAmount NUMBER(10,2),
    CONSTRAINT DonorCircle1_pk PRIMARY KEY (circleType)
);

CREATE TABLE Donor1(
    donorId NUMBER GENERATED ALWAYS AS IDENTITY,
    name VARCHAR2(50) NOT NULL,
    DOB DATE,
    address VARCHAR2(100) NOT NULL,
    affiliation VARCHAR2(100),
    preferredPhone VARCHAR2(16),
    circleType VARCHAR2(50),
    CONSTRAINT Donor1_pk PRIMARY KEY (donorId),
    CONSTRAINT Donor1_circleType_fk FOREIGN KEY (circleType)
        REFERENCES DonorCircle1(circleType) ON DELETE SET NULL
);

CREATE TABLE Pledge1(
    pledgeId NUMBER GENERATED ALWAYS AS IDENTITY,
    donorId NUMBER(8) NOT NULL,
    pledgeAmount Number(10,2) CHECK (pledgeAmount > 0),
    pledgeDate DATE NOT NULL,
    CONSTRAINT Pledge1_pk PRIMARY KEY (pledgeID),
    CONSTRAINT Pledge1_donorId_fk FOREIGN KEY (donorId)
        REFERENCES Donor1(donorId) ON DELETE CASCADE
);

CREATE TABLE Payment1(
    paymentId NUMBER GENERATED ALWAYS AS IDENTITY,
    pledgeId NUMBER NOT NULL,
    amountPaid NUMBER(10,2) CHECK (amountPaid >= 0),
    paymentType VARCHAR2(30),
    cardNumber VARCHAR2(16),
    paymentTiming VARCHAR2(30),
    CONSTRAINT Payment1_pk PRIMARY KEY (paymentID),
    CONSTRAINT Payment1_pledgeId_fk FOREIGN KEY (pledgeId)
        REFERENCES Pledge1(pledgeId) ON DELETE CASCADE
);

CREATE TABLE Event1(
    eventId NUMBER GENERATED ALWAYS AS IDENTITY,
    eventName VARCHAR2(200) NOT NULL,
    eventDate DATE NOT NULL,
    eventCost NUMBER(10,2) CHECK (eventCost >= 0),
    CONSTRAINT Event1_pk PRIMARY KEY (eventId)
);

CREATE TABLE EventParticipation1(
    eventId NUMBER NOT NULL,
    donorId NUMBER NOT NULL,
    donationAtEvent NUMBER(10,2) CHECK(donationAtEvent > 0),
    isDonor CHAR(1) DEFAULT 'Y' CHECK (isDonor IN ('Y', 'N')),
    CONSTRAINT EventParticipation1_pk PRIMARY KEY (donorId, eventId),
    CONSTRAINT EventParticipation1_donorId_fk FOREIGN KEY (donorId)
        REFERENCES Donor1(donorId) ON DELETE CASCADE,
    CONSTRAINT EventParticipation1_eventId_fk FOREIGN KEY (eventId)
        REFERENCES Event1(eventId) ON DELETE CASCADE
);

CREATE TABLE MatchingGift1(
    matchingGiftId NUMBER GENERATED ALWAYS AS IDENTITY,
    donorId NUMBER NOT NULL,
    employerName VARCHAR2(50) NOT NULL,
    employerPhone VARCHAR2(13),
    amount Number(10,2) CHECK (amount > 0),
    CONSTRAINT MatchingGift1_pk PRIMARY KEY (matchingGiftId),
    CONSTRAINT MatchingGift1_donorId_fk FOREIGN KEY (donorId)
        REFERENCES Donor1(donorId) ON DELETE CASCADE
);

INSERT INTO DonorCircle1 VALUES ('Student', 0, NULL);
INSERT INTO DonorCircle1 VALUES ('Alumni', 200, 487.99);
INSERT INTO DonorCircle1 VALUES ('Friend', 199, 395.99);

INSERT INTO Donor1(name, DOB, address, affiliation, preferredPhone, circleType) 
VALUES('Liya', TO_DATE('2025-07-12','YYYY-MM-DD'),'oak st','Alumni','099-111','Alumni');
INSERT INTO Donor1(name, DOB, address, affiliation, preferredPhone, circleType) 
VALUES('Lisa', TO_DATE('2005-09-27','YYYY-MM-DD'), 'brook st','Friend','009-234','Friend');
INSERT INTO Donor1(name, DOB, address, affiliation, preferredPhone, circleType) 
VALUES('Mark', TO_DATE('2003-03-13','YYYY-MM-DD'),'pine ave','Student','785-675','Student');
INSERT INTO Donor1(name, DOB, address, affiliation, preferredPhone, circleType) 
VALUES('Patricia', TO_DATE('2007/07/17','YYYY-MM-DD'),'river st','Alumni','256-756','Alumni');
INSERT INTO Donor1(name, DOB, address, affiliation, preferredPhone, circleType) 
VALUES('Maria', TO_DATE('2007/08/19','YYYY-MM-DD'),'hills rd','Friend','023-465','Friend');


INSERT INTO Pledge1(donorId, pledgeAmount, pledgeDate) 
VALUES(1, 200, TO_DATE('2025-07-12','YYYY-MM-DD'));
INSERT INTO Pledge1(donorId, pledgeAmount, pledgeDate)
VALUES(2, 400, TO_DATE('2025-06-12','YYYY-MM-DD'));
INSERT INTO Pledge1(donorId, pledgeAmount, pledgeDate) 
VALUES(3, 600, TO_DATE('2025-05-12','YYYY-MM-DD'));
INSERT INTO Pledge1(donorId, pledgeAmount, pledgeDate) 
VALUES(4, 800, TO_DATE('2025-03-12','YYYY-MM-DD'));
INSERT INTO Pledge1(donorId, pledgeAmount, pledgeDate) 
VALUES(5, 900, TO_DATE('2025-01-12','YYYY-MM-DD'));

INSERT INTO Payment1 (pledgeId, amountPaid, paymentType, cardNumber, paymentTiming)
VALUES (1, 100.00, 'Credit', '123456789012', 'Monthly');
INSERT INTO Payment1 (pledgeId, amountPaid, paymentType, cardNumber, paymentTiming)
VALUES (2, 250.00, 'Cash', '434868338357', 'One-time');
INSERT INTO Payment1 (pledgeId, amountPaid, paymentType, cardNumber, paymentTiming)
VALUES (3, 150.00, 'Debit', '987654321012', 'One-time');
INSERT INTO Payment1 (pledgeId, amountPaid, paymentType, cardNumber, paymentTiming)
VALUES (4, 100.00, 'Credit', '555555555555', 'Monthly');
INSERT INTO Payment1 (pledgeId, amountPaid, paymentType, cardNumber, paymentTiming)
VALUES (5, 300.00, 'Cash', '376493902556', 'One-time');

INSERT INTO Event1 (eventName, eventDate, eventCost)
VALUES ('Charity Gala', TO_DATE('2025-06-20','YYYY-MM-DD'), 50.00);
INSERT INTO Event1 (eventName, eventDate, eventCost)
VALUES ('Fundraiser Dinner', TO_DATE('2025-07-10','YYYY-MM-DD'), 75.00);
INSERT INTO Event1 (eventName, eventDate, eventCost)
VALUES ('Volunteer Fair', TO_DATE('2025-08-01','YYYY-MM-DD'), 1.00);
INSERT INTO Event1 (eventName, eventDate, eventCost)
VALUES ('Alumni Meetup', TO_DATE('2025-09-12','YYYY-MM-DD'), 25.00);
INSERT INTO Event1 (eventName, eventDate, eventCost)
VALUES ('Donor Appreciation Night', TO_DATE('2025-10-05','YYYY-MM-DD'), 100.00);

INSERT INTO EventParticipation1 VALUES (1, 1, 50.00, 'Y');
INSERT INTO EventParticipation1 VALUES (2, 2, 100.00, 'Y');
INSERT INTO EventParticipation1 VALUES (3, 3, 1.00, 'N');
INSERT INTO EventParticipation1 VALUES (4, 4, 20.00, 'Y');
INSERT INTO EventParticipation1 VALUES (5, 5, 150.00, 'Y');

INSERT INTO MatchingGift1 (donorId, employerName, employerPhone, amount)
VALUES (2, 'FoodService', '555-7777', 500.00);
INSERT INTO MatchingGift1 (donorId, employerName, employerPhone, amount)
VALUES (3, 'MedicalCenter', '555-8888', 150.00);
INSERT INTO MatchingGift1 (donorId, employerName, employerPhone, amount)
VALUES (5, 'EductaionPurpose', '555-9999', 300.00);
INSERT INTO MatchingGift1 (donorId, employerName, employerPhone, amount)
VALUES (1, 'StudentAid', '555-1212', 200.00);
INSERT INTO MatchingGift1 (donorId, employerName, employerPhone, amount)
VALUES (4, 'FoodDrive', '555-3434', 100.00);



CREATE OR REPLACE VIEW Donor_Public_View AS
SELECT donorId, name, affiliation, circleType
FROM Donor1;

CREATE OR REPLACE VIEW Payment_Public_View AS
SELECT paymentId, pledgeId, amountPaid, paymentType, paymentTiming
FROM Payment1;

SELECT * FROM Donor_Public_View;
SELECT * FROM Payment_Public_View;

CREATE OR REPLACE VIEW Payment_Amount AS 
SELECT paymentId, pledgeId, amountPaid, paymentType
FROM Payment1
WHERE amountPaid >= 150;

SELECT * FROM Payment_Amount;


CREATE TABLE Audit_Payment(
    dateAndTimeOfUpdate DATE,
    userId VARCHAR2(20),
    oldPaymentId NUMBER,
    oldAmount NUMBER(10,2),
    newAmount NUMBER(10,2),
    CONSTRAINT paymentAudit_pk PRIMARY KEY(dateAndTimeOfUpdate, userId)
);

CREATE OR REPLACE TRIGGER PaymentAuditTrail
BEFORE UPDATE OF amountPaid ON Payment1
FOR EACH ROW
BEGIN 
    INSERT INTO Audit_Payment
    VALUES (SYSDATE, USER, :OLD.paymentId, :OLD.amountPaid, :NEW.amountPaid);
END;
/

UPDATE Payment1
SET amountPaid = 999
WHERE paymentId = 1;

SELECT * FROM Audit_Payment;
ROLLBACK;