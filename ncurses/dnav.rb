#!/usr/bin/env ruby
require "ncurses"
include Ncurses

class Entorno
	def initialize
		@fil,@col=Array.new,Array.new
	end
	def scrsize
		Ncurses.stdscr.getmaxyx(@fil,@col)
	end
	def alto
		@fil[0]
	end
	def ancho
		@col[0]
	end
end


begin
	ent=Entorno.new
	tama=Array.new
	total=0
	desp=1
	DIR=ARGV[0]
	listado=Dir.entries(DIR)
	listado.delete("..")
	listado.delete(".")
	listado.each { |i|
		tamano=`du -s #{DIR+i} | awk {'print $1'}`
		tama.push(tamano)
		total+=tamano.to_i
	}
	Ncurses.initscr
	Ncurses.start_color
	ent.scrsize
	pepe=WINDOW.new(ent.alto,ent.ancho,0,0)
	pepe.box(0,0)
	Ncurses.init_pair(1, COLOR_BLUE, COLOR_WHITE)
	Ncurses.init_pair(2, COLOR_YELLOW, COLOR_WHITE)
	listado.delete(".")
	0.upto(listado.size-1){|i|
		ristra="."
		if (ent.ancho-1)*(tama[i].to_f/total) > listado[i].size then
			ristra=listado[i]
		end
		if i%2==0 then
			pepe.attron(Ncurses.COLOR_PAIR(1))
			pepe.mvaddstr(1,desp,ristra)
			pepe.attroff(Ncurses.COLOR_PAIR(1))
		else
			pepe.attron(Ncurses.COLOR_PAIR(2))
			pepe.mvaddstr(1,desp,ristra)
			pepe.attroff(Ncurses.COLOR_PAIR(2))

		end
		desp+=(ent.ancho-2)*(tama[i].to_f/total)
		pepe.refresh
	}
	#	Ncurses.refresh
	sleep(2.5)
ensure
	Ncurses.endwin
end
