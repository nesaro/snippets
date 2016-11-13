
com_pantalla EQU 0B800h ;; Por comodidad, hago las asignaciones de tamaño y direccion
tam_pantalla EQU 4000   ;; de memoria de video


DATOS SEGMENT

    PALABRA      DB 2        ;; Guarda el tamaño de la palabra
    FIL          DB 2        ;; Guarda la posición de fila actual
    COL          DB 2        ;; Guarda la columna actual
    TECLA        DB 2        ;; Guarda el valor de la última tecla pulsada
    SALIR        DB 2        ;; Bit de salida
    
    ENDS


CODIGO SEGMENT

    ASSUME CS:CODIGO, DS:DATOS  ;; Vale con la pila stantard

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Procedimiento de desplazamiento del contenido de la pantalla          ;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


desplazar PROC
   	PUSH AX
   	PUSH BX
   	PUSH CX
   	PUSH DX
   	MOV BH,7
   	MOV AH,6
   	MOV AL,1
   	MOV CH,3
   	MOV CL,1
   	MOV DH,21
   	MOV DL,78
   	INT 10h                

   	POP DX
   	POP CX
   	POP BX
   	POP AX
    RET
    ENDP

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Procedimiento de acondicionamiento de pantalla (limpiado y recuadrado ;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

limpiar_pantalla PROC

    ;; Guardamos los registros que vamos a modificar

    PUSH ES
    PUSH AX
    PUSH CX
    PUSH DI
    PUSH DX
    PUSH BX
    PUSHF
	;; Bloque solucionador del problema de wxp (pantalla negra)
	MOV BH,7
	MOV AH,6
	MOV AL,0
	MOV CH,0
	MOV CL,0
	MOV DH,24
	MOV DL,79
	INT 10h                  


	;; Rellenamos TODA la pantalla de almohadillas

    MOV AX, com_pantalla
    MOV ES,AX
    MOV CX, (tam_pantalla/2)+1
    MOV DI, tam_pantalla
    MOV AL, '#'
    MOV AH, 07h
    STD
    REP STOSW
	
	;; BLOQUE que genera el cuadrado negro
    MOV BH,7
    MOV AH,6
    MOV AL,0
    MOV CH,3
    MOV CL,1
    MOV DH,21
    MOV DL,78
    INT 10h                   

    ;; Volvemos a dejar los registros como estaban al entrar
    POPF
    POP BX
    POP DX
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
   MOV AH, 07h               
   MOV ES:[BX],AL            ;; guarda a AL en ES+BX
   INC BX 
   MOV ES:[BX],AH

   POP ES 
   POP BX

RET
ENDP


;;
;;  PROCEDIMIENTO     guardarpalabra: leo tecla, y compruebo la posición para saber lo que tengo que hacer 
;;

guardapalabra PROC
   PUSH AX
   PUSH BX
   PUSH CX

   ;; FUNCION EN SI
   MOV al,COL                ;; Verificamos si no estamos en la última linea
   CMP al,78
   JNE  sinproblem 
   MOV al,FIL            
   CMP al,21                 ;; Verificamos si no estamos en la ultima columna
   JNE  sinproblem
   call desplazar
   DEC FIL

sinproblem:
   MOV al,tecla    
   CMP al,32                 ;;Nos encontramos con una pulsacion de espacio
   JE espacio
   CMP al,'Q'
   JE salirdeprograma        ;;Nos encontramos con una pulsacion de la tecla de salida
   CMP al,13
   JE intro                  ;;Es un intro
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
   CMP PALABRA,50
   JA nocopiar               ;; La palabra es demasiado grande, no merece la pena copiarla
   
   ;; Bloque que escribe la ultima letra que se ha tecleado en el sitio definitivo
   
   INC FIL
   MOV CL,COL
   XOR BL,BL
   ADD BL,PALABRA            ;;BL=tamaño de palabra
   MOV COL,BL                ;;COL=tamaño de palabra
   INC COL                   ;;COL++ 
   call escmem               ;;escribo la letra
   MOV COL,CL                
   DEC FIL
   CALL borrarpalabra        ;; La funcion borrarpalabra
   INC COL                   ;; borrarpalabra deja el cursor en la posicion de la última letra
   JMP FIN

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
   
intro: 
   CMP FIL,21
   JL intronormal            ;; Aqui decidimos si el intro corresponde a la última linea 
   call desplazar            ;; Hacemos un scroll
   MOV COL,1                 ;; Movemos el cursor a la siguiente linea
   MOV PALABRA,0             ;; Contador de palabra a 0
   JMP fin                   

intronormal:
   MOV PALABRA,0
   MOV COL,1                 ;; Simplemente desplazamos el cursor
   INC FIL
   JMP fin

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
   JMP fin


fin:
   POP CX
   POP BX
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
