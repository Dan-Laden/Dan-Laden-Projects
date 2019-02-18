.data
      string: .string "The result is: %d\n"
      stringb: .string "%d is Prime\n"
      test: .string "Test: %d\n"
      numbera: .int 10
      numberb: .int 6
.text
      .balign 4
      .global main
main:
          mov x19, x30
          //ldr x20, =numbera
          //ldr x21, =numberb
          //ldr x20, [x20]
          //ldr x21, [x21]
          mov x2, #63697
          mov x3, #1
          mov x1, #-1


          bl isPrime
isPrime:
          add x3, x3, #1

          cmp x1, #-1
          bne exit //NOT prime

          cmp x3, x2
          beq exitS //IS prime

          b checkRem//not sure yet


// checks x2/x3 if it's xithout a remainder by taking x1 * x3=x4 and cmping it to x2
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
//exit exits the program
exit:
          ldr x0, =string
          bl printf

          mov x30, x19
          ret
//holder for menu
exitS:
          mov x1, x2
          ldr x0, =stringb
          bl printf

          mov x30, x19
          ret
