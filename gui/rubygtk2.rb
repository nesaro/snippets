#!/usr/bin/ruby

require 'gtk2'

Gtk.init
button = Gtk::Button.new("Hello World")
window = Gtk::Window.new
window.signal_connect("destroy") { Gtk.main_quit }
button.signal_connect("clicked") { Gtk.main_quit }
window.add(button)
window.show_all
Gtk.main
