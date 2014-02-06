#!/usr/bin/ruby
#
##PPM random noise generator

begin
puts "P6","256 256","255"
(196608).times{ 
	print "%c" % rand(256)
}
end
