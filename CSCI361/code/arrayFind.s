.data
      stringa: .string "Please input your number: "
      stringb: .asciz "The number is: %d\n"
      stringFail: .asciz "Your number %d was not found\n"
      stringSucc: .asciz "%d was found!\n"
      stringtesta: .string "Hi\n"
      stringtestb: .string "Ja\n"
      stringtestc: .string "Ji\n"
      newLine: .string "\n"
      format: .asciz "%d"
      storage: .space 100
      .balign 4
      array: .int 2, 5, 7, 9, 11, 14, 17
      array_Len: .int 7
.text
      .balign 4
      .globl printf
      .globl scanf
      .global main
main:
          str x30, [sp, #-16]! //push x30
          ldr x0, =stringa
          bl printf


          ldr x0, addr_format
          ldr x1, addr_storage
          bl scanf
          ldr x1, addr_storage
          ldr x1, [x1]
          mov x20, x1

          ldr x22, =array_Len
          ldr x22, [x22]
          sub x22, x22, #1
          ldr x21, =array
          ldr x0, =stringb
          loop:
                mov x24, x30
                cmp x22, #0
                beq end
                sub x22, x22, #1
                ldr x23, [x21], #4
                LDR X0, =stringb
                mov x1, x23
                bl printf
                sub x1, x23, x20
                LDR X0, =stringb
                bl printf
                mov x30, x24
                cmp x23, x20
                beq succ
                b loop

end:
          mov x20, x1
          ldr x0, =stringFail
          bl printf
          b exit
succ:
          mov x20, x1
          ldr x0, =stringSucc
          bl printf

exit:
          ldr x30, [sp], #16 //pop x30
          ret

addr_format: .dword format
addr_storage: .dword storage
