#!/usr/bin/ruby
UMBRAL=80
MUMBRAL=3
	SALIDA= Array.new
def cuantizar(dir)
	dd = Dir.entries(dir) 
	if dd.size > UMBRAL or dd.size < MUMBRAL
		SALIDA.push(dir)
	end
	dd.delete(".")
	dd.delete("..")
	dd.each do |archivo|
		if File.ftype(dir+archivo) == "link"
			miarchivo = File.readlink(dir+archivo)
		else
			miarchivo = dir+archivo
		end
		if	File.ftype(miarchivo) == "directory"
			cuantizar dir+archivo+"/"
		end
	end
end

begin
	directorio =ARGV[0]
	cuantizar directorio
	if  SALIDA.size > 0
		puts "Programa de detección de directorios masivos"
		print "Los directorios que contienen más de ",UMBRAL," o menos de ",MUMBRAL, " son:\n\n"
		SALIDA.each{|x| puts x}
		print "\n"
	end
end

