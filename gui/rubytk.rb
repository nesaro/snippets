#!/usr/bin/ruby
require 'tk'
$i=3.0
$j=0.0
$generacion=1.0
$canvas = TkCanvas.new
class Nodo 
	def initialize(hijo1,hijo2)
		@hijo1=hijo1
		@hijo2=hijo2
	end
	def procrear
		if rand(2)==0
			if @hijo1==nil
				@hijo1=Nodo.new(nil,nil)
				TkcRectangle.new($canvas, "#{$i}c", "#{$j}c" , "#{$i+0.1}c", "#{$j+0.1}c",
				'outline' => 'black', 'fill' => 'blue')
				$canvas.pack
				$i=1.0
				$j=0.0
				$generacion=1.0
			else
				@hijo1.procrear
				$generacion=$generacion+1.0
				$j=$j+0.4
				$i=$i+($i/$generacion)
			end
			
		else
			if @hijo2==nil
				@hijo2=Nodo.new(nil,nil)
				TkcRectangle.new($canvas, "#{$i}c", "#{$j}c" , "#{$i+0.1}c", "#{$j+0.1}c",
				'outline' => 'black', 'fill' => 'blue')
				$canvas.pack
				$i=1.0
				$j=0.0
				$generacion=1.0
			else
				@hijo2.procrear
				$generacion=$generacion+1.0
				$j=$j+0.4
				$i=$i-($i/$generacion)
			end

		end 
	end		
end
root = TkRoot.new() { title "Árbol de prueba" }
abuelo = Nodo.new(nil,nil)
button = TkButton.new(root) {
	text "Hello..."
	command proc {
		#	p "...world!"
		#		TkcRectangle.new(canvas, "#{$i}c", "#{$i}c" , "#{$i+1}c", "#{$i+1}c",
		#	'outline' => 'black', 'fill' => 'blue')
		#canvas.pack
		abuelo.procrear
	}
}
button.pack()
Tk.mainloop()
