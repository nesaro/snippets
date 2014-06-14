.data

dir:       .asciiz "Introduce la cadena de caracteres: "

buffer:    .space  10



.text

main:      li $v0,4      #codigo de imprimir cadena

la $a0,dir    #direccion de la cadena

syscall       #llamada al sistema



li $v0,8      #codigo de leer el string

la $a0,buffer  #direccion de lectura de cadena

li $a1,10     #espacio maximo de la cadena

syscall       #llamada al sistema

li $v0,4      #codigo de imprimir cadena                                                                                                                                                                                                                  
la $a0,buffer   
syscall       #llamada al sistema
																																	
