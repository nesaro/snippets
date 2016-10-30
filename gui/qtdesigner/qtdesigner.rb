#!/usr/bin/ruby
# Form implementation generated from reading ui file 'form1.ui'
#
# Created: mié oct 12 22:55:57 2005
#      by: The QtRuby User Interface Compiler (rbuic)
#
# WARNING! All changes made in this file will be lost!



require 'Qt'

class Form1 < Qt::Dialog

    attr_reader :pushButton1
    attr_reader :listBox1


    def initialize(*k)
        super(*k)

        if name.nil?
        	setName("Form1")
        end


        @pushButton1 = Qt::PushButton.new(self, "pushButton1")
        @pushButton1.setGeometry( Qt::Rect.new(130, 30, 101, 61) )

        @listBox1 = Qt::ListBox.new(self, "listBox1")
        @listBox1.setGeometry( Qt::Rect.new(241, 40, 220, 360) )
        languageChange()
        resize( Qt::Size.new(791, 647).expandedTo(minimumSizeHint()) )
        clearWState( WState_Polished )

        Qt::Object.connect(@pushButton1, SIGNAL("clicked()"), self, SLOT("close()") )
    end

    #
    #  Sets the strings of the subwidgets using the current
    #  language.
    #
    def languageChange()
        setCaption(trUtf8("Form1"))
        @pushButton1.setText( trUtf8("push&Button1") )
        @pushButton1.setAccel( Qt::KeySequence.new(trUtf8("Alt+B")) )
        @listBox1.clear()
        @listBox1.insertItem(trUtf8("Nuevo elemento"))
    end
    protected :languageChange


end
begin
	a = Qt::Application.new(ARGV)
	b = Form1.new
	a.setMainWidget(b)
	b.show
	a.exec
end
