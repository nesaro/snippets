#!/usr/bin/ruby

#pagina tipo: http://www.madrid.org/staticFiles/PDFSBoletin/20050103/iii.pdf

PDFATEXTO="/home/bourbaki/src/xpdf-3.01/xpdf/pdftotext"
DIRECTORIO="/home/bourbaki/matriculas/"
DESCARGAR="wget -P /tmp/"
PREFIJOWEB="http://www.madrid.org/staticFiles/PDFSBoletin/"

#calculafecha devuelve la fecha de la ultima actualizacion
def calculafecha
	if File.exist?(DIRECTORIO+"fecha")    #la fecha de modificación del fichero fecha controla el ultimo acceso
		mifecha=File.mtime(DIRECTORIO+"fecha")
	else
		mifecha=Time.now-(60*60*24*30)    #Si el fichero no existe, tomo los archivos del ultimo mes
	end
		`touch #{DIRECTORIO}"fecha"`      #Actualizo la fecha de modificacion del fichero a hoy
		return mifecha
end

#actualizardb: Se descarga todos los pdf pendientes de ser descargados

def actualizarbd
	listado=Dir.entries(DIRECTORIO)
	listado.delete "."
	listado.delete ".."
	mifecha=calculafecha   #mifecha controla el dia con el que trabajo
	while ( (mifecha.to_i - Time.now.to_i) > (60*60*24) ) do     #Mientras no este actualizado hasta el ultimo dia
		nombrefichero=mifecha.strftime("%Y%m%d")
		if not File.exist?(DIRECTORIO+nombrefichero.to_s) then
			comando ="#{DESCARGAR} #{PREFIJOWEB+nombrefichero.to_s}/iii.pdf"      
			if `#{comando}` == 0 then                            #Si la descarga es un éxito
				system("#{PDFATEXTO} /tmp/iii.pdf #{DIRECTORIO+nombrefichero.to_s}")    # Paso el fichero a texto
				File.delete("/tmp/iii.pdf")                                             # Borro el original
			end
		end
		mifecha = mifecha + (60 * 60 * 24)          # mifecha vale un dia mas
	end
end



begin
	actualizarbd    #actualizo la lista de ficheros
	puts "Inserte la matrucula a buscar, en mayusculas y sin espacio ni guiones (ej: 1234CCC ó M1234FF):"
	matricula = STDIN.gets # cogemos la matricula del teclado
	listado=Dir.entries(DIRECTORIO)
	listado.delete "."
	listado.delete ".."
	listado.each{ |x|   #para cada archivo de la carpeta
		orden="grep -i #{matricula.chop} #{DIRECTORIO+x} | wc -l"
		if `#{orden}`.to_i > 0 then    #buscamos si la matricula existe en el fichero
			puts "la cadena de texto aparece el dia #{x}"
		end
	}
end

