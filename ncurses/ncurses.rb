#!/usr/bin/ruby
#NO HAY MENU EN RUBY DE MOMENTO

require 'ncurses'
begin
	items=Array.new
	items=["2","3","4","5"]
	Ncurses.initscr
	screen = Ncurses.stdscr.subwin(23, 79, 0, 0)
	screen.box(0,0)
	screen.hline( Ncurses::ACS_HLINE, 77)
	screen.refresh
	#	mi_item=Ncurses.new_item(items[0],items[0])
	#mi_menu=Ncurses.new_menu(mi_item)
	#mi_menu.menu_post
	Ncurses.stdscr.wrefresh
ensure
	Ncurses.endwin
end
