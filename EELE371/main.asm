;main.s by Brian Jore
;10/25/18
;Running a program on a real time clock using I2C bit banging.
;Setup the oscilloscope's MSO bus analysis.
	INCLUDE 'derivative.inc'
	XDEF _Startup, main
	XREF __SEG_END_SSTACK	;symbol defined by the linker fro the end of the stack
	
	;emulated I2C lines on PTBD pins.
SCL EQU 7				;Clock
SDA EQU 6				;Data
	
DACADDR EQU $2C
	
	ORG $0060
	
BitCounter DS.B 1
Value 	   DS.B 1
Direction  DS.B 1
	
	;Writing into ROM.
	ORG $E000
	
main:
_Startup:
	;Initialize variables.
	CLR	Value
	CLR BitCounter
	CLR Direction
	
	;Shooting the watchdog.
	LDA SOPT1
	AND #%01111111
	STA SOPT1
	
	;Setup parallel ports.
	BSET 6, PTBD
	BSET 7, PTBD
	
	BSET 6, PTBDD
	BSET 7, PTBDD
	
;code added for this lab begins here.
mainLoop:
	;Start condition.
	JSR I2CStartBit
	
	LDA #1101000		;Slave device with a write.
	ASLA				;Needed to align address
	JSR I2CTxByte		;Sending the eight bits.
	
	JSR I2CRStartBit
	
	LDA #1101001		;Slave device with a read.
	ASLA
	JSR I2CRxByte		;Resending the eight bits.
	
sendValue:
	;sending data.
	LDA Value			
	JSR I2CTxByte		;Sending the eight bits
	INC Value
	LDA Value
	CMP #$0A
	BNE sendValue
	
	CLR Value
	
	;Stop condition
	JSR I2CStopBit
	
	JSR I2CBitDelay
	BRA mainLoop
	
resendValue:
	LDA Value
	JSR I2CRxByte
	INC Value
	LDA Value
	CMP #$0A
	BNE resendValue
	
	CLR Value
	
	JSR I2CRStopBit
	JSR I2CBitDelay
	BRA mainLoop

I2CTxByte:
	;Initialize variable
	LDX #$08
	STX BitCounter
	
I2CRxByte:
	LDX #$08
	STX BitCounter
	
I2CNextBit:
	ROLA
	BCC SendLow
	
I2CRNextBit:
	ROLA
	BCC ReadLow
	
SendHigh:
	BSET SDA, PTBD
	JSR I2CSetupDelay
	
ReadHigh:
	JSR I2CSetupDelay
	
setup:
	BSET SCL, PTBD
	JSR I2CBitDelay
	BRA I2CTxCont
	
readsetup:
	BSET SCL, PTBD
	JSR I2CBitDelay
	BRA I2CRxCont
	
SendLow:
	BCLR SDA, PTBD
	JSR I2CSetupDelay
	BSET SCL, PTBD
	JSR I2CBitDelay
	
ReadLow:
	JSR I2CSetupDelay
	BSET SCL, PTBD
	JSR I2CBitDelay
	
I2CTxCont:
	BCLR SCL, PTBD
	DEC BitCounter
	BEQ I2CAckPoll
	BRA I2CNextBit
	
I2CAckPoll:
	JSR I2CSetupDelay
	BSET SCL, PTBD
	JSR I2CBitDelay
	BRSET SDA, PTBD, I2CNoAck
	
	BCLR SCL, PTBD
	BSET SDA, PTBDD
	RTS
	
I2CRAckPoll:
	JSR I2CSetupDelay
	BSET SCL, PTBD
	JSR I2CBitDelay
	
	BCLR SCL, PTBD
	RTS
	
I2CNoAck:
	BCLR SCL, PTBD
	BSET SDA, PTBDD
	RTS
	
I2CRNoAck:
	BCLR SCL, PTBD
	RTS
	
I2CStartBit:
	BCLR SDA, PTBD
	JSR I2CBitDelay
	BCLR SCL, PTBD
	RTS
	
I2CRStartBit:
	JSR I2CBitDelay
	BCLR SCL, PTBD
	RTS
	
I2CStopBit:
	BCLR SDA, PTBD
	BSET SCL, PTBD
	BSET SDA, PTBD
	JSR I2CBitDelay
	RTS
	
I2CRStopBit:
	BSET SCL, PTBD
	JSR I2CBitDelay
	RTS
	
I2CSetupDelay:
	NOP
	NOP
	RTS
	
I2CBitDelay:
	NOP	
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	RTS
	

	
