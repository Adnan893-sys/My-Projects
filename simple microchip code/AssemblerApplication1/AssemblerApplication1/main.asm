;
; AssemblerApplication1.asm
;
; Created: 7/9/2021 11:16:47 AM
; Author : Adnan Rao
;


; Replace with your application code

 LDI R16,HIGH(RAMEND)
  OUT SPH,R16
  LDI R16,LOW(RAMEND)
  OUT SPL,R16
;#################################
.macro Send
ldi R20,0x08
ldi R19,@0
mov R21,R19
ROL1_Loop8:
cbi PORTB,2
ROL R21
BRCC carry1is0
sbi PORTB,2
carry1is0:
cbi PORTB,3
call  Delay
sbi PORTB,3
call  Delay
dec R20
brne ROL1_Loop8
.endmacro
;#################################
.macro Send1
ldi R20,0x05
ldi R19,@0
mov R21,R19
ROL_Loop8:
cbi PORTB,2
ROR R21
BRCC carryis0
sbi PORTB,2
carryis0:
cbi PORTB,3
call  Delay
sbi PORTB,3
call  Delay
dec R20
brne ROL_Loop8
.endmacro
  ;######################################

ldi R20,0xFF
out DDRB,R20

Send1 0x1E
Send 0x01

call Trig

here:
 rjmp here


;###########################
Trig:
   sbi PORTB,4
   call  Delay
   cbi PORTB,4
   call  Delay
   Ret
;#######################################
Delay:
    LDI R16,3
D1:	LDI R17,2
D2:	NOP
	NOP
	DEC R17
	BRNE D2
	DEC R16
	BRNE D1
	RET

Delay1s:
   
    LDI R21,200
D4:	LDI R22,250
D5:	NOP
	NOP
	DEC R22
	BRNE D5
	DEC R21
	BRNE D4
	RET

