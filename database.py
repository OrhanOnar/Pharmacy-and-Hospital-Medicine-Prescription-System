from sqlalchemy.engine import create_engine

DIALECT = 'oracle'
SQL_DRIVER = 'cx_oracle'
USERNAME = 'Health'  # enter your username
PASSWORD = '1042'  # enter your password
HOST = 'localhost'  # enter the oracle db host url
PORT = 1521  # enter the oracle port number
SERVICE = 'xe'  # enter the oracle db service name
ENGINE_PATH_WIN_AUTH = DIALECT + '+' + SQL_DRIVER + '://' + USERNAME + ':' + PASSWORD + '@' + HOST + ':' + str(
    PORT) + '/?service_name=' + SERVICE

engine = create_engine(ENGINE_PATH_WIN_AUTH)


def find_sno(usersno):

    with engine.connect() as con:
        username = con.execute('SELECT "sno" FROM PERSON WHERE "sno"=:no',no=usersno)
        resultset = []
        for row in username:
            resultset.append(dict(row))
        result=resultset[0]['sno']


    return result

def find_pw(usersno):

    with engine.connect() as con:
        password = con.execute('SELECT "pass" FROM PERSON WHERE "sno"=:no',no=usersno)
        resultset = []
        for row in password:
            resultset.append(dict(row))
        result = resultset[0]['pass']

    return result

def is_Doctor(usersno):
    with engine.connect() as con:
        username = con.execute('SELECT "sno" FROM DOCTOR WHERE "sno"=:no',no=usersno)
        resultset = []
        for row in username:
            resultset.append(dict(row))
        if len(resultset) != 0:
            return 1
        else:
            return 0

def is_Patient(usersno):
    with engine.connect() as con:
        username = con.execute('SELECT "sno" FROM PATIENT WHERE "sno"=:no',no=usersno)
        resultset = []
        for row in username:
            resultset.append(dict(row))
        if len(resultset) != 0:
            return 1
        else:
            return 0

def is_Pharmacist(usersno):
    with engine.connect() as con:
        username = con.execute('SELECT "sno" FROM PHARMACIST WHERE "sno"=:no',no=usersno)
        resultset = []
        for row in username:
            resultset.append(dict(row))
        if len(resultset) != 0:
            return 1
        else:
            return 0



def all_sno():
    with engine.connect() as con:
        username=con.execute('SELECT * FROM PERSON')

    return username

def patient_history(patientno):
    with engine.connect() as con:
        history = con.execute('SELECT * FROM PATIENT P, PRESCRIPTION PRE, CONTENT C WHERE P."sno" = PRE."sno_pat" AND PRE."pres_no" = C."pres_no" AND P."sno"=:no GROUP BY P."pres_no"',no=patientno)
        resultset = []
        for row in history:
            resultset.append(dict(row))
        return resultset
    
def check_doctor_auth(doctorno):
    with engine.connect() as con:
        auth = con.execute('SELECT AC."mname", AC."atc_name" FROM ACTIVE_INGREDIENT AC WHERE AC."atc_code" IN ( SELECT "atc_code" FROM ATC_AUTH AA, DOCTOR D WHERE AA."branch" = D."branch" AND D."sno" =:no)',no=doctorno)
        resultset = []
        for row in auth:
            resultset.append(dict(row))
        return resultset

def check_pharmacy_depot_inv():
    with engine.connect() as con:
        inv = con.execute('SELECT M."mname", H."build_name" FROM MEDICINE M, DEPOT D, INVENTORY I, HEALTH_INSTITUTION H WHERE  D."tax_no" = I."tax_no" AND M."bcode" = I."bcode" AND H."tax_no"=D."tax_no" SORT BY M."mname" ASC')
        resultset = []
        for item in inv:
            resultset.append(dict(item))
        return resultset

def create_prescription(doctorno, patientno, bcode, amount):
    with engine.connect() as con:
        con.execute('INSERT INTO PRESCRIPTION (sno_doc, sno_pat, pres_no, expire, provision) VALUES (:sno1, :sno2, pres_seq.nextval,  DATEADD(month, 3, (SELECT LOCALTIMESTAMP FROM dual)), (SELECT LOCALTIMESTAMP FROM dual))', sno1=doctorno, sno2=patientno)
        for i in range(0, len(bcode)):
            con.execute('INSERT INTO CONTENT (pres_no, bcode, amount) VALUES (pres_seq.currval, :bc, :amou)', bc=bcode[i], amou=amount[i]) 
        return
    

