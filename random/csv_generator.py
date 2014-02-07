#!/usr/bin/ruby

#random csv data generator 

contador=0
while (contador < 1024) do
	vendido=0
	hora = rand(10).to_i
	minutos = rand(60).to_i
	dia = rand(31).to_i
	dinero = 30.95*rand(1).to_i + 20.50*rand(2).to_i + 15.95*rand(4).to_i + 12*rand(4).to_i 
	venta = rand(3).to_i
	dow = (dia % 7)+1
	vendedor=rand(9)
	if vendedor<4 then seccion=0 
	else
		if vendedor<6 then seccion=1
		else
			if vendedor <8 then seccion=2
			else seccion=3
			end
		end
	end
	if venta>0 then
		vendido=1
	end
	if (dow!=7 and dow!=6) then 
		contador+=1
		print contador,"\t",1+dia,".1.1","\t",dow,"\t",hora+10,"\t",minutos,"\t",vendedor,"\t",vendido,"\t",dinero,"\t",seccion,"\n"
	end
end
