#!/usr/bin/env ruby
N = 40     		#ancho de tablero
Pasos = 20  	# numero de generaciones
tos = Array.new
tng = Array.new

0.upto(N) { |row| # Puesta a 0
	tos[row] = Array.new(N+1)
	tng[row] = Array.new(N+1)
	0.upto(N) { |columna|
		tos[row][columna] = 0
		tng[row][columna] = 0
	}
}

2.upto(N-2) { |column|  # Configuracion inicial
tos[N/2][column] = 1
}

0.upto(N) { |row|
	print tos[row] #, "\n"
}
puts


#
#	Parte principal, viendo generaciones
#


1.upto(Pasos) { |generation|  #número de generaciones
        1.upto(N - 1) { |row|
                1.upto(N - 1) { |column|
                        neighbors = 0
                        -1.upto(1)  { |row_offset|
                                -1.upto(1) { |column_offset|
                                        unless row_offset == 0 and column_offset == 0
                                                neighbors += tos[row+row_offset][column+column_offset]
                                        end
                                }
                        }
                        if tos[row][column] == 1 
                                tng[row][column] = neighbors % 2
                        else 
                                tng[row][column] = (neighbors + 1) % 2
                        end
                }
        }

#sleep 1
#system("clear")

#	0.upto(N) { |row|
	#			0.upto(N) { |column| tos[row][column] = tng[row][column] }
	#		print tos[row], "\n"
	#	}
	#	puts
	0.upto(N) { |row|
		0.upto(N) { |column|
			tos[row][column] = tng[row][column]
				print(tos[row][column] == 0 ? ' ' : 'X')
			#	print tos[row][column]
		}
				print "\n"
	} 
	puts
	sleep 0.3
	system("clear")


}
#done
