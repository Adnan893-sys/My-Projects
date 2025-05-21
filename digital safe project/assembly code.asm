
; Define variables.
.equ locker_number= 0x27
.equ got_number= 0x28
.equ pass_check= 0x40
.def addressL= R24
.def addressH= R25
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
   Call Get_Locker_Number 
   cpi R19,0x01            //chcek either 1st locker 
   BREQ First_Locker       //if equal do comparision with 1st pass
   cpi R19,0x02            //chcek either 2nd locker 
   BREQ Second_Locker     //if equal do comparision with 2nd pass
   cpi R19,0x03            //chcek either 3rd locker
   BREQ Third_Locker       //if equal do comparision with 3rd pass
   cpi R19,0x04             //chcek either 4th locker
   BREQ Fourth_Locker      //if equal do comparision with 4th pass
   cpi R19,0x05            //chcek either 5th locker
   BREQ Fifth_Locker      //if equal do comparision with 5th pass
   cpi R19,0x06           //chcek either 6th locker
   BREQ Sixth_Locker     //if equal do comparision with 6th pass
   jmp loop

First_Locker:
   call Show_switch_number         // show switch number
   call Check_first_password       //check and compare 1st password
   jmp loop
   
Second_Locker:
    call Show_switch_number       // show switch number
   call Check_Second_password     //check and compare 2nd password  
   jmp loop  
   
Third_Locker:
   call Show_switch_number       // show switch number
   call Check_Third_password     //check and compare 3rd password
   jmp loop
   
Fourth_Locker:
   call Show_switch_number       // show switch number
   call Check_Fourth_password    //check and compare 4th password
   jmp loop
   
Fifth_Locker:
   call Show_switch_number        // show switch number
   call Check_Fifth_password      //check and compare 5th password
   jmp loop
   
Sixth_Locker:
   call Show_switch_number       // show switch number
   call Check_Sixth_password     //check and compare 6th password
   jmp loop
  

;************************************************************************
Check_first_password:
   call Get_both_numbers_first             //getting intial numbers of 1st locker
   Call Do_further                         // check further digits
   Ret
;************************************************************************
Check_Second_password:
   call Get_both_numbers_Second           //getting intial numbers of 2nd locker
   Call Do_further                        // check further digits
   Ret
;************************************************************************
Check_Third_password:
   call Get_both_numbers_Third           //getting intial numbers of 3rd locker
   Call Do_further                       // check further digits
   Ret
;************************************************************************
Check_Fourth_password:
   call Get_both_numbers_Fourth           //getting intial numbers of 4th locker
   Call Do_further                        // check further digits
   Ret
;************************************************************************
Check_Fifth_password:
   call Get_both_numbers_Fifth            //getting intial numbers of 5th locker
   Call Do_further                        // check further digits
   Ret
;************************************************************************
Check_Sixth_password:
   call Get_both_numbers_Sixth           //getting intial numbers of 6th locker
   Call Do_further                       // check further digits
   Ret
;************************************************************************
Do_further:
   cp R20,R22                            // compare pressed number with thr sored passworg digit
   BREQ M1                               // if eqal goto matching
   LDi R23,0x01                         //else save 0x01 to R23
M1: 
  call Matching                        //call matching
  jmp	G1                             //jump G1
G1:
  Ret

;************************************************************************
  
Matching:
   LDI R22,0x01                        
   OUT PORTA,R22
   Call Get_both_numbers                 //get both numbers
   cp R20,R22                            //compare R20 with R22
   BREQ A2
   LDi R23,0x01                          //else save 0x01 to R23
A2:
   LDI R22,0x02
   OUT PORTA,R22
   Call Get_both_numbers                    //get both numbers
   cp R20,R22                                 //compare R20 with R22
   BREQ A3
   LDi R23,0x01
A3:
   LDI R22,0x03
   OUT PORTA,R22
   Call Get_both_numbers                         //get both numbers
   cp R20,R22                                    //compare R20 with R22
   BREQ A4
   LDi R23,0x01                            //else save 0x01 to R23
