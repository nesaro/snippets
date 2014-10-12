#!/usr/bin/env ruby

def prepend(prefix, array)
	array.collect { |item| prefix + item}
end

def grayCodes(bits)
	if bits == 1
		["0", "1"]
	else
		prepend("0", grayCodes(bits - 1)) +
		prepend("1", grayCodes(bits - 1).reverse)
	end
end

puts grayCodes(16)


