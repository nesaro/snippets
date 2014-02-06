#!/usr/bin/ruby

require 'net/http'
Net::HTTP.version_1_2   # 
Net::HTTP.start('buscon.rae.es', 80) {|http|
	response = http.get('/draeI/SrvltGUIBusUsual?TIPO_HTML=2&LEMA='+ARGV[0])
puts response.body
}

