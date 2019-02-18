;main.s by Daniel Laden
;11/29/18
;Running a program on a real time clock using I2C bit banging.
;Setup the oscilloscope's MSO bus analysis.
	INCLUDE 'derivative.inc'
	XDEF _Startup, main, _InKeyboard
	XREF __SEG_END_SSTACK	;symbol defined by the linker fro the end of the stack
	
	ORG $0060
	
keypress DS.B 1

MODH DS.B 1
MODL DS.B 1


main:
_Startup:
	;Clearing variables
	CLR MODH
	CLR MODL
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
	;Disable PTAP
	LDA PTAPE
	AND #%11110011
	STA PTAPE
	;Falling edge set
	BCLR 2, KBIES
	BCLR 3, KBIES
	;Enable Interrup Pins
	BSET 2, KBIPE
	BSET 3, KBIPE
	;Enable keyboard interupt
	BSET 1, KBISC
	;Enable interupt
	CLI

	;Setting default servo value
	LDA #$05
	STA MODH
	LDA #$DC
	STA MODL
	
	
	
	;Clock source and prescaler
	MOV #$0A, TPMSC
	;PWM functionality for each channel that will be used to generate PMW
	MOV #$28, TPMC0SC
	;Setting up the period
	MOV #$4E, TPMMODH
	MOV #$20, TPMMODL
	
	
mainLoop:
	JSR pulse
	LDX #100
	LDA keypress
	CMP #$00
	BEQ mainLoop
	LDA keypress
	BRSET 2, keypress, inc
	BRSET 3, keypress, dec

	
pulse:
	MOV MODH, TPMC0VH
	MOV MODL, TPMC0VL
	RTS


LEDtoggle:
	;turns the LED1 on
	BCLR 7, PTBD
	BRA mainLoop
	
dec:
	BSET 7, PTBD
	CLR keypress
	
decServo:
	CPX #$00
	BEQ mainLoop
	DECX
	LDA MODH
	CMP #$02
	BLE decServoFix
	LDA MODL
	CMP #$00
	BEQ decServoH
	LDA MODL
	DECA
	STA MODL
	BRA decServo
	
decServoH:
	DECX
	LDA MODH
	DECA
	STA MODH
	LDA #$FF
	STA MODL
	BRA decServo
	
decServoFix:
	LDA #$03
	STA MODH
	LDA #$20
	STA MODL
	BRA LEDtoggle
	
inc:
	BSET 7, PTBD
	CLR keypress
	
incServo:
	CPX #$00
	BEQ mainLoop
	DECX
	LDA MODH
	CMP #$09
	BGE incServoFix
	LDA MODL
	CMP #$FF
	BEQ incServoH
	LDA MODL
	INCA
	STA MODL
	BRA incServo
	
incServoH:
	DECX
	LDA MODH
	INCA
	STA MODH
	LDA #$00
	STA MODL
	BRA incServo
	
incServoFix:
	LDA #$08
	STA MODH
	LDA #$98
	STA MODL
	BRA LEDtoggle

_InKeyboard:
	;Putting PTAD in keypress
	LDA PTAD
	STA keypress
	BSET 2, KBISC
	RTI
