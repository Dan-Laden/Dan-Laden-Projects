.data

.balign 8
menu_prompt: .asciz "Pick an option:\n  1 - Test if prime\n  2 - Test for twin primes\n  3 - Quit\n:$ "

.balign 8
input_prompt: .asciz "Enter a number: "

.balign 8
input_format: .asciz "%i"

.balign 8
menu_select: .word 0

.text

.global main

main:
    B menu 

main_menu:  
    LDR X0, =menu_prompt
    BL printf

    LDR X0, =input_format
    LDR X1, =menu_select
    BL scanf

    LDR X0, =menu_select
    LDR X0, [X0]
    MOV X1, #1

    CMP X0, X1
    BEQ prime_menu

    MOV X1, #2

    CMP X0, X1
    BEQ twin_prime_menu

    MOV X1, #3
    BEQ end

    B main_menu

prime_menu:
    LDR X0, =input_prompt
    BL printf

    LDR X0, =input_format
    LDR X1, =prime1 // no existent memory location
    BL scanf

    B prime

twin_prime_menu:
    LDR X0, =input_prompt
    BL printf

    LDR X0, =input_format
    LDR X1, =prime1 // no existent memory location
    BL scanf

    LDR X0, =input_prompt
    BL printf

    LDR X0, =input_format
    LDR X1, =prime2 // no existent memory location
    BL scanf

    B twin