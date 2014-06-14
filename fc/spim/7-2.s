

.data

suma:          .space  4



.text

main:          addi    $sp, $sp, -4   #apilar dir. ret.

sw      $ra,0($sp)

	li      $a0,10  

	li      $a1,2

	jal     subr

sw      $v0,suma($0)

	lw      $ra, 0($sp)            #desapilar dir. ret.

	addi    $sp,$sp,4

	jr      $ra



	subr:          add     $v0, $a0,$a1

	jr      $ra
