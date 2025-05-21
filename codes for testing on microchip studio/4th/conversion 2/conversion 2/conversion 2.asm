/*
 * conversion.asm
 *
 *  Created: 7/29/2022 10:15:28 AM
 *   Author: GH2
 */ 
   .INCLUDE "m328Pdef.inc"
 LDI R18,0x3d   ;low input
 LDI R17,0x01   ;high input
 LDI R16,0x00   ;copy of 1st bcd 
 LDI R27,0x08    ;count
 LDI R20,0x00    ;R17 addition
 LDI R24,0x00    
 LDI R30,0x00    ;intermediate 3
 LDI R31,0x00    ;intermediate 4
 LDI R16,0xFF
	OUT DDRB,R16  ;make portB as output
	OUT DDRD,R16  ;make portD as output
start:
 CLC
 ROL R18
 ROL R30
 ROL R31
 dec R27
 brne go_check
 rjmp next
 go_check:
 rcall Check2
 rcall Check3
 rjmp start
next:
  SBRC R17,0
  inc R20
  SBRS R17,1
  rjmp next1
  inc R20
  inc R20
  rjmp next1

next1:
  cpi R20,0x00
  brne L1
  LDI R21,0
  LDI R22,0
  LDI R23,0
  rjmp do_addition
L1:
  cpi R20,0x01
  brne L2
  LDI R21,2
  LDI R22,5
  LDI R23,6
  rjmp do_addition
L2:
  cpi R20,0x02
  brne L3
  LDI R21,5
  LDI R22,1
  LDI R23,2
  rjmp do_addition
L3:
  cpi R20,0x03
  brne do_addition
  LDI R21,7
  LDI R22,6
  LDI R23,8

do_addition:
  CLC
  MOV R25,R30
  andi R25,0x0F
  Add R25,R23
  cpi R25,0x0A
  BRLO move_next
  subi R25,0x0A
  
  inc R24
move_next:
  andi R30,0xF0
  swap r30
  Add R30,R22
  Add R30,R24
  ldi r24, 0x00
  cpi R30,0x0A
  BRLO X1
  subi R30,0x0A
   inc R24
X1:
  swap r30
  or R30,R25
  Add R31,R21
  Add R31,R24
  LDI R24,0x00
  cpi R31,0x0A
  brsh division
  rjmp end
 division:
  subi R31,0x0A
  inc R24
  swap R24
  or R31, R24
  
end:
  OUT PORTB,R30
  OUT PORTD,R31
here: rjmp here

 



						
 //////////////////////////////////////////

Check2:
 MOV R16,R30
 Andi R16,0x0F
 cpi R16,0x05
 BRSH do_Add2
 rjmp exit2
 do_Add2:
 LDI R19,0x03
 Add R16,R19
andi R30,0xF0
 or R30,R16
exit2:
   ret

 Check3:
 MOV R16,R30
 swap R16
 Andi R16,0x0F
 cpi R16,0x05
 BRSH do_Add3
 rjmp exit3
 do_Add3:
 LDI R19,0x03
 Add R16,R19
 swap R16
 andi R30,0x0F
 or R30,R16
exit3:
   ret

FDelay:
    LDI R20,1
T1:	LDI R21,200
T2:	LDI R22,250
T3:	NOP
	NOP
	DEC R22
	BRNE T3
	DEC R21
	BRNE T2
	DEC R20
	BRNE T1
    RET




