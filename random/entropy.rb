#!/usr/bin/ruby
SIZE=2**20
TROZO=16
def log2n(numero)
	numero= Math.log(numero)/0.69314718056
end
contenedor=Array.new
contador=Array.new
print "introduce cadena\n"
cadena=gets
1.upto(SIZE/TROZO){ |i|
	contenedor << "0b"+cadena.slice((TROZO*(i-1))..((TROZO*i)-1)) #0b para considerar binario	
}
0.upto(2**TROZO){ |i|
	contador[i]=0
}

contenedor.each{ |i|
	contador[Integer(i)]=contador[Integer(i)] + 1
}
resultado=0.0
0.upto(contador.length-2){ |i|
	entero= "%b" % i
	if !(contador[i] == 0)
		prob=0.0
		prob=(contador[i].to_f/(SIZE/TROZO).to_f)
		resultado=resultado + -1.to_f * (prob.to_f * log2n(prob.to_f))
		print "valor :",i," ",prob, "\n", "resultado actual: ",resultado, "\n"
	end
	#	print "coincidencias de ",entero,": ", contador[i], "\n"
}
print "resultado: ",resultado/TROZO, "\n"
	