A4:
   LDI R22,0x04
   OUT PORTA,R22
   Call Get_both_numbers                       //get both numbers
   cp R20,R22                                  //compare R20 with R22
   BREQ A5
   LDi R23,0x01                             //else save 0x01 to R23
A5:
   LDI R22,0x05
   OUT PORTA,R22
   Call Get_both_numbers                     //get both numbers
   cp R20,R22                                //compare R20 with R22
   BREQ A6
   LDi R23,0x01                              //else save 0x01 to R23
A6:
   LDI R22,0x06
   OUT PORTA,R22
   Call Get_both_numbers                     //get both numbers
   cp R20,R22                                 //compare R20 with R22
   BREQ A7
   LDi R23,0x01                             //else save 0x01 to R23
A7:
   LDI R22,0x07
   OUT PORTA,R22
   Call Get_both_numbers                      //get both numbers
   cp R20,R22                                 //compare R20 with R22
   BREQ A8
   LDi R23,0x01                              //else save 0x01 to R23
   call wait
  ; JMP	over
A8: 
   cpi R23,0x01                                //compare R23 with 0x01   
   Breq wait
   LDI R22,0x08                                
   OUT PORTA,R22
   LDi R18,0x80
   call Show_Status_Led                        //show staus on status led
   JMP	over
wait:
   call Delay_10s                            //delay 10s if wrong paasword
   LDi R16,0x00
   OUT PORTA,R16
over:
   Ret

;************************************************************************
;
Get_both_numbers:
   CALL	ReadKP
   call Change
   call Show_Pressed_number

   STS got_number, R20	   ; Value returned in R20 (temp)
   mov R30, addressL        ; load lower byte of Pass1 location in R28
   mov R31, addressH        ; load higher byte of Pass1 location in R29
   LPM R22,Z
   cpi R22,0x40
   brsh one_extra
   subi R22,0x30
   rjmp increment
one_extra:
   subi R22,0x31
increment:
   inc Zl
   mov addressL, R30
   mov addressH, R31
   
   RET

;************************************************************************
Get_both_numbers_first:
    CALL	ReadKP
   call Change
   call Show_Pressed_number
   STS got_number, R20	   ; Value returned in R20 (temp)
   OUT PORTA,R20
   LDI ZL, LOW(Pass1<<1)   ; load lower byte of Pass1 location in R28
   LDI ZH, HIGH(Pass1<<1)  ; load higher byte of Pass1 location in R29
   LPM R22,Z
   subi R22,0x30
   inc R30
   mov addressL, R30
   mov addressH, R31
   Ret
;************************************************************************
Get_both_numbers_Second:
    CALL	ReadKP
   call Change
   call Show_Pressed_number
   STS got_number, R20	   ; Value returned in R20 (temp)
   OUT PORTA,R20
   LDI ZL, LOW(Pass2<<1)   ; load lower byte of Pass1 location in R28
   LDI ZH, HIGH(Pass2<<1)  ; load higher byte of Pass1 location in R29
   LPM R22,Z
   subi R22,0x30
   inc R30
   mov addressL, R30
   mov addressH, R31
   Ret
;************************************************************************
Get_both_numbers_Third:
    CALL	ReadKP
   call Change
   call Show_Pressed_number
   STS got_number, R20	   ; Value returned in R20 (temp)
   OUT PORTA,R20
   LDI ZL, LOW(Pass3<<1)   ; load lower byte of Pass1 location in R28
   LDI ZH, HIGH(Pass3<<1)  ; load higher byte of Pass1 location in R29
   LPM R22,Z
   subi R22,0x30
   inc R30
   mov addressL, R30
   mov addressH, R31
   Ret
;************************************************************************
Get_both_numbers_Fourth:
    CALL	ReadKP
   call Change
   call Show_Pressed_number
   STS got_number, R20	   ; Value returned in R20 (temp)
   OUT PORTA,R20
   LDI ZL, LOW(Pass4<<1)   ; load lower byte of Pass1 location in R28
   LDI ZH, HIGH(Pass4<<1)  ; load higher byte of Pass1 location in R29
   LPM R22,Z
   subi R22,0x30
   inc R30
   mov addressL, R30
   mov addressH, R31
   Ret
