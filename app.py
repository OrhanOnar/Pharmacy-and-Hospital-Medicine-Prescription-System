from flask import Flask, render_template, request, redirect ,url_for
from forms import LoginForm
from database import find_sno, is_Doctor, find_pw, is_Pharmacist, is_Patient, patient_history, find_name, prescription
import os
from flask_login import login_user , LoginManager, login_required
from user import User


app = Flask(__name__)


SECRET_KEY = os.urandom(32)
app.config['SECRET_KEY'] = SECRET_KEY
app.config["SQLALCHEMY_ECHO"] = True
login = LoginManager(app)
login.login_view = 'login'

@app.route('/contact-us/',methods=['GET','POST'])
def contact_us():

    return render_template('contact-us.html')

@app.route('/bildirim/',methods=['GET','POST'])
def bildirim():

    return render_template('bildirim.html')

@login.user_loader
def load_user(sno):
    return sno


@app.route('/',methods=['GET','POST'])
def index():

    return render_template('index.html')


@app.route('/login/', methods=['GET', 'POST'])
def login():
    form = LoginForm()
    if request.method == 'POST' and form.validate_on_submit():
        username = request.form['username']
        password = request.form['password']
        sno = find_sno(username)
        pw=find_pw(username)
        if sno == username and pw == password:
            user_obj=User(username)
            login_user(user_obj,remember=True)
            if is_Doctor(sno):
                return redirect(url_for('doctor',user_id=username))
            elif is_Patient(sno):
                return redirect(url_for('patient', user_id=username))
            elif is_Pharmacist(sno):
                return redirect(url_for('receteNoGiris', user_id=username))
    return render_template('login.html', form=form)

@login_required
@app.route('/DoktorEkranı/<user_id>',methods=['GET','POST'])
def doctor(user_id):

    return render_template('DoktorEkranı.html')

@login_required
@app.route('/Hasta ekranı/<user_id>',methods=['GET','POST'])
def patient(user_id):
    x=""

    dict_patient=patient_history(user_id)
    x = "DOKTOR : " + find_name(dict_patient[0]['sno_doc']) + "\n" + "HASTA : " + find_name(
        dict_patient[0]['sno_pat']) + "\n" + "REÇETE NUMARASI : " + str(dict_patient[0]['pres_no']) + "\n" + "TARİHİ : " + str(
        dict_patient[0]['expire']) + "\n" + "GEÇERLİLİĞİ : " + str(dict_patient[0]['provision']) + "\n" + "İLAÇ : " + dict_patient[0]['kind']
    name=find_name(user_id)

    return render_template('Hasta ekranı.html',name=name, patient=x)

@login_required
@app.route('/receteNoGiris/<user_id>/',methods=['GET','POST'])
def receteNoGiris(user_id):
    x=""

    if request.method == 'POST':
        pres_no = str(request.form.get('recete_no'))
        pres = prescription(pres_no)
        x="DOKTOR : " +find_name(pres[0]['sno_doc']) + "\n" + "HASTA : " +find_name(pres[0]['sno_pat']) + "\n"  + "REÇETE NUMARASI : " + str(pres[0]['pres_no']) + "\n" + "TARİHİ : " + str(pres[0]['expire'])+ "\n"  + "GEÇERLİLİĞİ : " + str(pres[0]['provision'])+ "\n"  + "İLAÇ : " + pres[0]['kind']


    return render_template('receteNoGiris.html',user_id=user_id,prescript=x)





if __name__ == '__main__':
    app.debug(True)
    app.run()
