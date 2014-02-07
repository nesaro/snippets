#!/usr/bin/ruby
require "rexml/document"
require "rexml/encoding"
require "rexml/output"

def search(doc,field,name)
	doc.root.elements.each{ |i| 
		if i.elements[field] then
			i.elements[field].each { |j|
				if j.to_s.strip == name.capitalize.chop then
					puts i.to_s.strip
				end
			}
		end 
	}
end

if (ARGV.size == 0)
	puts "Uso: xml.rb ARCHIVO"
	exit
end
file = File.new(ARGV[0])
doc = REXML::Document.new file
print "Inserte el nombre a buscar:"
entrada = STDIN.gets
search(doc,"nombre",entrada)
#
