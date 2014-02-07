#!/usr/bin/ruby

require '/home/bourbaki/inform/code/rp.rb'
pepe = RP::Screen.new(`ratpoison -c fdump`)
pepe.frestore
pepe.ordenar
pepe.frestore


