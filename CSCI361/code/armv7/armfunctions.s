printlp: /*print loop function r10 is how many loops*/
  mov r0, #1
  mov r7, #4
  swi 0
  sub r10, r10, #1
  cmp r10, #0
  bne printlp
  bx lr

printf: /*print function*/
  mov r0, #1
  mov r7, #4
  swi 0
  bx lr

intStr: /*makes an int a String*/
  add r8, r8, #48
  ldr r9, =string
  str r8, [r9]
  mov r2, #1
  bx lr

strInt: /*makes a String an int*/
  sub r8, r8, #48
  bx lr

arrFind: /*program part 2*/
  push {lr}

  mov r2, #23
  ldr r1, =usrIn
  bl printf
  bl scanf
  mov r8, r1
  bl intStr
  /*r8 is holding the userinput*/

  ldr r5, =srtArrLength
  ldr r3,  =srtArr
  mov r4, #0
  mov r11, pc

  cmp r4, r5
  bgt exitArrF

  ldr r6, [r3], #4
  cmp r6, r8
  beq exitArrS

  add r4, r4, #1
  b recall

exitArrF:/*Failure*/
  mov r2, #7
  ldr r1, =fail
  bl printf
  bl printf
  pop {lr}
  bx lr

exitArrS:/*Success*/
  mov r2, #17
  ldr r1, =succ
  bl printf
  pop {lr}
  bx lr


scanf:/*scan in a user's input*/
  mov r0, #1
  mov r7, #3
  ldr r1, =scanStr
  swi 0
  bx lr

recall:/*puts the program counter to a previous state store pc in r11 before use*/
  mov pc, r11

exit:/*exit the program*/
  mov r7, #1
  swi 0
