#!/usr/bin/ruby
require 'rp'

pepe = RP::Screen.new(`ratpoison -c fdump`)
puts pepe.xsize
