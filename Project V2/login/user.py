from flask_login import UserMixin

class User(UserMixin):

    def __init__(self, username):
        self.username = username

    @property
    def is_authenticated(self):
        return True

    @property
    def is_anonymous(self):
        return False

    @property
    def is_active(self):
        return True

    def get_id(self):
        return self.username