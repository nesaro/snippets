#!/usr/bin/ruby


#Interfaz de las ventanas
module IRP
	EX="/usr/bin/ratpoison"
	def vlista
		#ids de las ventanas
		cadena=`#{EX} -c "windows %i"`
		cadena.to_a
	end
end

include IRP

class Contenedor
	def initialize(archivo)
		if not File.exist?(archivo)
			print "Creando archivo"
#			file = File.new(archivo, File::CREAT, "a+")
		else
			file = File.open(archivo)
		end	
	end
	def actualizar
		#actualizar el contenido con el ratpoison
		#obtener el listado de ventanas (por id) en un array
		listado=IRP::vlista
		puts listado.to_yaml
	end
end
