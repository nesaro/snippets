#From somewhere on the internet
# http://mailman.daa.com.au/pipermail/pygtk/2005-May/010127.html

import gtk, time


class TableTest:
    #--------------------------------------------------------------------------
    def __init__(self):
        window = gtk.Window()
        window.connect('destroy', self._onWindowDestroy)
        window.set_default_size(400, 100)

        self.table = gtk.Table(rows=2, columns=1)
        self.table.set_border_width(10)

        self.entry = gtk.HBox()
        entry = gtk.Entry()
        self.entry.pack_start(entry)
        entry.show()
        self.table.attach(self.entry, 0, 1, 0, 1, yoptions=gtk.SHRINK)
        self.entry.show()

        self.Testing = self.entry

        button = gtk.Button(label="Click Me!")
        button.connect('clicked', self._onButtonClicked)
        self.table.attach(button, 0, 1, 1, 2, yoptions=gtk.SHRINK)
        button.show()

        window.add(self.table)
        self.table.show()


        window.show()

    #--------------------------------------------------------------------------
    def _onButtonClicked(self, *args):
        self.entry.hide()
        #self.entry.destroy()

        self.entry = gtk.HBox()
        button = gtk.Button()
        image = gtk.image_new_from_stock(gtk.STOCK_SAVE, gtk.ICON_SIZE_LARGE_TOOLBAR)
        button.add(image)
        image.show()
        button.show()
        self.entry.pack_start(button)
        self.entry.set_border_width(10)
        self.table.attach(self.entry, 0, 1, 0, 1, yoptions=gtk.SHRINK, xoptions=gtk.SHRINK)
        self.entry.show()
        while gtk.events_pending():
            gtk.main_iteration()
        time.sleep(3)

        self.entry.hide()
        #self.entry.destroy()

        self.entry = gtk.Entry()
        self.table.attach(self.entry, 0, 1, 0, 1, yoptions=gtk.SHRINK, xoptions=gtk.SHRINK)

        self.entry.show()
        
        

    #--------------------------------------------------------------------------
    def _onWindowDestroy(self, *args):
        gtk.main_quit()

#------------------------------------------------------------------------------

if __name__ == '__main__':
    test = TableTest()
    gtk.main()
