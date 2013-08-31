#!/usr/bin/ruby
n=3
while true
temp=n/2
while temp > 1 
	if (n % temp) == 0
		temp = 0
	else
		temp = temp - 1 
	end
end
if temp > 0 
	print n,"\n"
end
n=n+1
end
