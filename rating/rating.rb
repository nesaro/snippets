#!/usr/bin/ruby
require 'tk'
#

Acciones = [
	{
		:nombre => "Velamayor", :imagen => "velamayor.gif", 		# grid botones
		:variable => 'velamayor', :explicacion => 'velamayor.gif'	# diálogo meter cosas
	},

	{ :nombre => "Velagenova", :imagen => "velagenova.gif" },
	{ :nombre => "Velabalon", :imagen => "velabalon.gif" },
	{ 
		:nombre => "Casco", :imagen => "casco.gif",
		:variables => [
			'longitud_casco', 
			['material', 'mat1', 'mat2'],
		]
	},
	{ 
		:nombre => "Datos", :imagen => "datos.gif",
		:variables => [], 
    },
	{ :nombre => "Jarcia", :imagen => "jarcia.gif" },
	{ :nombre => "Helice", :imagen => "helice.gif" },
	{ :nombre => "Lastres", :imagen => "lastres.gif" },
	{ :nombre => "Aparejo", :imagen => "aparejo.gif" },
	{ 
		:nombre => "Equipamiento", :imagen => "equipamiento.gif",
		:variables => ['']
	}

]

class Datos
	def initialize

	end

end

root = TkRoot.new() { title "Hello, world!" }
br = Acciones.map {	|c|
	TkButton.new(root, "text"=>c[:nombre]) { 
		image  TkPhotoImage.new('file'=>c[:imagen], 'height'=>150, 'width' => 40) 
		command proc {
			toplevelwindow = TkToplevel.new(root) {
				title c[:nombre]
				geometry("50x50+100+100")
				configure('bg'=>"black")
				background("grey")
			}

			#Cada variable del array (cada boton)
			c[:variables] and c[:variables].each { |var|
				if var.kind_of?(String) then
					cuestion1 = TkLabel.new(toplevelwindow){text var}
					respuesta1 = TkEntry.new(toplevelwindow).pack("side"=>"top", "fill"=>"x")
					respuesta1.insert(0, "Entry on the top")
					TkGrid.grid(cuestion1,respuesta1)
				else
					boton = TkMenubutton.new(toplevelwindow, 'text'=>var[0], 'underline'=>0){|btn|
						pack('side'=>'left') 
						menu TkMenu.new(btn) {
							tearoff false
							var[1,100].each { |v|
								add 'command', 'label' => v, 'underline' => 0, 'command' => proc {puts "pepe"}
							}
						}
					}
					TkGrid.grid(boton)
				end
			}
		}
	}
}
TkGrid.grid(*(br[0,5] + [{ "sticky"=>"ew"}])) #expande el array y se convierte en lo de abajo
#TkGrid.grid(br[0], br[1], br[2],br[3],br[4], "sticky"=>"ew")
TkGrid.grid(br[5],br[6],br[7],br[8],br[9],"sticky"=>"ew" )

label = TkLabel.new() { text "to the rightsdiasdsaasoiads\n\n..." }
total= TkLabel.new() { text "to the rightsdiasdsaasoiads\n\n..." }

TkGrid.grid(label,total,"columnspan"=>2)
Tk.mainloop()
