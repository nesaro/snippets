#!/usr/bin/env python
import sys
import os
import curses

# La idea es q haya otro tipo de visores,como arbol, y se pueda coger con una barra
# las listas deberian ser otra abstraccion


#LA representacion y el contenido es independiente
class Contenedor:
	pass


class Ventana:
	def __init__(self,ancho,alto):
		self.width=0
		self.height=0
		self.xpos=0
		self.ypos=0
		self.window=curses.newwin(ancho,alto)
	def setsize(self,x,y):
		self.window.resize(x,y)
	def setposition(self,x,y):
		self.xpos=x
		self.ypos=y
		self.window=curses.newwin(self.width,self.height,x,y)
	def refresh(self):
		self.window.refresh()

class Lista(list, Contenedor, Ventana):
	def __init__(self):
		list.__init__(self)
		Ventana.__init__(self,0,0)

	def refresh(self):
		self.window.box()
		self.window.refresh


class VentanaGeneral(Ventana):
	def __init__(self,elementoinicial,ancho,alto):
		Ventana.__init__(self,ancho,alto)
		self.elemento=elementoinicial

	def refresh(self):
		Ventana.refresh(self)
		self.elemento.setsize(30,30)
		self.elemento.setposition(self.xpos+1,self.ypos+1)
		self.elemento.refresh()
		self.window.box(20,20)
		self.window.addstr(1,1,"pepe",curses.A_BLINK)



class VentanaElemento(Ventana):
	def __init__(self,elementoinicial,ancho,alto):
		Ventana.__init__(self,ancho,alto)
		self.elemento=elementoinicial

	def refresh(self):
		Ventana.refresh(self)
		self.window.box(20,20)
		self.window.addstr(1,1,str(self.elemento),curses.A_BLINK)
		self.window.addstr(2,1,"Longitud:"+str(len(self.elemento)),curses.A_BLINK)


class Planificador:
	"""Esta clase introduce los nuevos elementos según criterios"""
	def __init__(self,mainwindow):
		self.mainwindow=mainwindow
		elementoraiz=Lista()
		self.visorgeneral=VentanaGeneral(elementoraiz,mainwindow.getmaxyx()[0],(mainwindow.getmaxyx()[1]/2))
		self.visorelemento=VentanaElemento(elementoraiz,mainwindow.getmaxyx()[0],mainwindow.getmaxyx()[1]/2)
		self.visorelemento.setposition(0,(mainwindow.getmaxyx()[1]/2))


	def begin(self):
		key = self.mainwindow.getch()
		while 1:
			if key==ord('q'):
				break
			else:
				stdscr.refresh()
				self.visorgeneral.refresh()
				self.visorelemento.refresh()
				key = stdscr.getch()



if __name__ == "__main__":
	stdscr = curses.initscr()
	curses.noecho()
	curses.cbreak()
	stdscr.keypad(1)
	principal = Planificador(stdscr)
	try:
		principal.begin()
		curses.nocbreak()
		stdscr.keypad(0)
		curses.echo()
	finally:
		curses.endwin()
