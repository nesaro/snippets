#!/usr/bin/ruby
require 'net/http'
require 'uri'
DNI=12345678
CLAVE=1234

Net::HTTP.post_form(URI.parse('http://www.campusvirtual.ulpgc.es/index.php'),
                    {'intento_login' => '1', 
                     'nombre_usuario_form' => DNI, 
                     'password_form' => CLAVE , 
                     'x'=>'0', 
                     'y'=>'0'}).body.to_s.sub(/http:\/\/telepresencial.ulpgc.es\/moodle2006\/login\/index_ulpgc.php\?id_sess=\w*\.\w*/){ |s| cadena=s}

	
		
