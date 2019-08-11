from django.db import models
from django.contrib.auth.models import User

# Create your models here.

class Profesion(models.Model):
    name = models.CharField(max_length=128)

class Profesional(models.Model):
    ruser = models.OneToOneField(User)
    profesiones = models.ManyToManyField(Profesion)

class Cliente(models.Model):
    ruser = models.OneToOneField(User)

