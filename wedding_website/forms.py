from flask_wtf import Form
from wtforms import TextField, IntegerField, TextAreaField, SubmitField
from wtforms.validators import Required, Email, Length, ValidationError, URL

def no_robots(form, field):
    if len(field.data) is not 0:
        raise ValidationError("Sorry, you're a robot.")

def required(form, field):
    if field.data is None:
        raise ValidationError("Ezt a mezőt kötelező kitölteni")
class RSVPForm(Form):
      name = TextField('Név', [Required(), Length(5)])
      email = TextField('Email cím',
          [Required(), Email(message="Érvénytelen email cím")])
      factoid = TextField('Another form of ID', [no_robots])
      number = IntegerField(
          'Vendégek száma',
          [required],
          description="Összesen hányan lesztek (veled együtt)")
      name_list = TextAreaField('Név szerint', description="Kérlek soronként egy nevet írj!")
      message = TextAreaField('Üzenet', description="Ha szeretnél nekünk üzenni valamit (pl. ételérzékenység)")
      submit = SubmitField("Küldés")
