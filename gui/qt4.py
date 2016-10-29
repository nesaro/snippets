from PyQt4 import QtCore,QtGui

test_app=QtGui.QApplication([])
ventana=QtGui.QMainWindow()
widget=QtGui.QWidget()
layout=QtGui.QHBoxLayout(widget)
etiqueta=QtGui.QLabel("hola")
etiqueta=QtGui.QGraphicsView()
etiqueta2=QtGui.QLabel("Que tal")
layout.addWidget(etiqueta)
layout.addWidget(etiqueta2)
ventana.setCentralWidget(widget)
ventana.show()
test_app.exec_()
