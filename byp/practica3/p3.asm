
com_pantalla EQU 0B800h ;; Por comodidad, hago las asignaciones de tama�o y direccion
tam_pantalla EQU 4000   ;; de memoria de video


DATOS SEGMENT

    PALABRA      DB 2        ;; Guarda el tama�o de la palabra
    FIL          DB 2        ;; Guarda la posici�n de fila actual
    COL          DB 2        ;; Guarda la columna actual
    TECLA        DB 2        ;; Guarda el valor de la �ltima tecla pulsada
    SALIR        DB 2        ;; Bit de salida
    
    ENDS


CODIGO SEGMENT

    ASSUME CS:CODIGO, DS:DATOS  ;; Vale con la pila stantard

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Procedimiento de acondicionamiento de pantalla (limpiado y recuadrado ;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

limpiar_pantalla PROC

    ;; Guardamos los registros que vamos a modificar

    PUSH ES
    PUSH AX
    PUSH CX
    PUSH DI
    PUSHF

	;; Rellenamos TODA la pantalla de almohadillas

    MOV AX, com_pantalla
    MOV ES,AX
    MOV CX, (tam_pantalla/2)+1
    MOV DI, tam_pantalla
    MOV AL, '#'
    MOV AH, 07h
    STD
    REP STOSW

    ;; Dibujamos el recuadro negro para escribir en la pantalla
    
    MOV CX,19                ;; 19 iteraciones

	;; BUCLE
	
    rellenar_esps:

    MOV AX, CX               ;; AX=CX
    ADD AX,2                 ;; AX+=2 ;; Desplaza la linea que empieza (2)
    MOV DX,10                ;; DX=10
    MUL DX                   ;; DX=DX*AX 
    ADD AX, com_pantalla     ;; AX=AX+com_pantalla

    MOV ES,AX                ;; ES es un registro de segmento, pero doy una direccion multiplo
    PUSH CX
    
    MOV CX, 78               ;; 72 espacios a rellenar
    MOV DI, 156
    MOV AL, ' '              
    MOV AH, 07h              ;; Propiedades standard
    REP STOSW                ;; Rep repite CX veces stosw: guarda ax en ES hasta ES+DI
    POP CX

    LOOPNZ rellenar_esps     ;;ir a rellenar_esps mientras CX sea =/0
	
	;; FIN BUCLE

    ;; Volvemos a dejar los registros como estaban al entrar
    POPF
    POP DI
    POP CX
    POP AX
    POP ES
    RET

    ENDP

;;
;;  PROCEDIMIENTO      Leer tecla: Lee una tecla del teclado y la guarda en tecla  
;;

leertecla PROC
   PUSH AX

   MOV AH,00h
   INT 16h	
   MOV TECLA,al

   POP AX
   RET
   ENDP

;;
;;  PROCEDIMIENTO     leemem: Lee la posicion fila,columna-1 y la guarda en AL
;;

leemem PROC
   PUSH BX 
   PUSH ES

   MOV BL, FIL
   MOV BH, 0                 ;; BH=0
   SHL BX,5                  ;; BX=FIL*32
   MOV AX,BX                 ;; AX=BX
   SHL BX,2                  ;; BX=BX*4
   ADD BX, AX                ;; BX=AX (Hemos multiplcado por 160)
   MOV AL,COL                ;; AL=COL
   XOR AH,AH                 ;; AH=0
   SHL AX,1                  ;; multiplicamos x 2
   ADD BX,AX                 ;; Sumamos y bx
   
   ;; BX actua de desplazamiento de com_pantalla
   
   MOV AX,com_pantalla 
   MOV ES,AX                 ;; ES=com_pantalla
   MOV AL,ES:[BX]            ;; guarda a AL en ES+BX
   INC BX 
   MOV AH,ES:[BX]            ;; AH son las propiedades

   POP ES 
   POP BX

RET
ENDP
 
;;
;; Procedimiento escmem: Escribe en la posicion FILA COLUMNA el valor de AL
;;
escmem PROC
   PUSH BX 
   PUSH ES
   PUSH AX 

   ;; Bloque identico al de leemen
   MOV BL, FIL
   MOV BH, 0                 
   SHL BX,5   
   MOV AX,BX  
   SHL BX,2                  
   ADD BX, AX
   MOV AL,COL
   XOR AH,AH 
   SHL AX,1 
   ADD BX,AX 
   
   ;; BX actua de desplazamiento de com_pantalla
   MOV AX,com_pantalla 
   MOV ES,AX                 ;; ES=com_pantalla
   POP AX                    ;; Fin uso temporal
   MOV AH, 07h               ;;QUITADO UN PUSH Y UN POP DE AQUI
   MOV ES:[BX],AL            ;; guarda a AL en ES+BX
   INC BX 
   MOV ES:[BX],AH

   POP ES 
   POP BX

RET
ENDP


;;
;;  PROCEDIMIENTO     guardarpalabra: leo tecla, y compruebo la posici�n para saber lo que tengo que hacer 
;;

guardapalabra PROC
   PUSH AX

   ;; FUNCION EN SI
   MOV al,COL                ;; Verificamos si no estamos en la �ltima linea
   CMP al,78
   JNE  sinproblem 
   MOV al,FIL            
   CMP al,21                 ;; Verificamos si no estamos en la ultima columna
   JNE  sinproblem
		                     ;;  Es necesario hacer un scroll
   PUSH BX
   PUSH CX
   PUSH DX
   MOV AH,6
   MOV AL,1
   MOV CH,3
   MOV CL,2
   MOV DH,21
   MOV DL,78
   INT 10h                   ;;(2,3)-(78,21), desplazamos scroll

   POP DX
   POP CX
   POP BX  
   DEC FIL


sinproblem:
   MOV al,tecla    
   CMP al,32                 ;;Nos encontramos con una pulsacion de espacio
   JE espacio
   CMP al,'Q'
   JE salirdeprograma        ;;Nos encontramos con una pulsacion de la tecla de salida
   CMP COL,77
   JA saltolinea             ;;Nos encontramos con un salto de linea con palabra cortada
   CALL escmem
   INC COL
   INC PALABRA
   JMP fin

salirdeprograma:
   INC SALIR                 
   JMP fin

saltolinea:
   PUSH BX
   PUSH CX
   CMP PALABRA,50
   JA nocopiar               ;; La palabra es demasiado grande, no merece la pena copiarla
   
   ;; Bloque que escribe la ultima letra que se ha tecleado en el sitio definitivo
   
   INC FIL
   MOV CL,COL
   XOR BL,BL
   ADD BL,PALABRA            ;;BL=tama�o de palabra
   MOV COL,BL                ;;COL=tama�o de palabra
   INC COL                   ;;COL++ 
   call escmem               ;;escribo la letra
   MOV COL,CL                
   DEC FIL
   POP CX
   POP BX
   CALL borrarpalabra        ;; La funcion borrarpalabra
   INC COL                   ;; borrarpalabra deja el cursor en la posicion de la �ltima letra
   JMP FIN

nocopiar:
   PUSH AX
   MOV AL, 7eh               ;; Caracter gusanillo
   MOV AH, 07h
   call escmem               ;; Escrito en la ultima posicion
   POP AX
   MOV COL,1
   INC FIL
   call escmem               ;; Escribo el caracter pendiente en la primera columna de la siguiente linea
   INC COL
   MOV PALABRA,0             ;;Palabra se podria desbordar si no la pongo a 0
   POP CX
   POP BX
   JMP fin

espacio:
   MOV AL,32
   MOV PALABRA,0
   CMP COL,77                ;; Si no estoy en la ultima posicion nocorto
   JL nocorto                
   MOV COL,1
   INC FIL
   JMP FIN  
nocorto:
   INC COL
   JMP fin
   

fin:
   POP AX
   RET
   ENDP

;;
;; PROCEDIMIENTO borrarpalabra: procedimiento que copia al principio de la siguiente fila la ultima palabra de una fila
;;

borrarpalabra PROC
   PUSH AX
   PUSH BX
   PUSH CX

   MOV CL,PALABRA            ;; CL=TAM de la palabra
   XOR CH,CH                 ;; Acondiciono CX
   MOV COL,1                 
   INC FIL
   MOV BH,78
   SUB BH,PALABRA            ;; BH tiene ahora la distancia entre la palabra nueva y la vieja
   DEC BH

   bucleborrar:
   DEC FIL                   ;; Voy a la fila anterior
   ADD COL,BH                ;; Estamos en la letra antigua
   CALL leemem               ;; la leo
   PUSH AX                   ;; la guardo
   MOV AL,32                 ;; AL = " "
   CALL escmem               ;; escribo el espacio
   POP AX                 
   INC FIL                   ;; Me muevo a la siguiente fila
   SUB COL,BH                ;; Me muevo a la posicion por la que iba de la otra palabra
   CALL escmem               ;; Escribo la letra que habia leido
   INC COL                   ;; Incremento la columna 
   LOOPNZ bucleborrar        ;; Y vuelta a empezar (la posicion que queda es la de la ultima letra)
   
   POP CX
   POP BX
   POP AX
   RET
   ENDP

;;
;;
;;  PROGRAMA PRINCIPAL
;;
;;

comienzo:
    MOV AX, DATOS
    MOV DS, AX
    MOV FIL, 3               ;; Fila y columna de comienzo
    MOV COL, 1
    MOV SALIR, 0
   
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
 
    MOV AH,6
    MOV AL,0
    MOV CH,0
    MOV CL,0
    MOV DH,24
    MOV DL,79
    INT 10h                   ;;(2,3)-(78,21), desplazamos scroll

    POP DX
    POP CX
    POP BX  
    POP AX
    CALL limpiar_pantalla
bucle:
    CMP SALIR,1              ;; Se da la condicion de salida
    JE finalprograma
    CALL leertecla           ;; Leo la tecla
    CALL guardapalabra       ;; Guardo la tecla
    JMP bucle

finalprograma:               ;; Salida limpia del programa
    MOV AH, 4Ch
    INT 21h

CODIGO ENDS
END comienzo
