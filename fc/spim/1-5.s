#------------------------------------------------#

#  zona de datos                                 #

.data

#------------------------------------------------#

octeto:    .word 0x10203040

siguiente: .byte 0x20

#------------------------------------------------#

#  zona de instrucciones                         #

.text

#------------------------------------------------#

main:    lbu $s0, octeto+1($0)