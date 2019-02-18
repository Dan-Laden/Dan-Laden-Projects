.data
      string: .string "Hello World\n"
.text
      .balign 4
      .global main
main:
          mov x20, x30
          ldr x0, =string
          bl printf
          mov x30, x20
          ret //return
