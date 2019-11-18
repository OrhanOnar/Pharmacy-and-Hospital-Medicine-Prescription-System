DROP TABLE ATC_AUTH CASCADE CONSTRAINTS;
DROP TABLE PHARMACIST CASCADE CONSTRAINTS;
DROP TABLE PHARMACY CASCADE CONSTRAINTS;
DROP TABLE INVENTORY CASCADE CONSTRAINTS;
DROP TABLE PATIENT CASCADE CONSTRAINTS;
DROP TABLE TRANSA CASCADE CONSTRAINTS;
DROP TABLE DEPOT CASCADE CONSTRAINTS;
DROP TABLE CONTENT CASCADE CONSTRAINTS;
DROP TABLE DOCTOR CASCADE CONSTRAINTS;
DROP TABLE PERSON CASCADE CONSTRAINTS;
DROP TABLE MEDICINE CASCADE CONSTRAINTS;
DROP TABLE PRESCRIPTION CASCADE CONSTRAINTS;
DROP TABLE HEALTH_INSTITUTION CASCADE CONSTRAINTS;

CREATE TABLE PERSON (
  sno   number(12) NOT NULL,
  fname   varchar(15)   NOT NULL,
  lname   varchar(15)   NOT NULL,
  pass    varchar(8)    NOT NULL,
  bdate    date,
  sex      char,
  PRIMARY KEY (sno)
);

CREATE TABLE DOCTOR (
  sno           number(12)	NOT NULL,
  branch        varchar(25),
  expertise      varchar(25),
  tax_no       varchar(25),
  PRIMARY KEY (sno),
  FOREIGN KEY (sno) REFERENCES PERSON(sno) ON DELETE CASCADE

);

CREATE TABLE PATIENT (
  sno   number(12) NOT NULL,
  PRIMARY KEY (sno),
  FOREIGN KEY (sno) REFERENCES PERSON(sno) ON DELETE CASCADE
);

CREATE TABLE PRESCRIPTION (
  sno_doc number(12)    NOT NULL UNIQUE,
  sno_pat number(12)    NOT NULL UNIQUE,
  pres_no number(10)    NOT NULL UNIQUE,
  ldtu date,
  kind varchar(10) ,
  PRIMARY KEY (sno_doc, sno_pat, pres_no),      
  FOREIGN KEY (sno_doc) REFERENCES DOCTOR(sno),
  FOREIGN KEY (sno_pat) REFERENCES PATIENT(sno)

);

CREATE TABLE MEDICINE (
  bcode      number(13)	NOT NULL,
  mname      varchar(25),
  atc_name   varchar(50),
  atc_code  varchar(7),
  use_type  varchar(15),
PRIMARY KEY (bcode) 
);

CREATE TABLE ATC_AUTH (
  sno      number(13)	NOT NULL UNIQUE,
  atc_code  varchar(7) NOT NULL,
  PRIMARY KEY (sno, atc_code),
  FOREIGN KEY (sno) REFERENCES DOCTOR(sno) ON DELETE CASCADE
);

CREATE TABLE CONTENT (
  pres_no    number(10) NOT NULL,
  bcode  decimal(13)    NOT NULL,
  amount number(2),
  FOREIGN KEY (pres_no) REFERENCES PRESCRIPTION(pres_no) ON  DELETE CASCADE,
  FOREIGN KEY (bcode) REFERENCES MEDICINE(bcode) ON DELETE CASCADE,
  PRIMARY KEY (pres_no, bcode)
);

CREATE TABLE HEALTH_INSTITUTION (
  tax_no      number(10)	NOT NULL,
  address     varchar(100),
PRIMARY KEY (tax_no)
);

CREATE TABLE PHARMACY (
  tax_no   number(10)	NOT NULL,
  pname varchar(25),
  PRIMARY KEY (tax_no),
  FOREIGN KEY (tax_no) REFERENCES HEALTH_INSTITUTION(tax_no) ON DELETE CASCADE
);

CREATE TABLE PHARMACIST (
  sno      number(12)	NOT NULL,
  tax_no   number(10),
  PRIMARY KEY(sno),
  FOREIGN KEY (sno) REFERENCES PERSON(sno) ON DELETE CASCADE,
  FOREIGN KEY (tax_no) REFERENCES PHARMACY(tax_no)
);


CREATE TABLE INVENTORY (	
  tax_no   number(10)	NOT NULL,
  bcode decimal(13)	NOT NULL,
  amount number(3),
  FOREIGN KEY (tax_no) REFERENCES HEALTH_INSTITUTION(tax_no) ON DELETE CASCADE,
  FOREIGN KEY (bcode) REFERENCES MEDICINE(bcode),
  PRIMARY KEY (tax_no, bcode)
);

CREATE TABLE DEPOT (
  tax_no   number(10)	NOT NULL,
  dname    varchar(25),
FOREIGN KEY (tax_no) REFERENCES HEALTH_INSTITUTION(tax_no) ON DELETE CASCADE,
PRIMARY KEY (tax_no)
);

CREATE TABLE TRANSA (
  trans_id number(10),
  tax_no_dep   number(10),
  tax_no_ph number(10),  
  amount  number(3),
  time_of_trans date,
  PRIMARY KEY (tax_no_dep, tax_no_ph, trans_id),
  FOREIGN KEY (tax_no_dep) REFERENCES DEPOT(tax_no),
  FOREIGN KEY (tax_no_ph) REFERENCES PHARMACY(tax_no)

);

CREATE SEQUENCE trans_seq START WITH 1;

CREATE OR REPLACE TRIGGER trans_trig 
BEFORE INSERT ON TRANSA 
FOR EACH ROW
BEGIN
  SELECT trans_seq.NEXTVAL
  INTO   :new.trans_id
  FROM   dual
END;

CREATE SEQUENCE pres_seq START WITH 1;

CREATE OR REPLACE TRIGGER pres_trig 
BEFORE INSERT ON PRESCRIPTION 
FOR EACH ROW
BEGIN
  SELECT pres_seq.NEXTVAL
  INTO   :new.pres_no
  FROM   dual
END;



