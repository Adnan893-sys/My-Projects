;
; AssemblerApplication1.asm
;
; Created: 7/2/2021 7:30:59 AM
; Author : Adnan Rao
;


; Replace with your application code
.Equ Key_Port = PORTD
.Equ Key_Pin  = PIND
.Equ Key_DDR  = DDRD
.Equ value    = 0x0A
.Equ num      =0
 LDI R20,HIGH(RAMEND)
 OUT SPH,R20
 LDI R20,LOW(RAMEND)
 OUT SPL,R20
 LDI R21,0xFF
 OUT DDRB,R21
 LDI R20,0xF0
 OUT Key_DDR,R20
 LDI R20,0xFF
 OUT DDRC,R20
 Call Intialize
  
 


  
	CALL First_Value 
	out PORTB,R18
	out PORTC,R25
	Call Intialize
	CALL Second_Value 
	out PORTB,R24
	out PORTC,R20
	call Check_Operation
	
   here: rjmp here
;#################################################################
First_Value:
  N1: Call Get_Number
	  CALL change
      CPI R20,0x0A
	  BRSH Next
	  MUL R18,R23
	  ADD R0,R20
	  mov R18,R0 
	  DEC R19
	  BRNE N1
	  Call Get_Number
	  mov R25,R20
      Rjmp Next
Next:
     mov R25,R20
     RET
;#################################################################
Second_Value:
  N2: Call Get_Number
	  CALL change
      CPI R20,0x0A
	  BRSH Next1
	  MUL R24,R23
	  ADD R0,R20
	  mov R24,R0 
	  DEC R19
	  BRNE N2
	  Call Get_Number
	  Rjmp Next1
Next1:
     RET
;#################################################################
Check_Operation:
    
     CPI R20,0x3D
	 BRSH Check
	 rjmp Exit
Check:
     ldi R20,0x2B
     CP R25,R20
	 Breq Addition
	 ldi R20,0x2D
	 CP R25,R20
	 BReq Subtraction
	 ldi R20,0x2A
	 CP R25,R20
	 BReq Multiply
	 ldi R20,0x2F
	 CP R25,R20
	 BReq Division
	 ldi R20,0x45
	 CP R25,R20
	 BReq Clear
	 rjmp Exit
Addition:
     out PORTC,R18
     ADD R18,R24
	 out PORTB,R18
	 rjmp Exit
Subtraction:
     
     Sub R18,R24
	 out PORTB,R18
	 rjmp Exit
Multiply:
     Mul R24,R18
	 out PORTB,R0
	 out PORTC,R1
     rjmp Exit
Division:
     .def result = R22
	 clr result
RE:	 inc result
	 Sub R18,R24
	 BRCC RE
	 dec result
	 out PORTB,R22
	 rjmp Exit
Clear:
     LDI R18,0
	 LDI R24,0
	 LDI R25,0
	 LDI R20,0
	 rjmp Exit
Exit:
     Ret
;###############################################################
Intialize:
     
	 LDI R24,0
     LDI R19,3
     LDI R23,10
	 RET
;#################################################################
change:
	  CPI R20,0x30
	  BRSH EQUAL
	  rjmp back
	EQUAL:
	   LDI R16,0x45
	   CP R20,R16
	   BREQ ZX
	   LDI R16,0x3D
	   CP R20,R16
	   BREQ ZX
	   SUBI R20,0x30
	   rjmp back
	ZX:
	   rjmp back
	back:
      RET
;###########################################################
 WAIT:
LDI R16,250
G2:LDI R17,250
G1:NOP
  NOP
  DEC R17
  BRNE G1
  DEC R16
  BRNE G2
  RET
;##################################
 Get_Number:
 LDI R20,0x0F
 OUT Key_Port,R20

 WAIT_FOR_RELEASE:
 NOP 
 IN R21,KEY_PIN
 ANDI R21,0x0F
 CPI R21,0x0F
 BRNE WAIT_FOR_RELEASE

 WAIT_FOR_KEY:
 NOP 
 IN R21,KEY_PIN
 ANDI R21,0x0F
 CPI R21,0x0F
 BREQ WAIT_FOR_KEY
 CALL WAIT5MS
 IN R21,KEY_PIN
 ANDI R21,0x0F
 CPI R21,0x0F
 BREQ WAIT_FOR_KEY

 LDI R21,0b01111111
 OUT Key_Port,R21
 NOP 
 IN R21,KEY_PIN
 ANDI R21,0x0F
 CPI R21,0x0F
 BRNE COL1

 LDI R21,0b10111111
 OUT Key_Port,R21
 NOP 
 IN R21,KEY_PIN
 ANDI R21,0x0F
 CPI R21,0x0F
 BRNE COL2

 LDI R21,0b11011111
 OUT Key_Port,R21
 NOP 
 IN R21,KEY_PIN
 ANDI R21,0x0F
 CPI R21,0x0F
 BRNE COL3

 LDI R21,0b11101111
 OUT Key_Port,R21
 NOP 
 IN R21,KEY_PIN
 ANDI R21,0x0F
 CPI R21,0x0F
 BRNE COL4

 COL1:
 LDI R30, LOW(KCODE0<<1)
 LDI R31, HIGH(KCODE0<<1)
 RJMP FIND
 COL2:
 LDI R30, LOW(KCODE1<<1)
 LDI R31, HIGH(KCODE1<<1)
 RJMP FIND
 COL3:
 LDI R30, LOW(KCODE2<<1)
 LDI R31, HIGH(KCODE2<<1)
 RJMP FIND
 COL4:
 LDI R30, LOW(KCODE3<<1)
 LDI R31, HIGH(KCODE3<<1)
 RJMP FIND

 FIND:
 LSR R21
 BRCC MATCH
 LPM R20,Z+
 RJMP FIND

MATCH:
LPM R20,Z
RET
;##########################################################
WAIT5MS:
LDI R16,20
H2:LDI R17,50
H1:NOP
  NOP
  DEC R17
  BRNE H1
  DEC R16
  BRNE H2
  RET
;#####################################################
.ORG 0x300
KCODE0:      .DB '/','9','8','7'
KCODE1:      .DB '*','6','5','4'
KCODE2:      .DB '-','3','2','1'
KCODE3:      .DB '+','=','0','E'