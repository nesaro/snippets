#!/usr/bin/ruby

require 'socket'
begin
	s = TCPsocket.new("127.0.0.1",5222)
	while true
		s.write("HELLO")
		print s.readline
		sleep 1
	end
ensure
	s.close
end