;************************************************************************
Get_both_numbers_Fifth:
    CALL	ReadKP
   call Change
   call Show_Pressed_number
   STS got_number, R20	   ; Value returned in R20 (temp)
   OUT PORTA,R20
   LDI ZL, LOW(Pass5<<1)   ; load lower byte of Pass1 location in R28
   LDI ZH, HIGH(Pass5<<1)  ; load higher byte of Pass1 location in R29
   LPM R22,Z
   subi R22,0x30
   inc R30
   mov addressL, R30
   mov addressH, R31
   Ret
;************************************************************************
Get_both_numbers_Sixth:
    CALL	ReadKP
   call Change
   call Show_Pressed_number
   STS got_number, R20	   ; Value returned in R20 (temp)
   OUT PORTA,R20
   LDI ZL, LOW(Pass6<<1)   ; load lower byte of Pass1 location in R28
   LDI ZH, HIGH(Pass6<<1)  ; load higher byte of Pass1 location in R29
   LPM R22,Z
   subi R22,0x30
   inc R30
   mov addressL, R30
   mov addressH, R31
   Ret
;************************************************************************
Show_Pressed_number:
   Andi R16,0xF0               //mask upper 4 bits
   or R16,R20                 //or with R20
   OUT PORTB, R16             //show on PORTB
   Ret
;************************************************************************
Show_Status_Led:
   Andi R16,0x7F             //mask lower 7 bits
   or R16,R18                 //or with r18
   OUT PORTB, R16             // show on PORTb
   Ret
;************************************************************************
   Show_switch_number:
   Andi R16,0x8F          //mask lower 4 bits with 8th bit
   swap R19              //swap R19
   or R16,R19            //or with r19
   OUT PORTB, R16       //show on PORTb
   Ret
;************************************************************************
Get_Locker_Number:
    LDI R19,0x00
    SBIS PINC,0       // check if bit set
	LDI R19,0x01      //put 0x01 in R19 
    rjmp H1

H1:	SBIS PINC,1        // check if bit set
	LDI R19,0x02       //put 0x02 in R19 
	rjmp H2	

H2:	SBIS PINC,2    // check if bit set
	LDI R19,0x03   //put 0x03 in R19 
	rjmp H3
		
H3:	SBIS PINC,3     // check if bit set
	LDI R19,0x04    //put 0x04 in R19 
	rjmp H4
		
H4:	SBIS PINC,4   // check if bit set
	LDI R19,0x05   //put 0x05 in R19 
	rjmp H5

H5:	SBIS PINC,5      // check if bit set
	LDI R19,0x06     //put 0x06 in R19 
	rjmp H6	
H6:
    Ret

Init:
 LDI R21,0xFF               ;mov 0xFF to R21
 OUT DDRB,R21               ;Mov R21 to DDRB for making it as output
 LDI R21,0xFF               ;mov 0xFF to R21
 OUT DDRA,R21               ;Mov R21 to DDRB for making it as output
 LDI R20,0xF0               ;mov 0x00 to R20
 OUT DDRD,R20               ;Mov R20 to DDRD for making it as input
 LDI R20,0x00               ;mov 0x00 to R20
 OUT DDRC,R20               ;Mov R20 to DDRc for making it as input
 LDI R20,0xFF               ;mov 0x00 to R20
 OUT PORTC,R20               ;Mov R20 to DDRc for making it as input


  	RET	
;************************************************************************

