#!/usr/bin/ruby

require "ncurses"


begin
Ncurses.initscr
Ncurses.mvaddstr(0, 0, "Tarea1")
#Ncurses.printw("ofgoffo")
Ncurses.refresh
sleep(2.5)
ensure
Ncurses.endwin
end

