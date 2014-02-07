#!/usr/bin/ruby
FILE="systats"
if not File.exist?(FILE)
	print "Creando archivo"
	archivo = File.new(FILE, File::CREAT, "a+")
else
	archivo = File.open(FILE,"a+")
end

contenedor,hashlin = Hash.new,Hash.new
fuente = File.open("/proc/interrupts")
contenedor["hora"] = Time.now.to_i
fuente.each_line { |li| 
	array = li.scan(/\w+/) # separar en palabras
	array.delete("XT")
	array.delete("PIC")
	array.delete("AudioPCI")
	array.delete_at(0)
	array.compact!
	if array.length == 2
		if not contenedor.has_key?(array[1])
			contenedor[array[1]] = array[0]
		end
	end
}
#archivo.seek(-135, IO::SEEK_END)
posi=0
linea=""
tama=""
archivo.each{ |linea|
	tama=linea
}
arrlin = tama.scan(/\w+/) # separar en palabras
hashlin["hora"] = arrlin[0]
hashlin["timer"] = arrlin[1]
hashlin["i8042"] = arrlin[2]


archivo.write(contenedor["hora"])
archivo.write("\t")
archivo.write(contenedor["timer"])
archivo.write("\t")
archivo.write(contenedor["i8042"])

if contenedor["timer"].to_i > hashlin ["timer"].to_i
tiempo = contenedor["hora"].to_i - hashlin["hora"].to_i
pulsa = contenedor["i8042"].to_i - hashlin["i8042"].to_i
archivo.write("\t")
archivo.write(tiempo)
archivo.write("\t")
archivo.write(pulsa)
archivo.write("\t")
archivo.write(pulsa.to_f / tiempo.to_f)
end
archivo.write("\n")
archivo.close
fuente.close
