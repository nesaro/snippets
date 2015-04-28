
def generar_claves():

    letras = 'juhy'
    digitos = '145670'

    def G(p1, p2):
        if len(p2) == 6:
            yield (p1 + p2)
        elif len(p1) == 4:
            for d in digitos:
                if d not in p2:
                    for x in G(p1, p2 + d): yield x
        else:
            for l in letras:
                if l not in p1:
                    for x in G(p1 + l, ''): yield x

    for p in G('ft', ''):
        yield p
            

if __name__ == '__main__':
    for x in generar_claves():
        print x
