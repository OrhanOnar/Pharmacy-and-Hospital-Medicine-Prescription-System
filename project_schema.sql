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
DROP TABLE ACTIVE_INGREDIENT CASCADE CONSTRAINTS;
DROP TABLE MEDICINE_PROPS CASCADE CONSTRAINTS;

DROP SEQUENCE pres_seq;
DROP SEQUENCE trans_seq;

CREATE TABLE PERSON (
  sno   int NOT NULL,
  fname   varchar(15)   NOT NULL,
  lname   varchar(15)   NOT NULL,
  pass    varchar(8)    NOT NULL,
  bdate    date,
  sex      char,
  PRIMARY KEY (sno)
);

CREATE TABLE DOCTOR (
  sno           int	NOT NULL,
  branch        varchar(25),
  expertise      varchar(25),
  tax_no       int NOT NULL UNIQUE,
  PRIMARY KEY (sno),
  FOREIGN KEY (sno) REFERENCES PERSON(sno) ON DELETE CASCADE

);

CREATE TABLE PATIENT (
  sno   int NOT NULL,
  PRIMARY KEY (sno),
  FOREIGN KEY (sno) REFERENCES PERSON(sno) ON DELETE CASCADE
);

CREATE TABLE PRESCRIPTION (
  sno_doc int    NOT NULL UNIQUE,
  sno_pat int    NOT NULL UNIQUE,
  pres_no int    NOT NULL UNIQUE,
  expire date,
  provision date,
  kind varchar(10) ,
  PRIMARY KEY (sno_doc, sno_pat, pres_no),      
  FOREIGN KEY (sno_doc) REFERENCES DOCTOR(sno),
  FOREIGN KEY (sno_pat) REFERENCES PATIENT(sno)

);

CREATE TABLE MEDICINE (
  bcode      int	    NOT NULL,
  mname      varchar(25)    UNIQUE,
  use_type  varchar(15),
  PRIMARY KEY (bcode)
);

CREATE TABLE MEDICINE_PROPS (
  mname      varchar(25)	    NOT NULL,
  brand      varchar(25),
  pack_form  varchar(20),
  use_type  varchar(15),
  howtouse      varchar(100),
  PRIMARY KEY (mname),
  FOREIGN KEY (mname) REFERENCES MEDICINE(mname) ON DELETE CASCADE
);

CREATE TABLE ACTIVE_INGREDIENT (
  mname      varchar(25)    NOT NULL,
  atc_name   varchar(50),
  atc_code  varchar(7),
  PRIMARY KEY (mname, atc_code),
  FOREIGN KEY (mname) REFERENCES MEDICINE(mname) ON DELETE CASCADE 
);

CREATE TABLE ATC_AUTH (
  sno      int	      NOT NULL UNIQUE,
  atc_code  varchar(7) NOT NULL,
  PRIMARY KEY (sno, atc_code),
  FOREIGN KEY (sno) REFERENCES DOCTOR(sno) ON DELETE CASCADE
);

CREATE TABLE CONTENT (
  pres_no    int      NOT NULL,
  bcode      int      NOT NULL,
  amount number(2),
  FOREIGN KEY (pres_no) REFERENCES PRESCRIPTION(pres_no) ON  DELETE CASCADE,
  FOREIGN KEY (bcode) REFERENCES MEDICINE(bcode) ON DELETE CASCADE,
  PRIMARY KEY (pres_no, bcode)
);

CREATE TABLE HEALTH_INSTITUTION (
  tax_no      int	    NOT NULL,
  address     varchar(100),
PRIMARY KEY (tax_no)
);

CREATE TABLE PHARMACY (
  tax_no   int	      NOT NULL,
  pname varchar(25),
  PRIMARY KEY (tax_no),
  FOREIGN KEY (tax_no) REFERENCES HEALTH_INSTITUTION(tax_no) ON DELETE CASCADE
);

CREATE TABLE PHARMACIST (
  sno      int	      NOT NULL,
  tax_no   int        NOT NULL,
  PRIMARY KEY(sno),
  FOREIGN KEY (sno) REFERENCES PERSON(sno) ON DELETE CASCADE,
  FOREIGN KEY (tax_no) REFERENCES PHARMACY(tax_no)
);


CREATE TABLE INVENTORY (	
  tax_no   int	      NOT NULL,
  bcode    int 	      NOT NULL,
  amount number(3),
  FOREIGN KEY (tax_no) REFERENCES HEALTH_INSTITUTION(tax_no) ON DELETE CASCADE,
  FOREIGN KEY (bcode) REFERENCES MEDICINE(bcode),
  PRIMARY KEY (tax_no, bcode)
);

CREATE TABLE DEPOT (
  tax_no   int	      NOT NULL,
  dname    varchar(25),
FOREIGN KEY (tax_no) REFERENCES HEALTH_INSTITUTION(tax_no) ON DELETE CASCADE,
PRIMARY KEY (tax_no)
);

CREATE TABLE TRANSA (
  trans_id int          NOT NULL,
  tax_no_dep   int      NOT NULL,
  tax_no_ph int         NOT NULL,  
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



