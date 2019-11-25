from sqlalchemy.engine import create_engine

DIALECT = 'oracle'
SQL_DRIVER = 'cx_oracle'
USERNAME = 'ORHAN'  # enter your username
PASSWORD = 'aweneres'  # enter your password
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

