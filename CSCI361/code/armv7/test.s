.data
.balign 4
stringa: .ascii "Hates World\n"
stringaa: .ascii "Gates World\n"
stringaaa: .ascii "Nates World\n"

stringc: .ascii "Same"
stringd: .ascii "Same"
stringe: .ascii "same"
stringee: .ascii "Some"

.text
.global _start
_start:
  ldr r1, =stringb
  ldr r2, len_of_string
  bl printf
  /*If you do not clear this shit goes crazy*/
  mov r1, #0
  ldr r1, =stringa
  bl printf
  ldr r1, =stringb
  bl printf
  mov r1, #0
  ldr r1, =stringa
  bl printf
  ldr r1, =stringb
  bl printf
  ldr r1, =stringb
  bl printf
  ldr r1, =stringb
  bl printf



  /*
  So fun fact I got from this program using .data
  you need to clear the register before you can call it
  again while having it below it can be called over and over
  without any errors it seems
  */

  mov r1, #0
  ldr r1, =stringaa

  ldr r4, =a
  ldr r4, [r4]
  ldr r5, =b
  ldr r5, [r5]
  cmp r4, r5
  bleq printf

  /*
  More fun facts with me so fi you just have the two ldr without the reassignment
  like this then the cmp statement compairs their memory addresses instead of what's
  being held in memory why god do you ask? I don't fucking know
  */

  mov r1, #0
  ldr r1, =stringaaa

  ldr r4, =stringc
  ldr r4, [r4]
  ldr r5, =stringd
  ldr r5, [r5]
  cmp r4, r5
  bleq printf

  ldr r6, =stringe
  ldr r6, [r6]
  cmp r4, r6
  bleq printf
  cmp r5, r6
  bleq printf

  mov r6, #0
  ldr r6, =stringee
  ldr r6, [r6]
  cmp r4, r6
  bleq printf

  /*
  So from this you can get straight string compairs amazingly
  */


  b exit

printf: /*print function*/
  mov r0, #1
  mov r7, #4
  swi 0
  bx lr


exit:/*exit the program*/
  mov r7, #1
  swi 0

/*Inside variables*/
len_of_string: .word 12
stringb: .ascii "Hello World\n"
a: .word 5
b: .word 5
