
;;
;; Procedimientos a dividir el programa
;;
;;        Limpiar y recuadrar la pantalla           limpiar_pantalla () -> ()
;;        Desplazar texto                           desp_text () -> ()
;;        Leer tecla                                leer_tecla () -> ()
;;        Guardar palabra y "wrap"                  guardar_palabra(tecla) -> ()
;;        * Ningún procedimiento para borrar
;;        

com_pantalla EQU 0B800h ;; Asigna simbolo a expresion fija
tam_pantalla EQU 4000   ;; Asigna simbolo a expresion fija


DATOS SEGMENT

    PALABRA      DB 2 ;; Guarda el tamaño de la palabra
    FIL          DB 2
    COL		 DB 2
    TECLA        DB 2
    SALIR        DB 2 ;; Bit de salida
    
    ENDS


CODIGO SEGMENT
    ASSUME CS:CODIGO, DS:DATOS

    ;;
    ;; Procedimiento para limpiar la pantalla y dibujar el recuadro
    ;;

limpiar_pantalla PROC

    ;; Guardamos los registros que vamos a modificar

    PUSH ES
    PUSH AX
    PUSH CX
    PUSH DI
    PUSHF

    ;; Ponemos en la dirección de memoria de la pantalla las almohadillas

    MOV AX, com_pantalla
    MOV ES,AX
    MOV CX, (tam_pantalla/2)+1
    MOV DI, tam_pantalla
    MOV AL, '#'
    MOV AH, 07h
    STD
    REP STOSW

    ;; Dibujamos el recuadro para escribir en la pantalla
    
    MOV CX,19  ;; 19 iteraciones
    rellenar_esps:

    ;;MOV AX, com_pantalla + 160*(CX+3) + 4

    MOV AX, CX ;; AX=CX
    ADD AX,2   ;; AX+=2 ;; Desplaza la linea que empieza (2)
    MOV DX,10 ;; DX=10
    MUL DX      ;; DX=DX*AX
    ADD AX, com_pantalla ;; AX=AX+com_pantalla
    ADD AX,0    ;; AX=AX+4 (alineacion izq der ) 1=10.. no tiene sentido!

    MOV ES,AX
    PUSH CX
    
    MOV CX, 78                 ;; 72 palabras a rellenar
    MOV DI,156 
    MOV AL, ' '
    MOV AH, 07h
    ;;STD
    REP STOSW                  ;; Rep repite CX veces stosw: guarda ax en ES hasta ES+DI
    POP CX


    LOOPNZ rellenar_esps  ;;ir a rellenar_esps mientras CX sea =/0

    ;; Volvemos a dejar los registros como estaban al entrar
    POPF
    POP DI
    POP CX
    POP AX
    POP ES
    RET

    ENDP

;;
;;  PROCEDIMIENTO      Leer tecla: Lee una tecla del teclado y la guardo en tecla  
;;
leertecla PROC
   ;; PUSH REGISTROS
   PUSH AX

   ;; FUNCION EN SI
   MOV ah,00h		;;function 00h of
   INT 16h		;;interrupt 16h ;; fuarda en al el caracter
   MOV TECLA,al

   ;; POP REGISTROS
   POP AX
   RET
   ENDP

