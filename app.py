from flask import Flask, render_template, request, flash, redirect ,url_for
from forms import LoginForm
from database import find_sno, is_Doctor, find_pw
import os


app = Flask(__name__)
SECRET_KEY = os.urandom(32)
app.config['SECRET_KEY'] = SECRET_KEY
app.config["SQLALCHEMY_ECHO"] = True


@app.route('/',methods=['GET','POST'])
def home():

    return render_template('home.html')


@app.route('/login/', methods=['GET', 'POST'])
def login():
    form = LoginForm()
    if request.method == 'POST' and form.validate_on_submit():
        username = request.form['username']
        password = request.form['password']
        sno = find_sno(username)
        pw=find_pw(username)

        if sno == username and pw == password:
            if is_Doctor(username):
                return redirect(url_for('doctor'))
        else:
            flash('Incorrect Username/Password Combination')
    return render_template('login.html', form=form)


@app.route('/doctor/',methods=['GET','POST'])
def doctor(usernames):
    user=usernames

    return render_template('doctor.html')


if __name__ == '__main__':
    app.debug(True)
    app.run()
