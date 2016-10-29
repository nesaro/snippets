com_pantalla EQU 0B800h ;; Asigna simbolo a expresion fija
tam_pantalla EQU 4000   ;; Asigna simbolo a expresion fija

DATOS          SEGMENT  ;; Comienzo del segmento datos
TEXTO          DB "BUSES Y PERIFERICOS. EUI.",13,10,"TITULACION DE INGENIERO TECNICO DE SISTEMAS",13,10,'$'  ;; define los bytes que comienzan en texto      
TEXTE          DB "AMIGOS Y AMIGAS, BIEN VENIDOS A LAS PRACTICAS DE BUSES PERIFERICOS",13,10,'$'             ;; define los bytes que comienzan en texte
DATOS ENDS              ;; Fin de segmento datos

PILA           SEGMENT  ;; Comienzo del segmento pila
               DB 127 DUP('p') ;; reserva 127 bytes inicializado a  p
apuntador      DB 'P'          ;; define 1 byte 
PILA           ENDS      ;; fin de segmento pila

CODIGO SEGMENT          ;; Comienzo del segmento de código
               ASSUME CS:CODIGO, DS:DATOS, SS:PILA   ;; Suponer registros de segmentos
borra_pantalla PROC                                  ;; Comienzo del procedimiento borrar pantalla
               PUSH ES								 ;; Depositar palabra ES en la pila
			   PUSH AX                               ;; Depositar palabra AX en la pila
               PUSH CX                               ;; Depositar palabra CX en la pila
               PUSH DI                               ;; Depositar palabra DI en la pila
               PUSHF                                 ;; Depositar banderas en la pila
			   MOV AX, com_pantalla                  ;; AX=com_pantalla
               MOV ES,AX                             ;; ES=AX ;; es=segmento de datos extra ;; limite inferior
               MOV CX, (tam_pantalla/2)+1            ;; CX=cosa
               MOV DI, tam_pantalla                  ;; DI=4000 ;; Acceso al segmento de datos ;; limite superior
               MOV AL, '-'                           ;; AL = '-' ;; texto a rellenar
               MOV AH, 07h                           ;; AH = 07h ;; atributo
               STD                                   ;; Activo la flag de direccion. Hace que vaya al revés
               REP STOSW                             ;; Repetir operación de cadena "Comprarse una tienda en el polo norte"
               POPF                                  ;; Recuperar banderas de la pila
               POP DI                                ;; Recuperar DI de la pila
               POP CX                                ;; Recuperar CX de la pila
               POP AX                                ;; Recuperar AX de la pila
               POP ES                                ;; Recuperar ES de la pila
               RET                                   ;; Retornar del procedimiento
               ENDP                                  ;; Fin del procedimiento
Todo_es_empezar:                                     ;; Etiqueta marca el comienzo del programa
            MOV AX, DATOS                            ;; AX=Datos
               MOV DS, AX                            ;; DS=AX
            MOV AX, PILA                             ;; AX=PILA
               MOV SS, AX							 ;; SS=AX
               MOV SP, OFFSET apuntador              ;; puntero a pila = direccion segun el com de la pila de apuntador
               MOV AH,09h                            ;; AH= 09h
            MOV DX, OFFSET TEXTO                     ;; DX= offset texto
               INT 21h                               ;; Invoca a la interrupción 21h Escribir cadena
            Call borra_pantalla                      ;; Llama al procedimiento borr_pantalla
NO:         MOV AH,09h                               ;; Etiqueta NO: AH=09h
            MOV DX, OFFSET TEXTE                     ;; DX=offset texte
               INT 21h                               ;; llamada interrupcion  21h
f:             MOV AH, 4Ch                           ;; etiqueta f: AH=4Ch
               INT 21h                               ;; Interrupcion 21h, volviendo al sistema operativo
CODIGO ENDS                                          ;; Fin de segmento Código
END            Todo_es_empezar                       ;; Fin de modulo fuente

