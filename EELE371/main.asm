 ; lab-2.asm
 ;  Created on: Sep 13, 2018
 ;     Author: Daniel Laden
	INCLUDE 'derivative.inc'
	XDEF _Startup, main
	XREF __SEF_END_SSTACK
	
TEMP EQU $0075 ;Address of start location of RAM
INDEX EQU $0076


main:
_Startup:

mainPart2:
	MOV #$01, TEMP
	LDHX #$0000
	STHX $60
	
	BRA mainPart3b
	
mainPart3a:
	CLRH
	LDX #$60
	MOV #$01, TEMP
	BRA mainPart3aloop
	
mainPart3aloop:
	INC TEMP
	MOV TEMP, X+
	LDA TEMP
	SUB #$08
	BEQ mainPart3a
	BRA mainPart3aloop
	
mainPart3b:
	CLRH
	LDX #$60
	MOV #$01, TEMP
	MOV #$08, INDEX
	BRA mainPart3bloop
	
mainPart3bloop:
	MOV TEMP, X+
	LSL TEMP
	LDA TEMP
	DEC INDEX
	BEQ mainPart3b
	BRA mainPart3bloop


