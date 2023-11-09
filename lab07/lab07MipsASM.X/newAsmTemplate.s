.set noreorder
 .global main # define main as a global label
 .text
main:
 la $a0, msg1 # put string address in argument register $a0
 jal my_strlen # call the function
 add $0, $0, $0 # branch delay slot nop
call_again:
 la $a0, msg2 # put string address in argument register $a0
 jal my_strlen # call the function
 add $0, $0, $0 # branch delay slot nop
done:
 j done # infinite loop
 add $0, $0, $0 # branch delay slot

my_strlen:
 add $v0, $0, $0 # i=0 ($v0 will also be return value)
nextchar:
 lbu $t0, 0($a0) # dereference the pointer
 beq $t0, $0, ret # we're done when we read '\0'
 add $0, $0, $0 # branch delay slot
 addi $v0, $v0, 1 # i++
 addi $a0, $a0, 1 # s++
 j nextchar
 add $0, $0, $0 # branch delay slot
ret:
 jr $ra # at end of string - return
 add $0, $0, $0 # branch delay slot

 .data
msg1:
 .asciz ""
msg2:
 .asciz "HI?"
