 

.data

numero:    .word 2147483647

.text

main:      lw    $t0,numero($0)

	addi $t1,$t0,1
