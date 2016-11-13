#!/usr/bin/ruby

require 'ncurses'
#require "rexml/document"
#require "rexml/encoding"
#require "rexml/output"
include Ncurses

class Ventana
	def initialize(x,y,ancho,alto)
		@fila=1
		@x=x
		@y=y
		@ancho=ancho
		@alto=alto
		@vent=WINDOW.new(ancho,alto,x,y)
		@vent.box(0,0)
		@contenido = Array.new
		Ncurses.init_pair(1, COLOR_BLUE, COLOR_WHITE)
	end
	def movres(x,y,ancho,alto)
		if (@x!=x or @y!=y or @ancho!=ancho or @alto!=alto)
			@vent.delwin
			@vent=WINDOW.new(ancho,alto,x,y)
		end
	end
	def insertar(ristra)
		@contenido.push ristra
		if @contenido.size == @fila
			@vent.attron(Ncurses.COLOR_PAIR(1))
		end	
		@vent.mvprintw @contenido.size,1,@contenido[@contenido.size-1]
		if @contenido.size == @fila
			@vent.attroff(Ncurses.COLOR_PAIR(1))
		end

	end
	def contenido
		@contenido
	end
	def escucha
		@vent.getch
	end
	def dibujar
		@vent.refresh
	end	
end

class Entorno
	def initialize
		@fil,@col=Array.new,Array.new
		scrsize
		@currentwin=0
		@numventanas=1
		@ventanas=Array.new
		@ventanas.push Ventana.new(0,0,@fil[0],@col[0])
	end
	def vsiguiente
		@currentwin=((@currentwin+1) % @numventanas)
	end
	def refresh
		@ventanas.each { |x| x.dibujar }
	end
	def vactual
		@ventanas[@currentwin]
	end
	def escucha
		char=vactual.escucha
		if char == KEY_ENTER or char == ?\n or char == ?\r
			vactual.insertar "Cambio de ventana"
			vactual.dibujar
		else
			vactual.insertar "viste boludo!!"
			vactual.dibujar
		end

	end
	private
	def scrsize
		Ncurses.stdscr.getmaxyx(@fil,@col)
	end
end

#def search(doc,field,name)
#	out=""
#	doc.root.elements.each{ |i| 
	#		if i.elements[field] then
	#			i.elements[field].each { |j|
		#				if j.to_s.strip == name.capitalize.chop then
		#					out=i.to_s.strip
		#				end
		#			}
		#		end 
		#	}
		#	out
		#end


		#if (ARGV.size == 0)
		#	puts "Uso: xml.rb ARCHIVO"
		#	exit
		#end
		begin
			Ncurses.initscr
			Ncurses.start_color
			Ncurses.cbreak
			Ncurses.noecho
			Ncurses.keypad(Ncurses.stdscr, true)
			#   file = File.new(ARGV[0])
			#	doc = REXML::Document.new file
			pepon=Entorno.new
			pepon.vactual.insertar("malvado!")
			pepon.vactual.insertar("malagente!")
			pepon.refresh
			sleep 1
			pepon.escucha
			#search(doc,"nombre",entrada)
		ensure
			Ncurses.endwin
		end
