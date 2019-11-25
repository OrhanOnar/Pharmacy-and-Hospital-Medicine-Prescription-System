INSERT INTO PERSON ("sno", "fname", "lname", "pass", "bdate", "sex") VALUES ('7531845105175','Stephanie', 'Henderson', '37591701', '29-may-1981', 'F');
INSERT INTO PERSON ("sno", "fname", "lname", "pass", "bdate", "sex") VALUES ('9695041605900','Nicholas', 'Moore', '53840823', '28-may-1975', 'M');
INSERT INTO PERSON ("sno", "fname", "lname", "pass", "bdate", "sex") VALUES ('3126185921650','Anne', 'Walker', '75690217', '11-may-1982', 'M');
INSERT INTO PERSON ("sno", "fname", "lname", "pass", "bdate", "sex") VALUES ('7429468439592','Theresa', 'Thomas', '48485110', '29-may-2006', 'M');
INSERT INTO PERSON ("sno", "fname", "lname", "pass", "bdate", "sex") VALUES ('7651535926853','Shawn', 'Cox', '20319255', '30-may-2000', 'M');
INSERT INTO PERSON ("sno", "fname", "lname", "pass", "bdate", "sex") VALUES ('4789771114476','Janet', 'Lewis', '14412783', '16-may-1983', 'M');
INSERT INTO PERSON ("sno", "fname", "lname", "pass", "bdate", "sex") VALUES ('2730742262184','Helen', 'Davis', '75544924', '13-may-2005', 'M');
INSERT INTO PERSON ("sno", "fname", "lname", "pass", "bdate", "sex") VALUES ('8691510706549','Bonnie', 'Nelson', '41001608', '23-may-1985', 'F');
INSERT INTO PERSON ("sno", "fname", "lname", "pass", "bdate", "sex") VALUES ('1115928161898','Patricia', 'Jenkins', '84795344', '10-may-1988', 'M');
INSERT INTO PERSON ("sno", "fname", "lname", "pass", "bdate", "sex") VALUES ('6254820969606','Walter', 'Bryant', '83498797', '27-may-1974', 'M');
INSERT INTO PERSON ("sno", "fname", "lname", "pass", "bdate", "sex") VALUES ('2190677019109','Craig', 'Murphy', '55518887', '23-may-1976', 'M');
INSERT INTO PERSON ("sno", "fname", "lname", "pass", "bdate", "sex") VALUES ('6138159040054','Kenneth', 'Jones', '87753305', '7-may-1976', 'F');

INSERT INTO HEALTH_INSTITUTION ("tax_no", "build_name", "address") VALUES ('6309227187', 'Atatürk Eğitim Ve Araştırma Hastanesi', 'Eskişehir Yolu 8.km No:2 Bilkent Ankara');
INSERT INTO HEALTH_INSTITUTION ("tax_no", "build_name", "address") VALUES ('1301713466', 'Dr. Zekai Tahir Burak Kadın Sağlığı Eğitim Ve Araştırma Hastanesi', 'Gündoğdu Mah. Karacaey Sokak Hamamönü Mamak Ankara');
INSERT INTO HEALTH_INSTITUTION ("tax_no", "build_name", "address") VALUES ('6670457814', 'Türkiye Yüksek İhtisas Eğitim Ve Araştırma Hastanesi', 'Ülkü Mah. Sıhhıye Ankara');
INSERT INTO HEALTH_INSTITUTION ("tax_no", "build_name", "address") VALUES ('2712899171', 'Ankara Ceza İnfaz Kurumları Kampüs Hastanesi', 'Sincan –Yenikent Ankara');
INSERT INTO HEALTH_INSTITUTION ("tax_no", "build_name", "address") VALUES ('5886307428', 'Bakırköy Devlet Hastanesi', 'Zuhuratbaba Mah., Dr. Tevfik Sağlam Cad., No:25/1, Bakırköy, İstanbul');
INSERT INTO HEALTH_INSTITUTION ("tax_no", "build_name", "address") VALUES ('5408874888', 'Beyoglu Hastanesi', 'Bereketzade Mah., Bereketzade Camii Sok., No:2, Beyoğlu, İstanbul');
INSERT INTO HEALTH_INSTITUTION ("tax_no", "build_name", "address") VALUES ('3589235960', 'Büyükada Devlet Hastanesi', 'Nizam Mah., Karakuş Sok., No:4/1, Adalar, İstanbul');

INSERT INTO PATIENT ("sno") VALUES ('7531845105175');
INSERT INTO PATIENT ("sno") VALUES ('9695041605900');
INSERT INTO PATIENT ("sno") VALUES ('3126185921650');

INSERT INTO PHARMACY ("tax_no") VALUES ('6309227187');
INSERT INTO PHARMACY ("tax_no") VALUES ('1301713466');
INSERT INTO PHARMACY ("tax_no") VALUES ('6670457814');

INSERT INTO PHARMACIST ("sno", "tax_no") VALUES ('7429468439592', '6309227187');
INSERT INTO PHARMACIST ("sno", "tax_no") VALUES ('7651535926853', '1301713466');
INSERT INTO PHARMACIST ("sno", "tax_no") VALUES ('4789771114476', '6670457814');

INSERT INTO DOCTOR ("sno", "branch", "tax_no") VALUES ('2730742262184',null,'2712899171');
INSERT INTO DOCTOR ("sno", "branch", "tax_no") VALUES ('8691510706549',null,'5886307428');

INSERT INTO PRESCRIPTION ("sno_doc","sno_pat", "pres_no", "expire" ,"provision","kind") VALUES ('2730742262184','7531845105175','123','1-may-1976','2-may-1976','flu');
INSERT INTO PRESCRIPTION ("sno_doc","sno_pat", "pres_no", "expire" ,"provision","kind") VALUES ('8691510706549','3126185921650','456','10-may-1976','15-may-1976','cold');


INSERT INTO MEDICINE  ("bcode"  , "mname") VALUES ('123', 'A01AA02');
INSERT INTO MEDICINE  ("bcode"  , "mname") VALUES ('345', 'A01AA05');
INSERT INTO MEDICINE  ("bcode"  , "mname") VALUES ('678', 'A01AB02');
INSERT INTO MEDICINE  ("bcode"  , "mname") VALUES ('442', 'A01AB03');
INSERT INTO MEDICINE  ("bcode"  , "mname") VALUES ('345', 'A01AB05');
INSERT INTO MEDICINE  ("bcode"  , "mname") VALUES ('541', 'A01AB06');


INSERT INTO ACTIVE_INGREDIENT ("mname"      , "atc_name"   , "atc_code"  ) VALUES ('A01AA02', '123', '5');
INSERT INTO ACTIVE_INGREDIENT ("mname" , "atc_name" , "atc_code"  ) VALUES ( 'A01AA05', '1234', '6');
INSERT INTO ACTIVE_INGREDIENT ("mname" , "atc_name" , "atc_code"  ) VALUES ( 'A01AB02', '1235', '4');
INSERT INTO ACTIVE_INGREDIENT ("mname" , "atc_name" , "atc_code"  ) VALUES ( 'A01AB03', '1236',  '3');
INSERT INTO ACTIVE_INGREDIENT ("mname" , "atc_name" , "atc_code"  ) VALUES ( 'A01AB06', '1238', '1');
