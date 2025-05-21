/*
 * pot_project.asm
 *
 *  Created: 7/28/2022 1:14:21 AM
 *   Author: GH2
 */
  .INCLUDE "m328Pdef.inc"
    .equ temp = 0x00
    LDI R20,HIGH(RAMEND)
	OUT SPH,R20
    LDI R20,LOW(RAMEND)
	OUT SPL,R20
	LDI R16,0x00   ;copy of 1st bcd 
    LDI R26,0x00    ;Low byte
    LDI R27,0x00    ;High byte
    LDI R28,0x00    ;intermediate 1
    LDI R29,0x00    ;intermediate 2
    LDI R30,0x00    ;intermediate 3
    LDI R31,0x00    ;intermediate 4
    LDI R16,0xFF
	OUT DDRB,R16  ;make portB as output
	OUT DDRD,R16  ;make portD as output
	LDI R16,0
	OUT DDRC,R16   ; make portc as input for ADC
	LDI R16,0x87
	STS ADCSRA,R16  ;enable ADC and select clk/128
	LDI R16,0x40    ; 2.56 Vref ADC0
	STS ADMUX,R16   ;input, right justified data


;/////////////////////////////////////////////////////////
;/////////////////////////////////////////////////////////
;////////////////////////////////////////////////////////


Read_ADC:
    LDS R26, ADCSRA     ; Get current value of ADCSRA into R26
    ORI R26, 0x40       ; Set the ADSC bit
    STS ADCSRA, R26     ; Write the modified value back to ADCSRA
Keep_polling:        ;wait for end of conversion 
    LDS R26, ADCSRA     ; Get current value of ADCSRA into R26
    SBRS R26,4  ;is it end of conversion
	Rjmp Keep_polling  ;keep polling end of conversion
	LDS R26, ADCSRA     ; Get current value of ADCSRA into R26
    ORI R26, 0x10       ; Set the ADSC bit
    STS ADCSRA, R26     ; Write the modified value back to ADCSRA
	LDS R18,ADCL        ;read ADCL first
	;OUT PORTD, R18     ;give lower byte to PORTD
	LDS R17,ADCH        ;read ADCH second
  ;  OUT PORTB, R17     ;give higher byte to PORTB
	;rjmp Read_ADC

	start:
 CLC
 ROL R18
 ROL R17
 rcall Check
 rjmp start

 Check:
 MOV R16,R17
 swap R16
 Andi R16,0x0F
 cpi R16,0x05
 BRSH do_Add
 rjmp exit
 do_Add:
 LDI R19,0x03
 Add R16,R19
 swap R16
 andi R17,0x0F
 or R17,R16
 rcall next
 OUT PORTB,R30
Andi R17,0xF0
Andi R31,0x0F
or R17,R31
OUT PORTD,R17
rcall FDelay
LDI R18,0x00
LDI R17,0x00
LDI R16,0x00
LDI R19,0x00
LDI R30,0x00
LDI R31,0x00
rjmp Read_ADC

exit:
   ret
 
 next:
 CLC
 ROL R18
 ROL R17
 RoL R30
 Rol R31
 rcall check1`
 rcall check2
 rcall check3
 cpi R18,0x00
 BReq check_second
 rjmp next
check_second:
 mov R29,R17
 Andi R29, 0x0F
 cpi R29,0x00
 BReq end
 rjmp next
/* check_3:
 MOV R24,R30
 andi R24,0x0F
 cpi R24,0x05
 brsh end_b
 rjmp end
 end_b:
 CLC
 ROL R18
 ROL R17
 RoL R30
 Rol R31
 rjmp end*/

/*MOV R24,R30
 swap R24
 andi R24,0x0F
 cpi R24,0x05
 brsh next 

 MOV R24,R17
 swap R17
 andi R24,0x0F
 cpi R24,0x05
 brsh end*/
 //////////////////////


end:
    ret

 //////////////////////////////////////////
  Check1:
 MOV R16,R17
 swap R16
 Andi R16,0x0F
 cpi R16,0x05
 BRSH do_Add1
 rjmp exit1
 do_Add1:
 LDI R19,0x03
 Add R16,R19
 swap R16
 andi R17,0x0F
 or R17,R16
exit1:
   ret

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

