/*
 * check.asm
 *
 *  Created: 7/30/2022 12:13:09 AM
 *   Author: GH2
 */ 


 .INCLUDE "m328Pdef.inc"
 .cseg
      rjmp main
  .org ADCCaddr
      rjmp ADC_Int_HANDLER
   .ORG 45
 main:
    LDI R20,HIGH(RAMEND)
	OUT SPH,R20
    LDI R20,LOW(RAMEND)
	OUT SPL,R20
	SEI
    LDI R16,0xFF
	OUT DDRB,R16  ;make portB as output
	OUT DDRD,R16  ;make portD as output
	LDI R16,0
	OUT DDRC,R16   ; make portc as input for ADC
	LDI R16,0x8f      ;87
	STS ADCSRA,R16  ;enable ADC and select clk/128
	LDI R16,0x40    ; 2.56 Vref ADC0    ; 40
	STS ADMUX,R16   ;input, right justified data
	LDS R26, ADCSRA     ; Get current value of ADCSRA into R26
    ORI R26, 0x40       ; Set the ADSC bit
    STS ADCSRA, R26     ; Write the modified value back to ADCSRA
	wait_here:
	    rjmp wait_here
ADC_Int_HANDLER:
    LDS R18,ADCL        ;read ADCL first
	OUT PORTD, R18     ;give lower byte to PORTD
	LDS R17,ADCH        ;read ADCH second
    OUT PORTB, R17     ;give higher byte to PORTB
	LDS R26, ADCSRA     ; Get current value of ADCSRA into R26
    ORI R26, 0x40       ; Set the ADSC bit
    STS ADCSRA, R26     ; Write the modified value back to ADCSRA
	RETI

   