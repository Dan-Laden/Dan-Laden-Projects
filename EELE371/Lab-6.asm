; Lab-5.asm
 ;  Created on: Oct 4, 2018
 ;     Author: Daniel Laden
	INCLUDE 'derivative.inc'
	XDEF _Startup, main
	XREF __SEF_END_SSTACK
	
SCL EQU 7
SDA EQU 6
	
DACADDR EQU $2C
	
	ORG 	$0060 

BitCounter DS.B 1
Value	   DS.B 1
Direction  DS.B 1
	
	
;Start of Program Code
	ORG 	$E000 

main:
_Startup:
	;Initialize variables
	CLR		Value
	CLR		BitCounter
	CLR		Direction
	;Of Mice and Men'ing the Watchdog
	LDA		SOPT1
	AND		#%01111111
	STA		SOPT1
	;Setup parallel ports
	BSET 6, PTBD
	BSET 7, PTBD
	BSET 6, PTBDD
	BSET 7, PTBDD
	
	
mainLoop:
	;Start condition
	JSR I2CStartBit
	
	LDA #DACADDR
	ASLA
	JSR	I2CTxByte
	
	;Stop condition
	JSR I2CStopBit
	
	JSR I2CBitDelay
	BRA mainLoop
	
I2CTxByte:
	;Initialize variable
	LDX		#$08
	STX		BitCounter
	
I2CNextBit:
	ROLA
	BCC	SendLow

SendHigh:
	BSET	SDA, PTBD
	JSR	I2CSetupDelay
	
setup:
	BSET	SCL, PTBD
	JSR	I2CBitDelay
	BRA	I2CTxCont
	
SendLow:
	BCLR	SDA, PTBD
	JSR	I2CSetupDelay
	BSET	SCL, PTBD
	JSR I2CBitDelay

I2CTxCont:
	BCLR	SCL, PTBD
	DEC		BitCounter
	BEQ	12CAckPoll
	BRA I2CNextBit

I2CAckPoll:
	BSET	SDA, PTBD
	BCLR	SDA, PTBDD
	JSR	I2CSetupDelay
	BSET	SCL, PTBD
	JSR	I2CBitDelay
	BRSET	SDA, PTBD, I2CNoAck
	
	BCLR	SCL, PTBD
	BSET	SDA, PTBDD
	RTS
	
I2CNoAck:
	BCLR	SCL, PTBD
	BSET	SDA, PTBDD
	RTS
	
I2CStartBit:
	BCLR	SDA, PTBD
	JSR	I2CBitDelay
	BCLR	SCL, PTBD
	RTS
	
I2CStopBit:
	BCLR	SDA, PTBD
	BSET	SCL, PTBD
	BSET	SDA, PTBD
	JSR	I2CBitDelay
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
	RTS
	


