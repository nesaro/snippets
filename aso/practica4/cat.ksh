#!/bin/ksh

#se le pasa un argumento el pathname. si existe , leible, regular entonces leo cada una de sus lineas

#exec asocia canales a archivos .. exec canal[0..9]{<,>}path

if [[ -r $1 && -f $1 ]] then
exec 3<$1
while read -u3 LINEA
do
print $LINEA
done
fi



