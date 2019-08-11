from django.db import models
from profesionales.models import Cliente

# Create your models here.

class Servicio(models.Model):
    description = models.CharField(max_length=128)
    solicitante = models.OneToOneField(Cliente)
    profesional = models.OneToOneField(Profesional) #No es obligatorio


class Puja(models.Model):
    servicio = models.OneToOneField(Servicio)
