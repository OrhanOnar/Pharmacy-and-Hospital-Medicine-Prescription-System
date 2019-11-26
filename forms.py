from flask_wtf import FlaskForm
from wtforms import StringField
from wtforms.validators import DataRequired


class LoginForm(FlaskForm):
    username = StringField('TC NO', validators=[DataRequired()])
    password = StringField('SIFRE', validators=[DataRequired()])

