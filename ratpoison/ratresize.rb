#!/usr/bin/ruby

require 'rp.rb'
pepe = RP::Screen.new(`ratpoison -c fdump`)
if (pepe.xsize == 1280)
	RATP="/home/bourbaki/bin/ratpoison"
	RATIO= (1280-61)/1280.0
	actual=`#{RATP} -c fdump`
	#ventanas=`#{RATP} -c windows`
	ventanas = Array.new
	actual.each(',') { |linea| 
		ventanas.push(Array.new)
		linea.each(' ') { |numero|
			ventanas[-1].push(numero)
		}
	}

	ventanas.each { |x|
		x[1] = (x[1].to_f*RATIO).to_i.to_s+" "
		x[3] = (x[3].to_f*RATIO).to_i.to_s+" "
	}	
	ventanas.delete_at(-1)
	mandato="ratpoison -c \"frestore "+ventanas.to_s+'"'
	system(mandato)
end
