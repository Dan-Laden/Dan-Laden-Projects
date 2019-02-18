;main.s by Daniel Laden
;11/8/18
;Running a program on a real time clock using I2C bit banging.
;Setup the oscilloscope's MSO bus analysis.
	INCLUDE 'derivative.inc'
	XDEF _Startup, main, _InKeyboard
	XREF __SEG_END_SSTACK	;symbol defined by the linker fro the end of the stack
	
	ORG $0060
	
LEDdelay1 DS.B 1
LEDdelay2 DS.B 1
keypress DS.B 1


main:
_Startup:
	;Clearing variables
	CLR	LEDdelay1 
	CLR	LEDdelay2
	CLR keypress
	;Setup parallel ports
	BSET 6, PTBDD
	BSET 7, PTBDD
	BCLR 2, PTADD
	BCLR 3, PTADD
	;Of Mice and Men'ing the Watchdog
	LDA SOPT1
	AND #%01111111
	STA SOPT1
	;LEDs are initialized off
	BSET 6, PTBD
	BSET 7, PTBD
	;Falling edge set
	BCLR 2, KBIES
	BCLR 3, KBIES
	;Enable Interrup Pins
	BSET 2, KBIPE
	BSET 3, KBIPE
	;Disable PTAP
	LDA PTAPE
	AND #%11110011
	STA PTAPE
	;Enable keyboard interupt
	BSET 1, KBISC
	;Enable interupt
	CLI


keyTrigger:
	LDA keypress
	BRCLR 2, keypress, slowLED
	BRCLR 3, keypress, fastLED
	BRA keyTrigger

slowLED:
	LDA LEDdelay1
	ADC #1
	STA LEDdelay1
	BCS LEDSlowtoggle
	LDA #0
	BRA waitSlow

LEDSlowtoggle:
	;turns the LED1 off
	LDA PTBD
	EOR #%10000000
	STA PTBD

	LDA #0
	STA LEDdelay1
	STA LEDdelay2
	BRA slowLED
	
waitSlow:
	BRCLR 3, keypress, keyTrigger
	;inner loop for slow LED
	LDA LEDdelay2
	ADC #1
	STA LEDdelay2
	BCS slowLED
	BRA waitSlow
	
fastLED:
	LDA LEDdelay1
	ADC #1
	STA LEDdelay1
	BCS LEDFasttoggle
	LDA #0
	BRA waitFast
	
LEDFasttoggle:
	;turns the LED1 off
	LDA PTBD
	EOR #%10000000
	STA PTBD

	LDA #0
	STA LEDdelay1
	STA LEDdelay2
	BRA fastLED
	
waitFast:
	BRCLR 2, keypress, keyTrigger
	;inner loop for slow LED
	LDA LEDdelay2
	ADC #5
	STA LEDdelay2
	BCS fastLED
	BRA waitFast

_InKeyboard:
	;Putting PTAD in keypress
	LDA PTAD
	STA keypress
	BSET 2, KBISC
	RTI
