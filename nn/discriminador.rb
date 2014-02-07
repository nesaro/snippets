#!/usr/bin/ruby

	class  Selector
		def initialize(umbral,*pesos)
			@umbral=umbral
			@pesos=pesos
			@entradas=@pesos.length
		end
		def usar(*entradas)
			suma=0
			i=0
			entradas.each{ |x|
				suma += x*@pesos[i]
				i += 1
			}
			if suma > @umbral 
				return 1
			else
				return 0
			end
		end
		def pesos
			@pesos
		end
		def nentradas
			@entradas
		end
		def reasignar(*pesos)
			@pesos=pesos
		end
		def umbral
			@umbral
		end
		def umbral(nuevo)
			@umbral=nuevo
		end
		def aprender(salidadeseada,*entrada)
			while usar(*entrada) != salidadeseada
				dif=salidadeseada-usar(*entrada)
				@umbral-=dif
				i=0
				entrada.each{ |x|
					pesos[i]+= dif*x
					i+=1
				}
			end
		end
	end
begin
	pesos = [1,2]
	entrada= [1,0]
	mi = Selector.new(1,*pesos)
		mi.aprender(0,*entrada)
		#mi.aprender(salidadeseada,entradas)
		mi.aprender(0,1,2)
		mi.aprender(1,3,2)
		mi.aprender(1,1,0)
		puts mi.usar(0,0)
		puts mi.usar(1,1)
		puts mi.usar(1,2)
		puts mi.usar(1,0)
		puts mi.usar(3,3)
		puts mi.usar(-1,0)
end
