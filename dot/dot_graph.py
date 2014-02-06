import pydot

class Lista(list):
    def __init__(self):
        list.__init__(self)

    def edges(self):
        lista=[]
        for n in range(len(self)-1):
            lista.append((self.__getitem__(n),self.__getitem__(n+1)))
        return lista


hola=Lista()
hola+=[1,2,3,4,5,1,2,3,1,23,1,4,5,6]
edges=hola.edges()
g=pydot.graph_from_edges(edges) 
g.write_png('graph_from_edges_dot.png', prog='dot') 
