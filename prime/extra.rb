#!/usr/bin/ruby
class Contador
	def initialize(n)
		@max=n
		@val=0
	end
	def incrementar
		@val = @val + 1
		if @val == @max
			@val = 0
		end
		@val
	end
	def mostrar
		@val
	end
end
n=2
contadores = Array.new
contadores.push(Contador.new(2))
while true
	n=n+1
	temp = 1
	contadores.each { |x| 
		if x.incrementar == 0
			temp = 0
            break
		end
	}
	if temp == 1
	print n,"\n"
		contadores.push(Contador.new(n))
	end
end
