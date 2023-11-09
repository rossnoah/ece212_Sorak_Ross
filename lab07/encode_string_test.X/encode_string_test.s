###########################################################################
#
#    ECE 212 Lab 7 - Fall 2023
#    encode_string test file
#
########################################################################### 

  .set noreorder
    .global main         # define main as a global label
    .text
main: 
    la   $a0, msg        # put string address in argument register $a0
    addi $a1, $zero, 4   # put character shift amount in arg reg $a1
    jal  encode_string   # call the function
    add  $0, $0, $0      # branch delay slot nop
now_decode:
    la   $a0, msg        # put string address in argument register $a0
    addi $a1, $zero, -4  # put character shift amount in arg reg $a1
    jal  encode_string   # call the function
    add  $0, $0, $0      # branch delay slot nop
done:  
    j done               # infinite loop
    add $0, $0, $0       # branch delay slot

###########################################################################
#
#    Add assembly code for encode_char function here
#
###########################################################################
        
encode_char:
    slti $t0, $a0, 65			
    slti $t1, $a0, 90
    
    or	$t0, $t1, $t0		# $t0 = $t1 | 0t2

    beq	$t0, $t2, returnC	# if $t0 == 2t1 then goto returnC
    add	$s0, $s0, $s0		# NOOP




    addi $t0, $a0, -65		# $t0 = a01 -65 '
    sub	$t0, $t0, $a1		
    addi $t0, $t0, 26			# $t0 = $01 26


    addi $t1, $s0, 26			# $t1 = s01 26 0


    div	$t0, $t1			# $t0 / $t1
    mfhi $t0					# $t3 = $t0 % $t1 

    # offset = (offset - k + 26) % 26; (Offset in t0)
    addi $v0, $t0, 65			# $ra = $0, 65  Map back on to variable return (offset + 'A');
    jr $ra
    add	$s0, $s0, $s0		# NOOP
    
returnC:
    add	$v0, $t0, $0	# Put in v0
    jr $ra
    
###########################################################################
#
#    Add assembly code for encode_string function here
#
###########################################################################  

encode_string:
    addi $sp, $sp, -8 # make room on the stack for 2 registers
    sw $a0, 0($sp) # save $a0 on the stack
    sw $ra, 4($sp) # save $ra on the stack

    bne	$s0, $0, loop

loop:
    lw $a, $a0, 0
    jal	encode_char
    j loop



###########################################################################
#
#    data segment assembler directives to allocate storage for string msg
#
########################################################################### 
    
      .data
msg:
      .asciz "WELCOME BACK MY FRIENDS 2 THE show THAT NEVER ENDS"

