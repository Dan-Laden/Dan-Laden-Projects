;main.s by Daniel Laden
;11/28/18
;Running a program on a real time clock using I2C bit banging.
;Setup the oscilloscope's MSO bus analysis.
	INCLUDE 'derivative.inc'
	XDEF _Startup, main
	XREF __SEG_END_SSTACK	;symbol defined by the linker fro the end of the stack

main:
_Startup:
	;Of Mice and Men'ing the Watchdog
	LDA SOPT1
	AND #%01111111
	STA SOPT1
	
	;Clock source and prescaler
	MOV #$0A, TPMSC
	;PWM functionality for each channel that will be used to generate PMW
	MOV #$28, TPMC0SC
	;Setting up the period
	MOV #$4E, TPMMODH
	MOV #$20, TPMMODL
	
	
	
mainLoop:
	JSR maxPulse
	;MOV #$00, TPMC0VH
	;MOV #$00, TPMC0VL
	BRA mainLoop
	
minPulse:
	MOV #$03, TPMC0VH
	MOV #$E8, TPMC0VL
	RTS

neuPulse:
	MOV #$05, TPMC0VH
	MOV #$DC, TPMC0VL
	RTS
	
maxPulse:
	MOV #$07, TPMC0VH
	MOV #$D0, TPMC0VL
	RTS
