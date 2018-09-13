 ; lab-2.asm
 ;  Created on: Sep 13, 2018
 ;     Author: Daniel Laden
 
	INCLUDE 'derivative.inc'
	XDEF _Startup, main
	XREF __SEF_END_SSTACK
	
main:

_Startup:
	BSET 6, PTBDD
	BSET 7, PTBDD
	LDA #0
	STA $73


mainLoop:
	BRA delay

delay:
;turns the LEDs off after looping
	LDA $73
	ADC #1
	STA $73
	BCS LEDtoggle
	LDA #0
	BRA wait	

LEDtoggle:
	;turns the LEDs off
	LDA PTBD
	EOR #%11000000
	STA PTBD

	LDA #0
	STA $73
	BRA delay
	
wait:
;inner loop for delay1
	ADC #1
	BCS delay
	BRA wait



