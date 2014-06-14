.data

dir:       .asciiz "Hola. Ha funcionado."



.text

main:      li $v0,4    #codigo de imprimir cadena

la $a0,dir+4   #direccion de la cadena

syscall      #llamada al sistema
