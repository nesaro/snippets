.data 0x10000000
dato2: .word 0xab778044
dato1: .word 0x6cffffff
.text
main:
lui $2,0x1000
lh $5,0($2)
lw $6,4($2)
