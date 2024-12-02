#Bryan Castaneda Mayorga, CS2640, December 1st 2024 , Stack in MIPS - Reverse Array
# Program to reverse an array using the stack

.macro exit
    li $v0, 10
    syscall
.end_macro

.data
array: .word 5, 4, 3, 2, 1
arrayElements: .asciiz "Array elements are: "
newArrayElements: .asciiz "New array is: "
space: .asciiz " "
newline: .asciiz "\n"

.text
main:
    # Print "Array elements are: "
    li $v0, 4              # syscall code for print_string
    la $a0, arrayElements  # load address of the string
    syscall

    # Initialize array pointer and counter for printing
    la $s0, array          # $s0 points to array[0]
    li $t1, 0              # counter initialized to 0

printArrayLoop:
    beq $t1, 5, endPrintArray  # if counter == 5, jump to endPrintArray

    lw $t0, 0($s0)         # load word from array into $t0

    # Print the integer
    li $v0, 1             
    move $a0, $t0          # move the integer to $a0
    syscall

    # Print space
    li $v0, 4             
    la $a0, space
    syscall

    addi $s0, $s0, 4       # move to next array element
    addi $t1, $t1, 1       # increment counter

    j printArrayLoop       # jump back to start of loop

endPrintArray:
    # Print newline
    li $v0, 4             
    la $a0, newline        # load address of newline character
    syscall

pushElements:
    # Reset array pointer and counter for pushing onto stack
    la $s0, array          # $s0 points to array[0]
    li $t1, 0              # counter initialized to 0

pushLoop:
    beq $t1, 5, popElements  # if counter == 5, jump to popElements

    lw $t0, 0($s0)        

    addi $sp, $sp, -4      # decrement stack pointer by 4 bytes
    sw $t0, 0($sp)         # push $t0 onto the stack

    addi $s0, $s0, 4      
    addi $t1, $t1, 1       # increment counter

    j pushLoop             # jump back to start of loop

popElements:
    # Reset array pointer and counter for popping from stack
    la $s0, array         
    li $t1, 0             

popLoop:
    beq $t1, 5, printReversedArray  # if counter == 5, jump to printReversedArray

    lw $t0, 0($sp)         # load word from stack into $t0
    addi $sp, $sp, 4       # increment stack pointer by 4 bytes (pop)

    sw $t0, 0($s0)         # store $t0 back into the array

    addi $s0, $s0, 4       # move to next array element
    addi $t1, $t1, 1       # increment counter

    j popLoop              # jump back to start of loop

printReversedArray:
    # Print "New array is: "
    li $v0, 4             
    la $a0, newArrayElements
    syscall

    # Reset array pointer and counter for printing reversed array
    la $s0, array          # $s0 points to array[0]
    li $t1, 0              # counter initialized to 0

printNewArrayLoop:
    beq $t1, 5, exitProgram  # if counter == 5, exit program

    lw $t0, 0($s0)        

    # Print the integer
    li $v0, 1             
    move $a0, $t0          # move the integer to $a0
    syscall

    # Print space
    li $v0, 4             
    la $a0, space
    syscall

    addi $s0, $s0, 4       # move to next array element
    addi $t1, $t1, 1       # increment counter

    j printNewArrayLoop    # jump back to start of loop

exitProgram:
    exit                   # call macro to exit program
