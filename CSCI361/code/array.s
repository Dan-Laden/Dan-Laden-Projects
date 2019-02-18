.data // Begin data
.balign 8
prompt: .string "%d\n"

.balign 4
element_size: .word 4 // the size of an element in this "array"

.balign 4 // here .balign declares the size of the values being stored in the "array"
array: .word 0, 1, 2 // an "array" of integers

.balign 8 // the length of our "array" in bytes (# of elements * element_size)
array_length: .word 12

.text // Being program

.globl main

main:
    STR X30, [sp, #-16]! // push our current return address to the stack

    MOV X0, #0 // move the value 0 to X0
    STR X0, [sp, #-16]! // push the value in X0 to the stack

    loop:
        // print
        LDR X0, =prompt
        LDR X1, =array
        LDR X2, [sp]
        ADD X1, X1, X2
        LDR X1, [X1]
        BL printf

        // increment array index
        LDR X0, [sp]
        LDR X1, =element_size
        LDR X1, [X1]
        ADD X0, X0, X1
        STR X0, [sp]

    loop_condition:
        LDR X0, [sp]
        LDR X1, =array_length
        LDR X1, [X1]
        CMP X0, X1
        BLO loop

    loop_end:
        LDR X0, [sp], #16 // pop our variable off the stack

    // exit
    LDR X30, [sp], #16 // pop the stored return address off the stack
    MOV X0, #0 // return with normal exit status
    RET
