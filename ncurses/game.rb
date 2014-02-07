#!/usr/bin/ruby
require 'ncurses'
begin
Ncurses.initscr
i=0
j=0
Ncurses.cbreak
Ncurses.noecho
Ncurses.keypad(Ncurses.stdscr, true)
while true
	char=Ncurses.stdscr.getch
	case char
	when Ncurses::KEY_LEFT
		Ncurses.stdscr.mvwaddstr(j,i," ")
		i=i-1
		Ncurses.stdscr.mvwaddstr(j,i,"0")
		Ncurses.stdscr.wrefresh
	when Ncurses::KEY_RIGHT
		Ncurses.stdscr.mvwaddstr(j,i," ")
		i=i+1
		Ncurses.stdscr.mvwaddstr(j,i,"0")
		Ncurses.stdscr.wrefresh
	when Ncurses::KEY_DOWN
		Ncurses.stdscr.mvwaddstr(j,i," ")
		j=j+1
		Ncurses.stdscr.mvwaddstr(j,i,"0")
		Ncurses.stdscr.wrefresh
	when Ncurses::KEY_UP
		Ncurses.stdscr.mvwaddstr(j,i," ")
		j=j-1
		Ncurses.stdscr.mvwaddstr(j,i,"0")
		Ncurses.stdscr.wrefresh
	else print "feo"
	end
end
ensure
Ncurses.endwin
end
