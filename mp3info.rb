#!/usr/bin/ruby
require "mp3info"

mp3 = Mp3Info::open("/almacen/mp3/aguacongas.mp3")
puts mp3.bitrate, mp3.length