ReadKP:
LDI R20,0x0F       ; load 0x0F to r20
 OUT PORTD,R20     ; load it to pORT D

 WAIT_FOR_RELEASE:
 NOP               ;do nothing
 IN R21,PIND       ;get data from PIND in R21
 ANDI R21,0x0F     ;mask lower nibble
 CPI R21,0x0F      ;compare  R21 with 0x0F
 BRNE WAIT_FOR_RELEASE    

 WAIT_FOR_KEY:
 NOP                ;do nothoing
 IN R21,PIND        ;get data from PIND in R21
 ANDI R21,0x0F      ;mask lower nibble
 CPI R21,0x0F       ;compare  R21 with 0x0F
 BREQ WAIT_FOR_KEY
 CALL Delay         ;delay for switch debouncing
 IN R21,PIND         ;get data from PIND in R21
 ANDI R21,0x0F       ;mask lower nibble
 CPI R21,0x0F        ;compare  R21 with 0x0F
 BREQ WAIT_FOR_KEY

 LDI R21,0b11101111  ;send 0 to first column
 OUT PORTD,R21       ; send it to PORTD
 NOP                 
 IN R21,PIND         ;get data from PIND in R21    
 ANDI R21,0x0F       ;mask lower nibble
 CPI R21,0x0F        ;compare  R21 with 0x0F
 BRNE COL1           ;if not equal switch to COL1

 LDI R21,0b11011111  ;send 0 to 2nd column
 OUT PORTD,R21        ; send it to PORTD
 NOP 
 IN R21,PIND          ;get data from PIND in R21 
 ANDI R21,0x0F        ;mask lower nibble
 CPI R21,0x0F         ;compare  R21 with 0x0F
 BRNE COL2            ;if not equal switch to COL2

 LDI R21,0b10111111   ;send 0 to 3rd column
 OUT PORTD,R21        ; send it to PORTD
 NOP 
 IN R21,PIND          ;get data from PIND in R21 
 ANDI R21,0x0F        ;mask lower nibble
 CPI R21,0x0F         ;compare  R21 with 0x0F
 BRNE COL3            ;if not equal switch to COL3

 LDI R21,0b01111111   ;send 0 to 4th column
 OUT PORTD,R21        ; send it to PORTD
 NOP 
 IN R21,PIND         ;get data from PIND in R21 
 ANDI R21,0x0F       ;compare  R21 with 0x0F
 CPI R21,0x0F        ;if not equal switch to COL3
 BRNE COL4          ;if not equal switch to COL4

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
Change:
           cpi R20,0x30
		   brsh check_further
		  ; out PORTB,R20
		   rjmp further
check_further:
           cpi R20,0x40
		   brlo subtract
		  subi R20,0x31
		   rjmp further
subtract:
           subi R20,0x30
	      ; out PORTB,R20
further:
		RET

;*************************************************************************
Delay:
	PUSH R16			; Save R16 and 17 as we're going to use them
	PUSH R17			; as loop counter
	CLR R16			; Init inner counter
	CLR R17			; and outer counter
    LDI R16,20      ;load R16 with 20
T2:
    LDI R17,50      ;load R16 with 50
T1:
	  NOP
	  NOP
	  DEC R17       ;decrement 17
	  BRNE T1       ;jump to H1 if not zero
	  DEC R16       ;decrement 16
	  BRNE T2       ;jump to H2 if not zero

	POP R17
	POP R16
    RET
;**********************************************************************
Delay_10s:
	LDI R16,45      ;load R16 with 50
P1:	LDI R17,200      ;load R16 with 50
P2: LDI R18,250      ;load R16 with 20

P3:	NOP
	NOP
	DEC R18       ;decrement 17
	BRNE P3       ;jump to H1 if not zero
    DEC R17       ;decrement 16
	BRNE P2       ;jump to H2 if not zero
	DEC R16       ;decrement 16
	BRNE P1       ;jump to H2 if not zero
    RET
;**********************************************************************
;**********************************************************************
;Table for numbers
.ORG 0x300
KCODE0:      .DB '1','4','7','*'
KCODE1:      .DB '2','5','8','0'
KCODE2:      .DB '3','6','9','#'
KCODE3:      .DB 'A','B','C','D'
;.ORG 0x500
Pass1:       .DB  "12152025" 
Pass2:       .DB  "30354045" 
Pass3:       .DB  "50556065" 
Pass4:       .DB  "70758085" 
Pass5:       .DB  "90951020" 
Pass6:       .DB  "3040506A" 