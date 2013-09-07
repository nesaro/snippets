#!/usr/bin/ruby

class Tablero
	def initialize(n)
		@n=n
		@tabla=Array.new
		0.upto(n-1) { |fila| 
			@tabla[fila]=Array.new 
			0.upto(n-1) { |columna| @tabla[fila][columna]=0 }
		}
end
def mostrar 
	0.upto(@n-1) { |fila|
		0.upto(@n-1) { |columna|
				print @tabla[fila][columna]
		}
		print "\n"
	}
	print "\n"
end
def add(x,y,val)
	@tabla[x-1][y-1]=val
end
def resolver
	cambio=1
	while (cambio!=0) 
		cambio=0
		0.upto(@n-1) { |fila|
			0.upto(@n-1) { |columna|
				candidatos=[1,2,3,4,5,6,7,8,9]
				if @tabla[fila][columna]==0 then 
					#filtramos en filas y columnas

					0.upto(@n-1){ |filiter| candidatos.delete(@tabla[filiter][columna]) }
					0.upto(@n-1){ |coliter|  candidatos.delete(@tabla[fila][coliter]) }

					#filtramos en la matriz

					(3*(fila/3)).upto((3*(fila/3))+2) { |i|
						(3*(columna/3)).upto((3*(columna/3))+2) { |j|
							candidatos.delete(@tabla[i][j])
						}
					}

					if candidatos.size == 1 then 
						@tabla[fila][columna]=candidatos.first
						cambio=1
					end
				end
			}
		}
		#mostrar()
	end
end
end
begin
	cosa=Tablero.new(9)
	cosa.add(1,3,5)
	cosa.add(1,7,4)
	cosa.add(2,4,5)
	cosa.add(2,6,4)
	cosa.add(3,1,4)
	cosa.add(3,3,6)
	cosa.add(3,4,7)
	cosa.add(3,6,9)
	cosa.add(3,7,8)
	cosa.add(3,9,1)
	cosa.add(4,2,2)
	cosa.add(4,3,9)
	cosa.add(4,5,5)
	cosa.add(4,7,3)
	cosa.add(4,8,6)
	cosa.add(5,5,7)
	cosa.add(6,2,8)
	cosa.add(6,3,1)
	cosa.add(6,5,4)
	cosa.add(6,7,2)
	cosa.add(6,8,9)
	cosa.add(7,1,9)
	cosa.add(7,3,8)
	cosa.add(7,4,1)
	cosa.add(7,6,3)
	cosa.add(7,7,7)
	cosa.add(7,9,5)
	cosa.add(8,4,4)
	cosa.add(8,6,5)
	cosa.add(9,3,3)
	cosa.add(9,7,1)

	cosa.mostrar
	cosa.resolver
	cosa.mostrar
end

