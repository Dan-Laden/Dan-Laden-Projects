;Main.s by Daniel Laden
;9/5/18
;Simple program to toggle LED1 on MC9S08QG8

	INCLUDE 'derivative.inc'
	XDEF _Startup, main
	XREF __SEF_END_SSTACK
	
main:
_Startup: ;PRBDD setting the gates open to recieve output to
	BSET 6, PTBDD
	BSET 7, PTBDD
mainLoop: ;mainloop for the code
	BRA LED1
	
LED1: ;turns the 1st LED off
	BSET 6, PTBD
	
	BRA LED2
	
LED2: ;turns the 2nd LED off
	BSET 7, PTBD
	
	BRA clear
	
clear:  ;clears the signal keeping the LED off
	BCLR 6, PTBD
	BCLR 7, PTBD
	
	BRA XORToggle
	
XORToggle: ;Part 3 using the XOR gate to toggle the LEDs to flip

	LDA PTBD
	EOR #%11000000
	STA PTBD
	
	BRA mainLoop

