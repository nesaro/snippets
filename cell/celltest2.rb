#!/usr/bin/ruby


class Cel
	def initialize(nombre,val,e1,e2)
		@nombre=nombre
		@entrada1=e1
		@entrada2=e2
		@salida=0
		@val=val
	end
	def run
		@start=Time.now
		while Time.now - @start <10
			@salida =(@entrada1+@entrada2+@hermano.salida >= @val) ? 1 : 0
			print @nombre,@salida,"\n"
			sleep 0.3
		end
	end
	def salida
		@salida
	end
	def hermano=(hermano)
		@hermano=hermano
	end
end

a = Cel.new("A",3,1,1)
b = Cel.new("B",2,1,1)
a.hermano=b
b.hermano=a
threads = Array.new
threads << Thread.new {
	a.run
}
threads << Thread.new {
	b.run
}

threads.each { |t| t.join }
