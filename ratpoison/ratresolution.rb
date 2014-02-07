#!/usr/bin/ruby

RP="/usr/bin/ratpoison"
mandato = String.new
size="0 400 300 400 300 14680067 23,"
mandato = RP + " -c \"frestore " + size + "\""
puts mandato
system(mandato)
