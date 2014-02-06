#!/usr/bin/ruby
class Alog
	def initialize(nombre)
		if File.exist? nombre then
			@archivo=File.open(nombre,"a+")
		else
			@archivo=File.new(nombre,"a+")
		end	
	end
	def append(cadena)
		@archivo.puts cadena
	end
	def cerrar
		@archivo.close
	end
end
	
