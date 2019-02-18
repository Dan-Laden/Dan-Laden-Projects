.data
scanStr: .ascii " "
string: .ascii " "
/*Register Guide
* r0: Free
* r1: used for Strings
* r2: used for the length of Strings
* r3-12: Free
*/
.text
.global _start
_start:
  ldr r2, =usrIn_len
  ldr r2, [r2]
  ldr r1, =usrIn
  bl printf
  bl scanf
  ldr r8, [r1]
  ldr r4, =number
  ldr r4, [r4]
  add r4, r4, #48
  cmp r4, r8
  beq exitArrS
  /*r8 is holding the userinput*/

  b exit

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


  b exit

/*Constants*/

srtArr: .word 2, 4, 8, 10, 15, 21, 23
srtArrLength: .word 7
sum: .word 0
num: .word 0
number: .word 5
fail: .ascii "Failure\n"
succ: .ascii "Value was found!\n"
usrIn: .ascii "Please input a value: "
usrIn_len: .word 22
new: .ascii "\n"

/*Functional Branches*/

  printf: /*print function*/
    mov r0, #1
    mov r7, #4
    swi 0
    bx lr

  strInt: /*makes a String an int*/
    sub r8, r8, #48
    bx lr

  intStr: /*makes an int a String*/
    add r8, r8, #48
    ldr r9, =string
    str r8, [r9]
    mov r2, #1
    bx lr

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
    mov r1, #0
    ldr r1, =scanStr
    swi 0
    bx lr

  recall:/*puts the program counter to a previous state store pc in r11 before use*/
    mov pc, r11

  exit:/*exit the program*/
    mov r7, #1
    swi 0
