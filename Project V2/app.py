from flask import Flask, render_template, request, flash, redirect ,url_for
from forms import LoginForm
from database import find_sno, is_Doctor, find_pw, is_Pharmacist, is_Patient
import os
from flask_login import login_user , LoginManager, login_required
from user import User

app = Flask(__name__)
SECRET_KEY = os.urandom(32)
app.config['SECRET_KEY'] = SECRET_KEY
app.config["SQLALCHEMY_ECHO"] = True
login = LoginManager(app)
login.login_view = 'login'


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
                return redirect(url_for('pharmacist', user_id=username))
    return render_template('login.html', form=form)

@login_required
@app.route('/doctor/<user_id>',methods=['GET','POST'])
def doctor(user_id):

    return render_template('doctor.html')

@login_required
@app.route('/patient/<user_id>',methods=['GET','POST'])
def patient(user_id):

    return render_template('patient.html')

@login_required
@app.route('/receteNoGiris/<user_id>',methods=['GET','POST'])
def pharmacist(user_id):

    return render_template('receteNoGiris.html')


if __name__ == '__main__':
    app.debug(True)
    app.run()
