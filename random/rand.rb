#!/usr/bin/ruby
1.upto((2**20)/6){ |i|
	pepe = rand(2**16).to_i
	printf("%b",pepe)
}
