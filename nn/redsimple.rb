#!/usr/bin/ruby

class Nodo 
	def initialize
		@pesos = [0,1,2,3]
		@enlaces = [0,0,0,0]
	end
	def pesos
		@pesos
	end
	def enlaces=(enlace)
		@enlaces=enlace
	end
	
end

aiz= Nodo.new
ade= Nodo.new
diz= Nodo.new
dde= Nodo.new

#iz arr de ab
aiz.enlaces = [0,0,ade,diz]
ade.enlaces = [aiz,0,0,dde]
diz.enlaces = [0,aiz,dde,0]
dde.enlaces = [diz,0,ade,0]

