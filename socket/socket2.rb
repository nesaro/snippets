#!/usr/bin/ruby
require 'socket'
client = TCPSocket.open('localhost', '1200')
client.send("Ooofofofof", 0)    # 0 means standard packet
puts client.readlines
client.close

