;main.s by Daniel Laden
;11/28/18
;Running a program on a real time clock using I2C bit banging.
;Setup the oscilloscope's MSO bus analysis.
	INCLUDE 'derivative.inc'
	XDEF _Startup, main
	XREF __SEG_END_SSTACK	;symbol defined by the linker fro the end of the stack
	
	ORG $0060
	
MODH DS.B 1
MODL DS.B 1

	ORG $E000

main:
_Startup:
	;Clearing variables
	CLR MODH
	CLR MODL
	;Of Mice and Men'ing the Watchdog
	LDA SOPT1
	AND #%01111111
	STA SOPT1
	;Setup parallel ports
	BSET 6, PTBDD
	BSET 7, PTBDD
	BCLR 2, PTADD
	BCLR 3, PTADD
	;LEDs are initialized off
	BSET 6, PTBD
	BSET 7, PTBD
	;Clock source and prescaler
	MOV #$0A, TPMSC
	;PWM functionality for each channel that will be used to generate PMW
	MOV #$28, TPMC0SC
	;Setting up the period
	MOV #$4E, TPMMODH
	MOV #$20, TPMMODL
	
	;Setting ADCCFG to 8-bit
	LDA #$0
	STA ADCCFG
	;Setting ADCSC1 and ADCSC2
	LDA #$1
	STA ADCSC1
	MOV #$00, ADCSC2
	
	
mainLoop:
	LDA #$1
	STA ADCSC1
	JSR pulse
	BRCLR 7, ADCSC1, readADCRHL ;is COCO=1? if so read ADCRH and ADCRL
	
readADCRHL:
	LDA ADCRH
	LDA ADCRL ;X
	
	
	;x factor
	LDX #5; X x M
	MUL ;M
	
	;X:A
	STA MODL 
	STX MODH
	
	LDHX MODH ;A
	
	;768 = b
	AIX #127
	AIX #127
	AIX #127
	AIX #127
	AIX #127
	AIX #127
	AIX #6; + b
	
	STHX TPMC0V ; = y
	
	
	
	LDA MODH
	CMP #$08
	BGE setLED
	
	LDA MODH
	CMP #$03
	BLE setLED
	
	BSET 7, PTBD
	
	BRA mainLoop
	
pulse:
	MOV ADCRH, MODH
	MOV ADCRL, MODL
	
	RTS

setLED:
	;turns the LED1 on
	BCLR 7, PTBD
	BRA mainLoop
