# -*- coding: latin1 -*-

class Arbolito:
    def __init__(self, ldapuri = 'ldap://openldap.domain', bind = None):

        self.ldapuri = ldapuri
        self.storedns = {}

        import ldap
        self.ldapobject = ldap.initialize(ldapuri)

        if bind is not None:
            self.ldap.bind(bind[0], bind[1], ldap.AUTH_SIMPLE)

    def storeadditem(self, dn):
        x = dn.find(',')
        if x == -1:
            p, n = None, dn
        else:
            b = dn[x+1:]
            if self.storedns.has_key(b):
                p = self.storedns[dn[x+1:]]
                n = dn[:x]
            else:
                p, n = None, dn

        self.storedns[dn] = self.store.append(p, (n,))

    def makeview(self, basedn):

        import gtk, ldap
        self.store = gtk.TreeStore(str)

        # pillar todo el árbol, al trancaso.. sólo los DNs
        # XXX molaría más una búsqueda asíncrona, para mejorar 
        #     el "responsiveness" de la aplicación
        r = self.ldapobject.search_s(basedn, ldap.SCOPE_SUBTREE, attrlist=[''])
        for dn, attrs in r:
            self.storeadditem(dn)

        # Columna para los de-enes
        tv = gtk.TreeView(self.store)
        tv.append_column(gtk.TreeViewColumn('DN', gtk.CellRendererText(), text=0))

        return tv



if __name__ == '__main__':

    import pygtk
    pygtk.require('2.0')
    import gtk

    a = Arbolito()
    tv = a.makeview('dc=fundescan')
    scroll = gtk.ScrolledWindow()
    scroll.add(tv)

    win = gtk.Window(gtk.WINDOW_TOPLEVEL)
    win.add(scroll)
    win.show_all()

    win.connect('destroy', lambda *x: gtk.main_quit())

    gtk.main()


