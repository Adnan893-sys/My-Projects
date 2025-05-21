.INCLUDE "m328Pdef.inc"
    .equ temp = 0x00
    LDI R20,HIGH(RAMEND)
	OUT SPH,R20
    LDI R20,LOW(RAMEND)
	OUT SPL,R20
 LDI R18,0x00   ;low input
 LDI R17,0x00   ;high input
 LDI R16,0x00   ;copy of 1st bcd 
 LDI R27,0x08    ;count
 LDI R20,0x00    ;R17 addition
 LDI R24,0x00    
 LDI R30,0x00    ;intermediate 3
 LDI R31,0x00    ;inter
    LDI R26,0x00    ;Low byte
    LDI R28,0x00    ;intermediate 1
    LDI R29,0x00    ;intermediate 2
    
    LDI R16,0xFF
	OUT DDRB,R16  ;make portB as output
	OUT DDRD,R16  ;make portD as output
	LDI R16,0x10
	OUT DDRC,R16   ; make portc as input for ADC
	CBI PORTC,4
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
	OUT PORTD, R18
	LDS R17,ADCH        ;read ADCH second
	OUT PORTD, R18
	;SBRC R17,1
	;SBI PORTC,4
	rjmp Read_ADC

