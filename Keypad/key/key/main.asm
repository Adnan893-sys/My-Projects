; ****************************************************
; EEET2256 - Laboratory 3B (2022) Template
; Author: Dr. Glenn Matthews
; Last Updated:  18/08/2022 10:58:04 AM
; lab3b_template.asm
;*****************************************************
; Define variables.
.def  temp  = r20
LDI R20,HIGH(RAMEND)
 OUT SPH,R20
 LDI R20,LOW(RAMEND)
 OUT SPL,R20

; Reset Vector.
reset:
   rjmp start


start:

    CALL Init           ; Initialise the system.

loop:		
	CALL	ReadKP  		; Value returned in R20 (temp)
                        	; This is useful comment as it says what this program is doing
    CALL	Display
    RJMP	loop				; Do all again NB You don't need to reinitialize

;************************************************************************
;
Init:
 LDI R21,0xFF               ;mov 0xFF to R21
 OUT DDRB,R21               ;Mov R21 to PORTB for making it as output
 LDI R20,0xF0               ;mov 0x00 to R20
 OUT DDRC,R20               ;Mov R20 to PORTC for making it as input


  	RET	
;************************************************************************

ReadKP:
LDI R20,0x0F       ; load 0x0F to r20
 OUT PORTC,R20     ; load it to pORT C

 WAIT_FOR_RELEASE:
 NOP               ;do nothing
 IN R21,PINC       ;get data from PINC in R21
 ANDI R21,0x0F     ;mask lower nibble
 CPI R21,0x0F      ;compare  R21 with 0x0F
 BRNE WAIT_FOR_RELEASE    

 WAIT_FOR_KEY:
 NOP                ;do nothoing
 IN R21,PINC        ;get data from PINC in R21
 ANDI R21,0x0F      ;mask lower nibble
 CPI R21,0x0F       ;compare  R21 with 0x0F
 BREQ WAIT_FOR_KEY
 CALL Delay         ;delay for switch debouncing
 IN R21,PINC         ;get data from PINC in R21
 ANDI R21,0x0F       ;mask lower nibble
 CPI R21,0x0F        ;compare  R21 with 0x0F
 BREQ WAIT_FOR_KEY

 LDI R21,0b01111111  ;send 0 to first column
 OUT PORTC,R21       ; send it to PORTC
 NOP                 
 IN R21,PINC         ;get data from PINC in R21    
 ANDI R21,0x0F       ;mask lower nibble
 CPI R21,0x0F        ;compare  R21 with 0x0F
 BRNE COL1           ;if not equal switch to COL1

 LDI R21,0b10111111  ;send 0 to 2nd column
 OUT PORTC,R21        ; send it to PORTC
 NOP 
 IN R21,PINC          ;get data from PINC in R21 
 ANDI R21,0x0F        ;mask lower nibble
 CPI R21,0x0F         ;compare  R21 with 0x0F
 BRNE COL2            ;if not equal switch to COL2

 LDI R21,0b11011111   ;send 0 to 3rd column
 OUT PORTC,R21        ; send it to PORTC
 NOP 
 IN R21,PINC          ;get data from PINC in R21 
 ANDI R21,0x0F        ;mask lower nibble
 CPI R21,0x0F         ;compare  R21 with 0x0F
 BRNE COL3            ;if not equal switch to COL3

 LDI R21,0b11101111   ;send 0 to 4th column
 OUT PORTC,R21        ; send it to PORTC
 NOP 
 IN R21,PINC         ;get data from PINC in R21 
 ANDI R21,0x0F       ;compare  R21 with 0x0F
 CPI R21,0x0F        ;if not equal switch to COL3
 BRNE COL4           ;if not equal switch to COL4

 COL1:
 LDI R30, LOW(KCODE0<<1)   ; load lower byte of kcode0 location in R30
 LDI R31, HIGH(KCODE0<<1)  ; load higher byte of kcode0 location in R31
 RJMP FIND                 ;find
 COL2:
 LDI R30, LOW(KCODE1<<1)   ; load lower byte of kcode1 location in R30
 LDI R31, HIGH(KCODE1<<1)  ; load higher byte of kcode1 location in R31
 RJMP FIND                 ;find
 COL3:
 LDI R30, LOW(KCODE2<<1)   ; load lower byte of kcode2 location in R30
 LDI R31, HIGH(KCODE2<<1)  ; load higher byte of kcode2 location in R31
 RJMP FIND                 ;find
 COL4:
 LDI R30, LOW(KCODE3<<1)   ; load lower byte of kcode3 location in R30
 LDI R31, HIGH(KCODE3<<1)  ; load higher byte of kcode3 location in R31
 RJMP FIND                 ;find

 FIND:
 LSR R21                  ;shift left R21
 BRCC MATCH               ;branch to the match if carry is cleared
 LPM R20,Z+               ; else load next value from the table
 RJMP FIND                ;jump to find again

MATCH:
LPM R20,Z                 ; if match occurs load value in R20
	RET

;************************************************************************
;
; Takes whatever is in the Temp register and outputs it to the LEDs
Display:
	    	out PORTB,R20
		RET

;*************************************
Delay:
	PUSH R16			; Save R16 and 17 as we're going to use them
	PUSH R17			; as loop counter
	CLR R16			; Init inner counter
	CLR R17			; and outer counter
    LDI R16,20      ;load R16 with 20
H2:
    LDI R17,50      ;load R16 with 50
H1:
	  NOP
	  NOP
	  DEC R17       ;decrement 17
	  BRNE H1       ;jump to H1 if not zero
	  DEC R16       ;decrement 16
	  BRNE H2       ;jump to H2 if not zero

	POP R17
	POP R16
    RET
;Table for numbers
.ORG 0x300
KCODE0:      .DB '1','2','3','A'
KCODE1:      .DB '4','5','6','B'
KCODE2:      .DB '7','8','9','C'
KCODE3:      .DB '*','0','#','D'
