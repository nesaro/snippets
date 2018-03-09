#!/usr/bin/python

"""Proyecto Buscaprint"""


#Facilidades de compra


sources = ["vistaprint", "saxoprint"]  #Fuentes válidas
itemlist = ["flyer", "cartel", "tarjetas", "diptico", "triptico", "hojacarta", "sobre", "carpetas"]  #Items válidos
required_keys = ["source", "price", "item", "date", "quantity"] #Claves obligatorias para añadir un registro
required_query = ["item"] #Claves obligatorias al buscar registro

itemrules = {"flyer":[],
        "cartel":[]} #Reglas especificas para cada uno de los tipos de item

def validateitem(item:dict) -> bool:
    """Determina si un item es válido o no"""
    if item["item"] not in itemlist:
        return False
    if item["source"] not in sources:
        return False
    for key in required_keys:
        if key not in item:
            return False
    for validator in itemrules[item["item"]]:
        if not validator(item):
            return False
    return True

class Indexer(list):
    """Clase que contiene el indice de elementos"""
    @property
    def lastid(self) -> int:
        """Devuelve el último identificador"""
        if not self:
            return 0
        return max((x["id"] for x in self))

    def append(self, fullelement):
        """Añade un elemento completo"""
        #añade un id al elemento
        #Verifica que no existe un elemento similar
        if not validateitem(fullelement):
            return False
        else:
            fullelement["id"] = self.lastid + 1
        list.append(self, fullelement)
        return True

    def save(self):
        """Guarda el contenido en un fichero"""
        pass

    def __load(self):
        """Restaura el contenido desde el fichero"""
        pass

def search(indexer, sort = "price", **keyargs) -> list:
    """Realiza búsquedas sobre un indexador"""
    for key in required_query:
        if not key in keyargs:
            return []
    result = []
    for element in indexer:
        for key, value in keyargs.items():
            if element[key] != value:
                break
        result.append(element)
    #TODO: si hay mas de una fecha para un mismo lugar, devuelve la ultima
    #Para las cantidades, ajustar al siguiente y el anterior
    result = sorted(result, key = lambda x:x[sort])
    return result

if __name__ == "__main__":
    indexer = Indexer()
    indexer.append({"source":"vistaprint", "item":"flyer", "price":50.00, "quantity":20, "date":False})
    indexer.append({"source":"saxoprint", "item":"flyer", "price":40.00, "quantity":15, "date":False})
    print("Busqueda de flyers")
    print(search(indexer, item="flyer", quantity=20))
