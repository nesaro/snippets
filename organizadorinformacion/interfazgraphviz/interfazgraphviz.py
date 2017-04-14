#!/usr/bin/python
# -*- coding: utf-8 -*-

import pydot

class NoDisjuntoException(Exception):
    def __init__(self):
        Exception.__init__(self)

class Relation:
    """Parent class for all relations"""
    def __init__(self):
        self.listaparejas = []

    def renderrelation(graph):
        pass

    def append(self, pareja):
        self.listaparejas.append(pareja)

class XRelation(Relation):
    """Exclusive relation"""
    def exclusive_check(self):
        """Comprueba exclusividad de la relacion"""
        for elemento,categoria in self.listaparejas:
            for elemento2,categoria2 in self.listaparejas:
                if elemento==elemento2 and categoria!=categoria2:
                    raise NoDisjuntoException


class StandardRelation(Relation):
    """Show a line between linked elements"""
    def renderrelation(self, graph):
        for parejas in self.listaparejas:
            graph.add_node(pydot.Node(parejas[0]))
            graph.add_node(pydot.Node(parejas[1]))
            graph.add_edge(pydot.Edge(parejas[0],parejas[1]))

class IconRelation(XRelation):
    """A R B means A has B icon"""
    def __init__(self):
        Relation.__init__(self)
        self.listaformas = []

    def append_shape(self, pareja):
        self.listaformas.append(pareja)

    def renderrelation(self, graph):
        self.exclusive_check()
        for parejas in self.listaparejas:
            graph.add_node(pydot.Node(parejas[0]))
            for x in self.listaformas:
                if x[0]==parejas[1]:
                    forma=x[1]
            shape_node(graph,parejas[0],forma)

class ClusterRelation(XRelation):
    """A R B means A is inside B box"""
    def renderrelation(self, graph):
        self.exclusive_check()
        listacajas = []
        for elemento,categoria in self.listaparejas:
            if not categoria in listacajas:
                listacajas.append(categoria)
        for caja in listacajas:
            cluster=pydot.Cluster(caja)
            cluster.set_label(caja)
            for elemento,categoria in self.listaparejas:
                if categoria==caja:
                    cluster.add_node(pydot.Node(elemento))
            cluster.set_graph_parent(graph)
            graph.add_subgraph(cluster)

class GVInterface:
    """Interface for graphviz"""
    def __init__(self):
        import re
        self.__definitions = [] #List of relation definitions(strings)
        self.__relations = [] #List of relation definitions (Relation)
        self.g = pydot.Dot()
        self.comment=re.compile('^#')
        self.definition=re.compile('R[SIC]:')
        self.relation=re.compile('^\w*\s\w*\s\w*$')

    def read_file(self,filename):
        f = open(filename,'r')
        cadena=f.readline()
        while cadena!='':
            self.__parse(cadena)
            cadena=f.readline()

    def render_png(self,filename):
        for relation in self.__definitions:
            relation.renderrelation(self.g)
        self.g.write_png(filename,prog='dot')

    def __parse(self,line):
        #Linea de comentarios
        if self.comment.match(line):
            pass
        #Linea de definicion de relacion
        elif self.definition.match(line):
            self.__parse_definition(line)
        elif self.relation.match(line):
            self.__parse_relation(line)
        #Linea de relación

    def __parse_relation(self, line):
        lista = line.split()
        print lista
   
    
    def __parse_definition(self, line):
        pass


def shape_node(graph, nodename, shape):
    """Set node shape to shape"""
    a = graph.get_node(nodename)
    a.set("shape", shape)


def edge_label(graph, edgesource, edgedest, label):
    a = graph.get_edge(edgesource, edgedest)
    a.set("label", label)

def edge_size(graph, edgesource, edgedest, size):
    a = graph.get_edge(edgesource, edgedest)
    a.set("arrowsize", size)

def edge_head(graph, edgesource, edgedest, type):
    a = graph.get_edge(edgesource, edgedest)
    a.set("arrowhead", type)


##relacion = StandardRelation()
##relacion.append(["a","b"])
##relacion.append(["a","c"])
##relacion.renderrelation(g)
##
##relacion2 = IconRelation()
##relacion2.append_shape(["perro","circle"])
##relacion2.append_shape(["gato","box"])
##relacion2.append_shape(["tiburon","circle"])
##relacion2.append(["p1","perro"])
##relacion2.append(["p2","gato"])
##relacion2.append(["p3","gato"])
##relacion2.append(["p4","tiburon"])
##relacion2.renderrelation(g)
##
##relacion3 = StandardRelation()
##relacion3.append(["p1","perro"])
##relacion3.append(["p2","gato"])
##relacion3.append(["p3","gato"])
##relacion3.append(["p4","tiburon"])
##relacion3.append(["p4","tiburon"])
###relacion3.append(["p3","tiburon"])
##relacion3.renderrelation(g)


if __name__ == "__main__":
    interface=GVInterface()
    interface.read_file("interfazgraphviz-ejemplo.txt")
    interface.render_png("ejemplo.png")


#AQUI... falta los parser de definiciones y relaciones
