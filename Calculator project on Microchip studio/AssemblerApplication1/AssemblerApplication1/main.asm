;
; AssemblerApplication1.asm
;
; Created: 6/30/2021 6:46:13 AM
; Author : Adnan Rao
;


; Replace with your application code
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 .MACRO LoadIo
 LDI R20,@1
 OUT @0,R20
 .ENDMACRO
 ;#############################################################
 .MACRO Send
 LoadIo  PORTC,@0
 LoadIo  PORTB,@1
 .ENDMACRO
 ;##################################################################
  LDI R16,HIGH(RAMEND)
  OUT SPH,R16
  LDI R16,LOW(RAMEND)
  OUT SPL,R16

  LDI R16,0xFF
  OUT DDRB,R16
  OUT DDRC,R16
  OUT DDRD,R16

  
AGAIN: 
  ;CALL For_one
  ;CALL ZERO
 ; CALL FDelay
 ; CALL ONE
 ; CALL FDelay
 ; CALL TWO
 ; CALL FDelay
 ; CALL THREE
 ; CALL FDelay
 ; CALL FOUR
 ; CALL FDelay
 ; CALL FIVE
 ; CALL FDelay
; CALL SIX
 ;CALL FDelay
  ;CALL SEVEN
 ; CALL FDelay
 ; CALL EIGHT
 ; CALL FDelay
  CALL NINE
  ;CALL FDelay
  RJMP AGAIN





;################################################################
Delay:
    LDI R21,3
D1:	LDI R22,2
D2:	NOP
	NOP
	DEC R22
	BRNE D2
	DEC R21
	BRNE D1
	RET
;#############################################
FDelay:
    LDI R20,32
L1:	LDI R21,200
L2:	LDI R22,250
L3:	NOP
	NOP
	DEC R22
	BRNE L3
	DEC R21
	BRNE L2
	DEC R20
	BRNE L1
    RET
;################################################################
ONE:
Send 0xFB,0x01
CALL OFF
Send 0xF9,0x02
CALL OFF
Send 0xFB,0x04
CALL OFF
Send 0xFB,0x08
CALL OFF
Send 0xFB,0x10
CALL OFF
Send 0xFB,0x20
CALL OFF
Send 0xF1,0x40
CALL OFF
RET
;###############################################################
TWO:
Send 0xF1,0x01
CALL OFF
Send 0xF7,0x02
CALL OFF
Send 0xF7,0x04
CALL OFF
Send 0xF1,0x08
CALL OFF
Send 0xFD,0x10
CALL OFF
Send 0xFD,0x20
CALL OFF
Send 0xF1,0x40
CALL OFF
RET
;###############################################################
THREE:
Send 0xF1,0x01
CALL OFF
Send 0xF7,0x02
CALL OFF
Send 0xF7,0x04
CALL OFF
Send 0xF1,0x08
CALL OFF
Send 0xF7,0x10
CALL OFF
Send 0xF7,0x20
CALL OFF
Send 0xF1,0x40
CALL OFF
RET
;###############################################################
FOUR:
Send 0xF5,0x01
CALL OFF
Send 0xF5,0x02
CALL OFF
Send 0xF5,0x04
CALL OFF
Send 0xF1,0x08
CALL OFF
Send 0xF7,0x10
CALL OFF
Send 0xF7,0x20
CALL OFF
Send 0xF7,0x40
CALL OFF
RET
;###############################################################
FIVE:
Send 0xF1,0x01
CALL OFF
Send 0xFD,0x02
CALL OFF
Send 0xFD,0x04
CALL OFF
Send 0xF1,0x08
CALL OFF
Send 0xF7,0x10
CALL OFF
Send 0xF7,0x20
CALL OFF
Send 0xF1,0x40
CALL OFF
RET
;###############################################################
SIX:
Send 0xF1,0x01
CALL OFF
Send 0xFD,0x02
CALL OFF
Send 0xFD,0x04
CALL OFF
Send 0xF1,0x08
CALL OFF
Send 0xF5,0x10
CALL OFF
Send 0xF5,0x20
CALL OFF
Send 0xF1,0x40
CALL OFF
RET
;###############################################################
SEVEN:
Send 0xF1,0x01
CALL OFF
Send 0xF7,0x02
CALL OFF
Send 0xF7,0x04
CALL OFF
Send 0xF7,0x08
CALL OFF
Send 0xF7,0x10
CALL OFF
Send 0xF7,0x20
CALL OFF
Send 0xF7,0x40
CALL OFF
RET
;###############################################################
EIGHT:
Send 0xF1,0x01
CALL OFF
Send 0xF5,0x02
CALL OFF
Send 0x0F5,0x04
CALL OFF
Send 0xF1,0x08
CALL OFF
Send 0xF5,0x10
CALL OFF
Send 0xF5,0x20
CALL OFF
Send 0xF1,0x40
CALL OFF
RET
;###############################################################
NINE:
Send 0xF1,0x01
CALL OFF
Send 0xF5,0x02
CALL OFF
Send 0xF5,0x04
CALL OFF
Send 0xF1,0x08
CALL OFF
Send 0xF7,0x10
CALL OFF
Send 0xF7,0x20
CALL OFF
Send 0xF1,0x40
CALL OFF
RET
;###############################################################
ZERO:
Send 0xF1,0x01
CALL OFF
Send 0xF5,0x02
CALL OFF
Send 0xF5,0x04
CALL OFF
Send 0xF5,0x08
CALL OFF
Send 0xF5,0x10
CALL OFF
Send 0xF5,0x20
CALL OFF
Send 0xF1,0x40
CALL OFF
RET
;##############################################################
OFF:
Call Delay
LoadIo PORTC,0xFF
LoadIo PORTB,0x00
Call Delay
RET


