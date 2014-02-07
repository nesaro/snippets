#!/usr/bin/ruby

module RP
	class Window # para cada ventana, no descarto obtener informacion extra
		def initialize(string)
			cosas=Array.new
			string.delete! ","
			string.each(' '){ |x|
				cosas.push(x)
			}
			@number=cosas[0] # numero de la ventana
			@xpos=cosas[1]
			@ypos=cosas[2]
			@xsize=cosas[3]
			@ysize=cosas[4]
			@wid=cosas[5]
			@acceso=cosas[6] # Parece que es un numero basado en el acceso , unico, sumado 110 al winfmt %l
		end
		def to_s
			@number.to_s+@xpos.to_s+@ypos.to_s+@xsize.to_s+@ysize.to_s+@wid.to_s+@acceso.to_s
		end
		def wid
			@wid.to_i
		end
		def number
			@number.to_i
		end
		def xsize
			@xsize.to_i
		end
		def ysize
			@ysize.to_i
		end
		def xpos
			@xpos.to_i
		end
		def ypos
			@ypos.to_i
		end
	end
	class Screen # equivalente a la cadena de fdump
		def initialize(string)
			@windows=Array.new
			string.chop!
			string.each(',') { |line|
				@windows.push(Window.new(line))
				}
		end
		def frestore
			cadena = String.new
			@windows.each { |j|
				cadena = cadena+j.to_s+","
			}
			mandato="ratpoison -c \"frestore "+cadena+'"'
			system(mandato)

		end
		def output
			cadena = String.new
			@windows.each { |j|
				cadena = cadena+j.to_s+","
			}
			puts cadena
		end
		def xsize
			minx=0
			miny=0
			maxx=0
			maxy=0
			@windows.each { |window|
				if window.xpos < minx
					minx=window.xpos
				end
				if window.xsize+window.xpos > maxx
					maxx=window.xsize+window.xpos
				end
			}
			maxx-minx #busca los puntos extremos en el eje x
		end
		def eachw
			@windows.each{ |x|
				yield x
			}
		end
		def ordenar
			def comp(x,y)
				if x.ypos < y.ypos then
					return -1
				end
				if x.ypos > y.ypos then
					return 1
				end
				if x.xpos < y.xpos then
					return -1
				end
				if x.xpos > y.xpos then
					return 1
				end
				return 0
			end
			@windows.sort! { |x,y| comp(x,y) }
			y=0
			@windows.each { |x|
				mandato="ratpoison -c \"number "+y.to_s+" "+buscarwid(x.wid).to_s+"\""
				puts mandato
				y+=1
			}

		end
		def buscarwid (wid) #devuelve el numero de ventana
			n=0
			@windows.each {|x|
				if x.wid== wid.to_i then
					n=x.number#el numero debe ser obtenido a traves de window NEXT	#necesario crear un programa que busque tambien en el nombre de la ventana (M-k M-l mejorada) y despues le cambie el nombre
					#deberia tener algo parecido a los ws, solo que deberia tener 5 posiciones para fdumps y 5posiciones para juegos de ventanas ( y los juegos de ventanas mezclables)
					break
				end
			}
			n
		end
	end
end

class Mvarg
	def initialize(g,x,y,w,h)
		@gravity=g.to_i
		@xpos=x.to_i
		@ypos=y.to_i
		@we=w.to_i
		@he=h.to_i
	end
	def split!
		@he=@he/2
	end
	def to_s
		return @gravity.to_s+","+@xpos.to_s+","+@ypos.to_s+","+@we.to_s+","+@he.to_s
	end
end
	
