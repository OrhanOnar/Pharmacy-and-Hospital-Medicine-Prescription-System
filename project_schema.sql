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
DROP TABLE TRANSA_CONTENT CASCADE CONSTRAINTS;
DROP TABLE MEDICINE_PROPS CASCADE CONSTRAINTS;
DROP TABLE RECEIPT CASCADE CONSTRAINTS;
DROP TABLE RECEIPT_CONTENT CASCADE CONSTRAINTS;

DROP SEQUENCE rec_seq;
DROP SEQUENCE pres_seq;
DROP SEQUENCE trans_seq;

CREATE TABLE PERSON (
  "sno"   varchar(13) NOT NULL,
  "fname"   varchar(15)   NOT NULL,
  "lname"   varchar(15)   NOT NULL,
  "pass"    varchar(8)    NOT NULL,
  "bdate"    date,
  "sex"      char,
  PRIMARY KEY ("sno")
);

CREATE TABLE PATIENT (
  "sno"   varchar(13) NOT NULL,
  PRIMARY KEY ("sno"),
  FOREIGN KEY ("sno") REFERENCES PERSON("sno") ON DELETE CASCADE
);

CREATE TABLE MEDICINE (
  "bcode"      varchar(13)	    NOT NULL,
  "mname"      varchar(25)    NOT NULL UNIQUE,
  "use_type"  varchar(15),
  PRIMARY KEY ("bcode")
);

CREATE TABLE MEDICINE_PROPS (
  "mname"      varchar(25)	    NOT NULL,
  "brand"      varchar(25),
  "pack_form"  varchar(20),
  "use_type"  varchar(15),
  "howtouse"      varchar(100),
  PRIMARY KEY ("mname"),
  FOREIGN KEY ("mname") REFERENCES MEDICINE("mname") ON DELETE CASCADE
);

CREATE TABLE ACTIVE_INGREDIENT (
  "mname"      varchar(25)    NOT NULL,
  "atc_name"   varchar(50),
  "atc_code"  varchar(8),
  PRIMARY KEY ("mname", "atc_code"),
  FOREIGN KEY ("mname") REFERENCES MEDICINE("mname") ON DELETE CASCADE 
);

CREATE TABLE HEALTH_INSTITUTION (
  "tax_no"      varchar(10)	    NOT NULL,
  "build_name"  varchar(80)     NOT NULL,
  "address"     varchar(120),
   PRIMARY KEY ("tax_no")
);

CREATE TABLE ATC_AUTH (
  "branch"     varchar(40)	NOT NULL UNIQUE,
  "atc_code"  varchar(8)          NOT NULL,
  PRIMARY KEY ("branch", "atc_code")
);

CREATE TABLE DOCTOR (
  "sno"           varchar(13)	NOT NULL,
  "branch"        varchar(40),
  "tax_no"      varchar(10) NOT NULL UNIQUE,
  PRIMARY KEY ("sno"),
  FOREIGN KEY ("sno") REFERENCES PERSON("sno") ON DELETE CASCADE,
  FOREIGN KEY ("tax_no") REFERENCES HEALTH_INSTITUTION("tax_no"),
  FOREIGN KEY ("branch") REFERENCES ATC_AUTH("branch")
);

CREATE TABLE PRESCRIPTION (
  "sno_doc" varchar(13)    NOT NULL UNIQUE,
  "sno_pat" varchar(13)    NOT NULL UNIQUE,
  "pres_no" int    NOT NULL UNIQUE,
  "expire" date,
  "provision" date,
  "kind" varchar(10) ,
  PRIMARY KEY ("sno_doc", "sno_pat", "pres_no"),      
  FOREIGN KEY ("sno_doc") REFERENCES DOCTOR("sno"),
  FOREIGN KEY ("sno_pat") REFERENCES PATIENT("sno")
);

CREATE TABLE CONTENT (
  "pres_no"    int      NOT NULL,
  "bcode"      varchar(13)      NOT NULL,
  "amount" number(2),
  FOREIGN KEY ("pres_no") REFERENCES PRESCRIPTION("pres_no") ON  DELETE CASCADE,
  FOREIGN KEY ("bcode") REFERENCES MEDICINE("bcode") ON DELETE CASCADE,
  PRIMARY KEY ("pres_no", "bcode")
);

