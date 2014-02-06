$NPAGINASX=4
$NPAGINASY=3
$TAMANOPAGINA=$TAMANOPAGINAX.to_s+"x"+$TAMANOPAGINAY.to_s
$ZONADECORTE=0.9 #10% en borde

$FICHERO="Diagramaprincipal3.png"
$TAMANOIMAGENX=3997
$TAMANOIMAGENY=2915

#TOTAL=(num-1)*xz +xz +2(num-1)*(1-x)z
#TOTAL=[(num-1)*x +x +2(num-1)*(1-x)]z
#TOTAL=[(num-1)*x +x +(num-1)*(2-2x)]z
#TOTAL=[(num-1)*(2-x)+x]z
#TOTAL=[(2num-2)+(x-numx)+x]z
#TOTAL=[(2num-2)+(2-num)x]z
#
#TOTAL=z(num)+(2*num-1*x)z
#TOTAL=[num+(2*(num-1)*x]z
#TOTAL=[num+(2num-2)*x]z
#

#TAMANOPAGINAX=$TAMANOIMAGENX/(((2*$NPAGINASX)-2)+((2-$NPAGINASX)*$ZONADECORTE))
#TAMANOPAGINAY=$TAMANOIMAGENY/(((2*$NPAGINASY)-2)+((2-$NPAGINASY)*$ZONADECORTE))
#TAMANOPAGINAX=$TAMANOIMAGENX/$NPAGINASX
#TAMANOPAGINAY=$TAMANOIMAGENY/$NPAGINASY
TAMANOPAGINAX=$TAMANOIMAGENX/(1+($NPAGINASX-1)*$ZONADECORTE)
TAMANOPAGINAY=$TAMANOIMAGENY/(1+($NPAGINASY-1)*$ZONADECORTE)
$TAMANOPAGINA=TAMANOPAGINAX.to_s+"x"+TAMANOPAGINAY.to_s

sumax=0
#Redondeo superior estaria perfect
($NPAGINASX).times { |x|
	sumay=0
	($NPAGINASY).times{ |y|
		orden="convert -limit memory 32 -limit map 32  #{$FICHERO} -crop #{$TAMANOPAGINA}+#{sumax.to_s}+#{sumay.to_s}  part_image#{x.to_s}.#{y.to_s}.png"
		system(orden)
		sumay+=TAMANOPAGINAY*$ZONADECORTE
	}
	sumax+=TAMANOPAGINAX*$ZONADECORTE

}

