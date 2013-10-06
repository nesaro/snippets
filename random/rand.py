#!/usr/bin/python
import random
salida = ""
for i in range(65536):
    salida = salida + str(random.choice((0,1)))
print(salida)

