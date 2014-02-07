#!/usr/bin/ruby

class Redneur
	def initialize(n)
		@tabla=Array.new
		n.times {
			pepe = Array.new
			n.times {
				pepe.push [0,0,0,0] #pesos #podria ser 8
			}
			@tabla.push pepe
		}
	end
	def consultar
		@tabla[1][0][3]
	end
end

pepe = Redneur.new 2
puts pepe.consultar
		#Matriz para identificadores (siguiendo orden natural)
		#Matriz de vectores para pesos y umbrales (cada pata tiene un peso y un umbral <- podria ser el mismo) (todos a 1) # no hay umbral, es mas sencillo
