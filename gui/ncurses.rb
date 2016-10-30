#!/usr/bin/ruby
require 'ncurses'
include Ncurses
begin
fil,col=Array.new,Array.new
Ncurses.initscr
Ncurses.cbreak
Ncurses.noecho
Ncurses.start_color
Ncurses.init_pair(1, COLOR_BLUE, COLOR_RED)
Ncurses.init_pair(2, COLOR_WHITE, COLOR_BLUE)
Ncurses.stdscr.getmaxyx(fil,col)
Ncurses.stdscr.bkgd(Ncurses.COLOR_PAIR(2))
Ncurses.mvprintw(fil[0]+10/2,col[0]/2,"holaa")
Ncurses.refresh
ventana = WINDOW.new(20,30,0,0)
ventana.box(0,0)
venta = WINDOW.new(20,30,0,40)
venta.box(0,0)
venta.wrefresh
ventana.attron(Ncurses.COLOR_PAIR(1))
ventana.mvprintw(1,1,"Inserte una letra")
ventana.attroff(Ncurses.COLOR_PAIR(1))
ventana.wrefresh
caracter = ventana.getch
ventana.mvprintw(2,2,caracter.to_s)
ventana.wrefresh
ventana.attron(Ncurses.COLOR_PAIR(1))
ventana.mvprintw(3,1,"Ahora una palabra")
ventana.attroff(Ncurses.COLOR_PAIR(1))
cadena=""
ventana.getstr(cadena)
ventana.mvprintw(4,1,cadena)
ventana.wrefresh
ventana.attron(Ncurses.COLOR_PAIR(1))
ventana.mvprintw(5,1,"Presiona intro")
ventana.attroff(Ncurses.COLOR_PAIR(1))
ventana.wrefresh
#ventana.getstr(cadena)
Ncurses.keypad(Ncurses.stdscr, true)
char=stdscr.getch
if char == KEY_ENTER or char == ?\n or char == ?\r
	venta.mvprintw(1,1,"Cambio de ventana")
	venta.wrefresh
end
if char == ?\t 
	venta.mvprintw(1,1,"tabulador1!!")
	venta.wrefresh
end
ventana.delwin
venta.delwin
#Ncurses.refresh
ensure
Ncurses.endwin
end
