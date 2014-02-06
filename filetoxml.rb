#!/usr/bin/ruby
require "rexml/document"
include REXML

def inspeccionar(directorio,raiz,desplazamiento)
	n = desplazamiento
	listado=Dir.entries(directorio)
	listado.delete(".")
	listado.delete("..")
	listado.each { |i|
		ficheroactual = File.new(directorio + i)
		el1 = Element.new "node"
		datos = el1.add_element "data"
		el2 = datos.add_element "nombre"
		el2.text = i.to_s
		el3 = datos.add_element "tipo"
		el3.text = File.ftype(directorio + i)
		el4 = datos.add_element "fecha_acceso"
		el4.text = File.atime(directorio + i)
		el5 = datos.add_element "fecha_modificacion"
		el5.text = File.mtime(directorio + i)
		el6 = datos.add_element "size"
		el6.text = File.size(directorio + i)
		if File.ftype(directorio + i) == "directory" 
			inspeccionar(directorio + i + "/",el1,1)
		end
		raiz.root[n,0] = el1
		n = n+1
	}
end
#	FILE="/home/bourbaki/#{Time.now.day.to_s + "_" + Time.now.month.to_s + "_" + Time.now.year.to_s }.xml"
#	if not File.exist?(FILE)
#		print "Creando archivo\n"
#		archivo = File.new(FILE, "w+")
#	else
#		archivo = File.open(FILE,"w+")
#	end
documento = Document.new('<e>')
#	el1 = Element.new "nodo" 
#	documento.root[0,0] = el1
inspeccionar("/home/ftp/incoming/" , documento.root, 0)
documento.write( $stdout, 0 )
print "\n"