;;
;; Procedimiento leemem: Lee la posicion fila,columna-1 y la guarda en AL
;;
leemem PROC
   PUSH BX 
   PUSH ES

   MOV BL, FIL
   MOV BH, 0   ;; INICIALIZAMOs BX
   SHL BX,5   
   MOV AX,BX  
   SHL BX,2  ;; Con los dos shift realmente multiplicamos x 160
   ADD BX, AX
   MOV AL,COL
   XOR AH,AH ;; AH=0
   SHL AX,1 ;; multiplicamos x 2
   ADD BX,AX ;; Sumamos
   ;; BX actua de desplazamiento de com_pantalla
   MOV AX,com_pantalla 
   MOV ES,AX  ;; ES=com_pantalla
   MOV AL,ES:[BX]                  ;; guarda a AL en ES+BX
   INC BX 
   MOV AH,ES:[BX]

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

   MOV BL, FIL
   MOV BH, 0   ;; INICIALIZAMOs BX
   SHL BX,5   
   PUSH AX ;; usamos AX temporalmente
   MOV AX,BX  
   SHL BX,2  ;; Con los dos shift realmente multiplicamos x 160
   ADD BX, AX
   MOV AL,COL
   XOR AH,AH ;; AH=0
   SHL AX,1 ;; multiplicamos x 2
   ADD BX,AX ;; Sumamos
   ;; BX actua de desplazamiento de com_pantalla
   MOV AX,com_pantalla 
   MOV ES,AX  ;; ES=com_pantalla
   POP AX  ;; Fin uso temporal
   PUSH AX
   MOV AH, 07h
   MOV ES:[BX],AL                  ;; guarda a AL en ES+BX
   INC BX 
   MOV ES:[BX],AH

   POP AX
   POP ES 
   POP BX

RET
ENDP
 
;;
;;  PROCEDIMIENTO     guardarpalabra: leo tecla, y compruebo la posición para saber lo que tengo que hacer 
;;
guardapalabra PROC
   ;; PUSH REGISTROS
   PUSH AX

   ;; FUNCION EN SI
   MOV al,tecla    ;; Mi teclaaaaa
   CMP al,32
   JE espacio
   CMP al,'Q'
   JE salirdeprograma
   CMP COL,78
   JA saltolinea
   CALL escmem
   INC COL
   INC PALABRA
   JMP fin

salirdeprograma:
   INC SALIR
   JMP fin

saltolinea:
   ;; Bloque que escribe la ultima letra que se ha tecleado en el sitio definitivo
   PUSH BX
   PUSH CX
   INC FIL
   MOV CL,COL
   XOR BL,BL
   ADD BL,PALABRA
   MOV COL,BL
   INC COL
   call escmem
   MOV COL,CL
   DEC FIL
   POP CX
   POP BX
   ;; Llamar a funcion borrar palabra
   CALL borrarpalabra
   INC COL
   MOV PALABRA,0 ;; Ya palabra no tiene sentido
   JMP fin

espacio:
   MOV AL,32
   CALL escmem
   MOV PALABRA,0
   INC COL
   JMP fin
   

fin:
   ;; POP REGISTROS
   POP AX
   RET
   ENDP

;;
;; PROCEDIMIENTO borrarpalabra: estoy en la ultima columna, y tengo una palabra a medias.. que triste!
;;
borrarpalabra PROC
   PUSH BX
   PUSH CX
   PUSH AX

   MOV CL,PALABRA ;; CL=TAM de la palabra
   XOR CH,CH ;; Acondiciono CX
   MOV COL,1
   INC FIL
   MOV BH,78
   SUB BH,PALABRA ;; BH tiene ahora la distancia entre la palabra nueva y la vieja

   bucleborrar:
   DEC FIL
   ADD COL,BH ;; Estamos en la letra antigua
   CALL leemem
   PUSH AX
   MOV AL,32 ;; AL = " "
   CALL escmem
   POP AX
   INC FIL
   SUB COL,BH 
   CALL escmem
   INC COL
   LOOPNZ bucleborrar

   POP AX
   POP CX
   POP BX
   RET
   ENDP

;;
;;  PROGRAMA PRINCIPAL
;;

comienzo:

    MOV AX, DATOS
    MOV DS, AX
    MOV FIL, 3
    MOV COL, 1
    MOV SALIR, 0
    ;; MOV AX, PILA
    ;; MOV SS, AX							
    ;; MOV SP, OFFSET apuntador
    ;; MOV AH,09h
    ;; MOV DX, OFFSET TEXTO
    ;; INT 21h
    CALL limpiar_pantalla
bucle:
    CMP SALIR,1
    JE finalprograma
    CALL leertecla
    CALL guardapalabra
    JMP bucle

    ;; NO:         MOV AH,09h
    ;; MOV DX, OFFSET TEXTE
    ;; INT 21h
finalprograma:
    MOV AH, 4Ch
    INT 21h

CODIGO ENDS
END comienzo
