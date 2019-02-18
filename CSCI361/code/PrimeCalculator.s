.data
//DL My fun variables
      string: .string "The result is: %d\n"
      TruePrime: .string "\n%d is Prime\n\n"
      FalsePrime: .string "\n%d is not Prime\n\n"
      TrueTwin: .string "\n%d and %d are Twin Primes\n\n"
      FalseTwin: .string "\n%d and %d are not Twin Primes\n\n"
      primeA: .word 0
      primeB: .word 0

//JOJO's fun variables
      .balign 8
      menu_prompt: .asciz "Pick an option:\n  1 - Test if prime\n  2 - Test for twin primes\n  3 - Quit\n:$ "

      .balign 8
      input_prompt: .asciz "Enter a number: "

      .balign 8
      input_format: .asciz "%i"

      .balign 8
      menu_select: .word 0

.text
      .balign 4
      .global main
main:
          STR X30, [SP, #-16]!
          b main_menu
//This is the loopable menu of the program
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

          cmp x0, x1
          BEQ exit

          B main_menu

//This is for branching into the isPrime function
prime_menu:
          mov x25, #1
          LDR X0, =input_prompt
          BL printf

          LDR X0, =input_format
          LDR X1, =primeA
          BL scanf
          ldr x1, =primeA
          ldr x1, [x1]

          mov x2, x1
          mov x1, #-1
          mov x3, #1

          B isPrime

//checks if a number x2 for primality
isPrime:
          add x3, x3, #1

          cmp x1, #-1
          bne primeF //NOT prime

          cmp x3, x2
          beq primeT //IS prime

          adds x0, x2, #-2
          bls primeF //1 is not a prime and all the negatives

          b checkRem//not sure yet


// checks x2/x3 if it's without a remainder by taking x1 * x3=x4 and cmping it to x2
checkRem:
          sdiv x1, x2, x3
          mul x4, x1, x3
          cmp x4, x2
          bne remainder
          b isPrime

//A remainder was found so the x1 register is being set to a negative 1
remainder:
          mov x1, #-1
          b isPrime

//X2 is a prime number
primeT:
          mov x27, #1
          ldr x0, =TruePrime
          mov x1, x2
          bl printf

          subs x0, x25, #2
          beq retTwin

          b clearAll

//X2 is not a prime number
primeF:
          mov x27, #-1
          ldr x0, =FalsePrime
          mov x1, x2
          bl printf

          b clearAll


//This will double branch into isPrime and then test for twin primeness
twin_prime_menu:
          mov x25, #2 //to know when we're in the TwinPrimeMenu
          LDR X0, =input_prompt
          BL printf

          LDR X0, =input_format
          LDR X1, =primeA
          BL scanf
          ldr x1, =primeA
          ldr x1, [x1]
          mov x22, x1

          LDR X0, =input_prompt
          BL printf

          LDR X0, =input_format
          LDR X1, =primeB
          BL scanf
          ldr x1, =primeB
          ldr x1, [x1]
          mov x23, x1

          B twin1

//Tests if a and b are twin primes by testing them for primality then testing for twin primeness a = x22 b = x23
twin1:
          mov x26, #1
          mov x2, x22
          mov x1, #-1
          mov x3, #1

          bl isPrime

//Second part for twin
twin2:
          add x26, x26, #1
          cmp x27, #-1
          beq main_menu //Number 1 isn't prime

          mov x2, x23
          mov x1, #-1
          mov x3, #1


          bl isPrime

//Third part for twin
twin3:
          cmp x27, #-1
          beq main_menu //Number 2 isn't prime

          //both are prime at this point
          add x1, x22, #2
          cmp x1, x23
          beq TwinT

          add x1, x23, #2
          cmp x1, x22
          beq TwinT

          b TwinF

//a and b are Twins
TwinT:
          ldr x0, =TrueTwin
          mov x1, x22
          mov x2, x23
          bl printf

          b clearAll

//a and b are not Twins
TwinF:
          ldr x0, =FalseTwin
          mov x1, x22
          mov x2, x23
          bl printf

          b clearAll
//returns the program to the twin function
retTwin:
          adds x0, x26, #-1
          beq twin2
          b twin3

//Garbage cleanup
clearAll:
          mov x0, #0
          mov x1, #0
          mov x2, #0
          mov x3, #0
          mov x4, #0
          mov x22, #0
          mov x23, #0
          mov x25, #0
          mov x26, #0
          mov x27, #0

          b main_menu

//exit exits the program
exit:
          LDR X30, [SP], #16
          mov X0, #0
          ret
