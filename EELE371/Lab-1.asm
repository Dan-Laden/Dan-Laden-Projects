;Main.s by Daniel Laden
;9/5/18
;Simple program to toggle LED1 on MC9S08QG8

	INCLUDE 'derivative.inc'
	XDEF _Startup, main
	XREF __SEF_END_SSTACK
	
main:
_Startup:
	BSET 6, PTBDD
	BSET 7, PTBDD
mainLoop:	
	BRA LED1
	
LED1:
	BSET 6, PTBD
	
	BRA LED2
	
LED2:
	BSET 7, PTBD
	
	BRA clear
	
clear:
	BCLR 6, PTBD
	BCLR 7, PTBD
	
	BRA mainLoop

