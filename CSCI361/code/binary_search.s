// binary_search.s
.data
.balign 8
input_prompt: .asciz "Enter a number: "

.balign 8
format: .asciz "%i"

.balign 8
success_prompt: .asciz "Found %i\n"

.balign 8
failure_prompt: .asciz "Could not find %i\n"

.balign 4
array: .int 0, 4, 5, 9, 10

.balign 8
array_length: .word 4

.balign 8
search_target: .word 0

.text

.global main
main:
    STR X30, [sp, #16]! // push return address to stack

    LDR X0, =input_prompt
    BL printf

    LDR X0, =format
    LDR X1, =search_target
    BL scanf

    MOV X0, #0 // index of first element
    LDR X1, =array_length 
    LDR X1, [X1] // index of last element

    _bsearch_cond:
        CMP X0, X1
        BEQ _bsearch_end

    _bsearch:
        SUB X2, X1, X0
        LSR X2, X2, #1

        ADD X3, X0, X2

        LDR X4, =array
        MOV X2, #4
        MUL X2, X2, X3 
        ADD X4, X4, X2
        LDR X4, [X4]

        LDR X5, =search_target
        LDR X5, [X5]

        CMP W4, W5
        BEQ _bsearch_success
        BLO _bsearch_low // branch right
        BHI _bsearch_high // branch left
        B _bsearch_cond

    _bsearch_low: // branch right
        ADD X3, X3, #1
        MOV X0, X3
        B _bsearch_cond

    _bsearch_high: // branch left
        MOV X1, X3
        B _bsearch_cond

    _bsearch_end:
        LDR X1, =array
        MOV X2, #4
        MUL X2, X0, X2
        ADD X1, X1, X2
        LDR X1, [X1]

        LDR X0, =search_target
        LDR X0, [X0]

        CMP W0, W1
        BEQ _bsearch_success
        B _bsearch_failure

    _bsearch_success:
        LDR X0, =success_prompt
        LDR X1, =search_target
        LDR X1, [X1]
        BL printf
        B end

    _bsearch_failure:
        LDR X0, =failure_prompt
        LDR X1, =search_target
        LDR X1, [X1]
        BL printf
        B end

end:
    // return 0;
    LDR X30, [sp], #16 // pop return address from stack
    MOV X0, #0
    RET
