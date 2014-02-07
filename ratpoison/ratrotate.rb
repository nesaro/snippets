#!/usr/bin/ruby

RP="/usr/bin/ratpoison"
actual=`#{RP} -c fdump`
wid = Array.new
ventanas = Array.new
actual.each(',') { |linea| 
	ventanas.push(Array.new)
	linea.each(' ') { |numero|
		ventanas[-1].push(numero)
	}
}

ventanas.each { |x|
  wid.push(x[5])
  puts x[5]
  }	
i=1
wid.delete_at(-1)
ventanas.delete_at(-1)
ventanas.each { |x|
	x[5]=wid[i%ventanas.size]
    i+=1
}
  mandato="ratpoison -c \"frestore "+ventanas.to_s+'"'
  system(mandato)
  puts mandato

