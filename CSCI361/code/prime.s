.data
test_prime: .int 13

format: .asciz "%i\n"

is_prime: .asciz "%i is prime.\n"
is_not_prime: .asciz "%i is not prime.\n"

.text
.global main
main:
    STR X30, [SP, #-16]!

    LDR X1, =test_prime
    LDR X1, [X1]
    LDR X0, =format
    BL printf

check_prime_init:
    LDR X1, =test_prime
    LDR X1, [X1]

    MOV X0, #2

    CMP W0, W1
    BHI not_prime

    CMP W0, W1
    BEQ prime

    B loop_cond

loop_cond:
    CMP W0, W1
    BEQ prime

loop_body:
    UDIV X2, X1, X0
    MUL X2, X2, X0
    SUB X2, X1, X2
    CMP X2, #0
    BEQ not_prime
    ADD X0, X0, #1
    B loop_cond

not_prime:
    LDR X1, =test_prime
    LDR X1, [X1]
    LDR X0, =is_not_prime
    BL printf
    B exit

prime:
    LDR X1, =test_prime
    LDR X1, [X1]
    LDR X0, =is_prime
    BL printf
    B exit

exit:
    LDR X30, [SP], #16
    MOV X0, #0
    RET
