 ; Lab-4.asm
 ;  Created on: Sep 27, 2018
 ;     Author: Daniel Laden
	INCLUDE 'derivative.inc'
	XDEF _Startup, main
	XREF __SEF_END_SSTACK
	
LED1delay1 EQU $0100
LED1delay2 EQU $0101
LED2delay  EQU $0102


main:
_Startup:
	BSET 6, PTBDD
	BSET 7, PTBDD
	

mainLoop:
	MOV #$0, LED1delay1
	MOV #$0, LED1delay2
	MOV #$0, LED2delay
	LDA SOPT1
	AND #01111111
	STA SOPT1
	BRA	delayLED1

delayLED1:
	;turns the LED1 off after looping
	LDA LED1delay1
	ADC #1
	STA LED1delay1
	BCS LED1toggle
	LDA #0
	BRA wait1
	
delayLED2:
	;turns the LED2 off after looping
	LDA LED2delay
	ADC #1
	STA LED2delay
	BCS LED2toggle
	BRA delayLED1		

LED1toggle:
	;turns the LED1 off
	LDA PTBD
	EOR #%10000000
	STA PTBD

	LDA #0
	STA LED1delay1
	STA LED1delay2
	BRA delayLED2
	
LED2toggle:
	;turns the LED2 off
	LDA PTBD
	EOR #%01000000
	STA PTBD

	LDA #0
	STA LED2delay
	BRA delayLED1
	
wait1:
;inner loop for delay1
	LDA LED1delay2
	ADC #1
	STA LED1delay2
	BCS delayLED1
	LDA #0
	BRA wait2
	
wait2:
;inner inner loop for delay1
	ADC #125
	BCS wait1
	BRA wait2
	

