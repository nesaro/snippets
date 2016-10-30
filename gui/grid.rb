

require 'gtk2'

Gtk.init
win = Gtk::Window.new
draw = Gtk::DrawingArea.new

draw.signal_connect("expose-event") {
    |widget, event|

    #puts event.methods.sort.join(',')

    #puts widget.methods.grep(/window/).sort.join(',')
    #puts widget.methods.grep(/pango/).sort.join(',')
    #puts widget.window.methods.grep(/draw/).sort.join(',')

    drawable = widget.window
    layout = widget.create_pango_layout
    layout.text = "Esto es una prueba\notra línea"
    drawable.draw_layout Gdk::GC.new(drawable), 10, 10, layout

    st = Gtk::Style.new
    st.attach drawable
    st.paint_box(drawable, Gtk::STATE_NORMAL, Gtk::SHADOW_OUT, nil, widget, '', 20, 20, 100, 100)
}

draw.signal_connect("button-press") {
    |*a|
    puts a
}

win.add draw
win.show_all
Gtk.main






class Rejilla

    def initialize (widget, otros)
        @widget = widget
        @otros = otros

        @cambio_seleccion = nil
    end


    def registrar_cambio_seleccion (&evento)
        @cambio_seleccion = evento
    end

    def metodo_que_responde_a_un_click_en_el_widget

        if posicion in area_cabeceras
            hacer algo
        elsif posicion in numeros_linia
            hacer otra, cosa
        else
            # Es una celda
            x, y = calcular_celda_del_click
            unless @cambio_seleccion.nil? 
                @cambio_seleccion.call x,y
            end
        end
    end

    def _inicializar_widget
        # conectarse a las señales
        #   button-press
        #   button-release
        #   expose-event
        #
        # poner más parámetros
    end

end