CREATE TABLE PHARMACY (
  "tax_no"   varchar(10)	      NOT NULL,
  PRIMARY KEY ("tax_no"),
  FOREIGN KEY ("tax_no") REFERENCES HEALTH_INSTITUTION("tax_no") ON DELETE CASCADE
);

CREATE TABLE PHARMACIST (
  "sno"      varchar(13)	      NOT NULL,
  "tax_no"   varchar(10)        NOT NULL,
  PRIMARY KEY("sno"),
  FOREIGN KEY ("sno") REFERENCES PERSON("sno") ON DELETE CASCADE,
  FOREIGN KEY ("tax_no") REFERENCES PHARMACY("tax_no")
);


CREATE TABLE INVENTORY (	
  "tax_no"   varchar(10)	      NOT NULL,
  "bcode"    varchar(13) 	      NOT NULL,
  "amount" number(3),
  PRIMARY KEY ("tax_no", "bcode"),
  FOREIGN KEY ("tax_no") REFERENCES HEALTH_INSTITUTION("tax_no") ON DELETE CASCADE,
  FOREIGN KEY ("bcode") REFERENCES MEDICINE("bcode"),
);

CREATE TABLE RECEIPT (
  "phar_tax_no" varchar(10) NOT NULL,
  "pat_sno"  varchar(13) NOT NULL,
  "receipt_id"  int     NOT NULL UNIQUE,
  PRIMARY KEY("phar_tax_no", pat_tax_no", "receipt_id"),
  FOREIGN KEY ("phar_tax_no") REFERENCES PHARMACY("tax_no"),
  FOREIGN KEY ("pat_sno") REFERENCES PATIENT("sno") ON DELETE CASCADE
 );
              
 CREATE TABLE RECEIPT_CONTENT (
  "receipt_id"  int         NOT NULL,
  "bcode"     varchar(13)   NOT NULL,
  "amount"    number(2),
  PRIMARY KEY("receipt_id", "bcode"),
  FOREIGN KEY ("bcode") REFERENCES MEDICINE("bcode"),
  FOREIGN KEY ("receipt_id") REFERENCES RECEIPT("receipt_id") ON DELETE CASCADE
 );            

CREATE TABLE DEPOT (
  "tax_no"   varchar(10)	      NOT NULL,
  FOREIGN KEY ("tax_no") REFERENCES HEALTH_INSTITUTION("tax_no") ON DELETE CASCADE,
  PRIMARY KEY ("tax_no")
);

CREATE TABLE TRANSA (
  "trans_id"     int      NOT NULL,
  "tax_no_dep"    varchar(10)      NOT NULL,
  "tax_no_ph"     varchar(10)      NOT NULL,
  "time_of_trans" date,
  PRIMARY KEY ("trans_id"),
  FOREIGN KEY ("tax_no_dep") REFERENCES DEPOT("tax_no"),
  FOREIGN KEY ("tax_no_ph") REFERENCES PHARMACY("tax_no")
);

CREATE TABLE TRANSA_CONTENT (
  "trans_id"     int      NOT NULL,
  "bcode"         varchar(13)      NOT NULL,
  "amount"    number(3),
  PRIMARY KEY ("trans_id", "bcode"),
  FOREIGN KEY ("trans_id") REFERENCES TRANSA("trans_id"),
  FOREIGN KEY ("bcode") REFERENCES MEDICINE("bcode")
);


CREATE SEQUENCE trans_seq
  MINVALUE 1
  MAXVALUE 20000000
  START WITH 1
  INCREMENT BY 1
  NOCYCLE
  CACHE 150;
              
CREATE SEQUENCE pres_seq
  MINVALUE 1
  MAXVALUE 20000000
  START WITH 1
  INCREMENT BY 1
  NOCYCLE
  CACHE 150;
              
CREATE SEQUENCE rec_seq
  MINVALUE 1
  MAXVALUE 20000000
  START WITH 1
  INCREMENT BY 1
  NOCYCLE
  CACHE 150;
