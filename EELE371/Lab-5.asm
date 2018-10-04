 ; Lab-5.asm
 ;  Created on: Oct 4, 2018
 ;     Author: Daniel Laden
	INCLUDE 'derivative.inc'
	XDEF _Startup, main
	XREF __SEF_END_SSTACK
	
	ORG $0060

DATA1 DC.B 5
DATA2 DC.B 2


BUFFER1 DS.B 16
BUFFER2 DS.B 16
BUFFER3 DS.B 16
BUFFER4 DS.B 16

	ORG $E000

WORD1 DC.W 'Hello World'
ENDOF DS.B 16


main:
_Startup:
	
mainLoop:
	LDHX #$0000
	BRA mainPart2

mainPart1:

	LDX DATA1
	LDA DATA2
	MUL
	STA BUFFER1
	
	LDX BUFFER1
	LDA DATA2
	MUL
	STA BUFFER2
	
	LDA BUFFER1
	EOR BUFFER2
	STA BUFFER3

	BRA mainPart1
	
mainPart2:
	CLRH
	
	LDA WORD1, X
	;Load Word
	STA BUFFER1, X
	
	INCX
	CPX #12
	BEQ mainLoop
	BRA mainPart2

