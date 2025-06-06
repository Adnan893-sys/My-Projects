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
	LDI R16,0x20
	OUT DDRC,R16   ; make portc as input for ADC
	CBI PORTC,5
	LDI R16,0x87
	STS ADCSRA,R16  ;enable ADC and select clk/128
	LDI R16,0x40    ; 2.56 Vref ADC0
	STS ADMUX,R16   ;input, right justified data

;show initials
;/////////////////////////
;//////////////////////////
   
   
   LDI R23,20     ; Add 200 to R21 
H2:LDI R24,10     ; Add 250 to R25
H3:NOP            ; do nothoing
	rcall Show_initials   ; this subroutine shows initials
	DEC R24        ; decrement R22
	BRNE H3        ;branch if not equal to t3
	DEC R23        ; decrement R21
	BRNE H2        ;branch if not equal to t2

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
	LDS R17,ADCH        ;read ADCH second
	SBRC R17,1
	SBI PORTC,5

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;this subroutine takes the ADC value sand converts the binary number in the
;the bCD so that we can show number of the seven segment
	start:
 CLC                    ; clear carry
 ROL R18                ;route number left 
 ROL R30                ;route number left 
 ROL R31                ;route number left 
 dec R27                ;check for counter 
 brne go_check          ;branch if not equal to
 rjmp next              ;if equal then jump to the next
 go_check:              
 rcall Check2           ;call check2 to check if number is greater then 5
 rcall Check3           ;call check1 to check if number is greater then 5
 rjmp start             ; jump to start
next:
  SBRC R17,0            ; check for bit 0 in R17, if set
  inc R20               ; increment R20
  SBRS R17,1            ; check for bit 0 in R17 if set
  rjmp next1            ; if not set goto next1
  inc R20               ; increment R20
  inc R20               ; increment R20
  rjmp next1

  ////////////////////////////
  //////////////////////////
; This routine adds the 1st 8 bit bcd data to the data seleted about bit 9th and 10th of ADC
next1:
  cpi R20,0x00          ;compare R20 t0 0
  brne L1              ; if not equal jump to L1 else
  LDI R21,0            ;add 0 to R21  
  LDI R22,0            ;add 0 to R22  
  LDI R23,0            ;add 0 to R23  
  rjmp do_addition     ; jump to do_addition point
L1:
  cpi R20,0x01         ;compare R20 t0 1
  brne L2              ; if not equal jump to L2 else
  LDI R21,2            ;add 2 to R21  
  LDI R22,5            ;add 5 to R22  
  LDI R23,6            ;add 6 to R23  
  rjmp do_addition     ; jump to do_addition point
L2:
  cpi R20,0x02         ;compare R20 t0 2
  brne L3              ; if not equal jump to L3 else
  LDI R21,5            ;add 5 to R21        
  LDI R22,1            ;add 1 to R22 
  LDI R23,2            ;add 2 to R23 
  rjmp do_addition     ;jump to do_addition point
L3:
  cpi R20,0x03         ;compare R20 t0 3
  brne do_addition     ;jump to do_addition point
  LDI R21,7            ;add 7 to R21   
  LDI R22,6            ;add 6 to R22   
  LDI R23,8            ;add 8 to R23   

// this subroutine do the addition of the numbers of last 8 bits 
   ;and numbers generated according to most two msbs
do_addition:
  CLC               ; clear carry
  MOV R25,R30       ; mov r30 to r25 as copy to save
  andi R25,0x0F     ; mask lower 4 bits
  Add R25,R23       ; add r25 to r23 
  cpi R25,0x0A      ; compare R25 to 10
  BRLO move_next    ; if it is low then check other next 4 bits
  subi R25,0x0A     ; if its higher   subtract 10 from R25
  inc R24           ; increment r24
move_next:
  swap R22          ; swap number R22 
  swap r24          ; swap number R22    
  andi R30,0xF0     ; mask upper 4 bits
  Add R30,R22       ; add r30 to r22
  Add R30,R24       ; add r30 to r24
  ldi r24, 0x00     ; clear R24
  andi R30,0xF0     ; mask upper 4 nibbles
  cpi R30,0xA0      ; compare r30 to 10
  BRLO X1           ; if it is low then check other next 4 bits    
  subi R30,0xA0     ; if its higher   subtract 10 from R25
  inc R24           ; increment r24
X1:
  or R30,R25        ;or r30 t0 r25 
  Add R31,R21       ;; add r31 to r21
  Add R31,R24        ; add r31 to r24
  LDI R24,0x00       ;load 00 to R24
  cpi R31,0x0A       ; comapre R31 with 10
  brsh division      ; if number is greater than 10 divide by 10
  rjmp end           ; if not equal goto end
 division:     
  subi R31,0x0A      ; subtract 10 from R31
  inc R24            ; increment R24
  swap R24           ; swap R24
  or R31, R24        ; add R24 to R31

//Here in this subroutine we are doing multiplexing of seven segments so that we 
;can show at atime 4 segments
 end:
   mov R29,R30      ; copy R30 to R29
   Andi R29,0x0F    ; mask lower 4 bits
   LDI R28,0xF7     ; send zero to 4th bit
   OUT PORTD,R28    ; send command to portD to on 4th segmet
   rcall show       ; show number 
   rcall FDelay     ; give delay between to show next number
   ;;;;;;;;;;;;;;
   mov R29,R30       ; copy R30 to R29
   Andi R29,0xF0     ; mask upper  4 bits
   swap R29          ; swipe number
   LDI R28,0xFB      ; send zero to 3rd bit  
   OUT PORTD,R28     ; send command to portD to on 3rd segmet
   rcall show        ; show number 
   rcall FDelay      ; give delay between to show next number
   ;;;;;;;;;;;;;;;;;;;;
   mov R29,R31       ; copy R31 to R29
   Andi R29,0x0F      ; mask lower 4 bits
   LDI R28,0xFD       ; send zero to 2nd bit
   OUT PORTD,R28      ; send command to portD to on 2nd segmet
   rcall show          ; show number 
   rcall FDelay        ; give delay between to show next number
   ;;;;;;;;;;;;;;
   mov R29,R31         ; copy R31 to R29
   Andi R29,0xF0       ; mask upper  4 bits
   swap R29            ; swipe number
   LDI R28,0xFE        ; send zero to 1st bit  
   OUT PORTD,R28       ; send command to portD to on 1st segmet
   rcall show          ; show number 
   rcall FDelay        ; give delay between to show next number
   ////////////////////
  
  LDI R16,0x00         ; clear r16
  LDI R19,0x00         ; clear r19
  LDI R30,0x00         ; clear r30
  LDI R31,0x00         ; clear r31
 LDI R27,0x08          ;count
 LDI R20,0x00          ;R20 addition
 LDI R24,0x00          ; clear r24 
 CBI PORTC,5           ;stop motor
   rjmp Read_ADC
;////////////////////////////////////////////////////////////////////////////////////////////
show:  
cpi R29,0x00           ;compare R29 to 00
brne G1                ; if not zero goto G1 else
LDI R28,0x3F           ; mov number to R28
OUT PORTB,R28          ;show number on PORTB
rjmp finish            ; jump to finish
G1:
cpi R29,0x01           ;compare R29 to 01
brne G2                ; if not zero goto G1 else
LDI R28,0x06            ; mov number to R28
OUT PORTB,R28           ;show number on PORTB
rjmp finish            ; jump to finish
G2:
cpi R29,0x02           ;compare R29 to 02   
brne G3                ; if not zero goto G1 else
LDI R28,0x5B           ; mov number to R28
OUT PORTB,R28          ;show number on PORTB
rjmp finish            ; jump to finish
G3:
cpi R29,0x03           ;compare R29 to 03   
brne G4                ; if not zero goto G1 else
LDI R28,0x4F           ; mov number to R28
OUT PORTB,R28          ;show number on PORTB
rjmp finish            ; jump to finish
G4:
cpi R29,0x04          ;compare R29 to 04
brne G5               ; if not zero goto G1 else
LDI R28,0x66          ; mov number to R28
OUT PORTB,R28         ;show number on PORTB
rjmp finish           ; jump to finish
G5:
cpi R29,0x05        ;compare R29 to 05
brne G6             ; if not zero goto G1 else
LDI R28,0x6D        ; mov number to R28
OUT PORTB,R28       ;show number on PORTB
rjmp finish         ; jump to finish
G6:
  cpi R29,0x06      ;compare R29 to 06
brne G7              ; if not zero goto G1 else
LDI R28,0x7C         ; mov number to R28
OUT PORTB,R28        ;show number on PORTB
rjmp finish           ; jump to finish
G7:
 cpi R29,0x07        ;compare R29 to 07
brne G8              ; if not zero goto G1 else
LDI R28,0x07         ; mov number to R28
OUT PORTB,R28        ;show number on PORTB
rjmp finish           ; jump to finish
G8:
 cpi R29,0x08         ;compare R29 to 08
brne G9               ; if not zero goto G1 else
LDI R28,0x7F          ; mov number to R28
OUT PORTB,R28          ;show number on PORTB
rjmp finish           ; jump to finish
G9:
 cpi R29,0x09        ;compare R29 to 08
brne finish          ; if not zero goto finish else
LDI R28,0x67         ; mov number to R28
OUT PORTB,R28         ;show number on PORTB
finish:
ret

//////////////////////////////////////////
;This subroutine takes the number and checks that either number is greater than 
;5 if greater than 5 add 3 to it else go back;

Check2:
 MOV R16,R30      ;copy the number in R16
 Andi R16,0x0F    ; Mask lower 4 bits
 cpi R16,0x05     ; comapare R16 to 5
 BRSH do_Add2     ; if number is greater than or equal to 5,if higher
 rjmp exit2       ;if lower than exit
 do_Add2:
 LDI R19,0x03     ;add 3 to R19
 Add R16,R19      ; than add r19 and R16
andi R30,0xF0     ;mask upper 4 bits
 or R30,R16       ; add number back via or
exit2:
   ret

//////////////////////////////////////////
;This subroutine takes the number and checks that either number is greater than 
;5 if greater than 5 add 3 to it else go back;

 Check3:
 MOV R16,R30      ;copy the number in R16
 swap R16         ; swap number
 Andi R16,0x0F    ; Mask upper 4 bits
 cpi R16,0x05     ; comapare R16 to 5   
 BRSH do_Add3     ; if number is greater than or equal to 5,if higher
 rjmp exit3       ;if lower than exit
 do_Add3:
 LDI R19,0x03     ;add 3 to R19
 Add R16,R19      ; than add r19 and R16
 swap R16         ; swap number
 andi R30,0x0F    ; mask lower 4 bits
 or R30,R16        ; add number back via or
exit3:
   ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;This routine produces delay which is essential to show
;the number to us on seven segment display

FDelay:
           
	LDI R21,20     ; Add 200 to R21 
T2:	LDI R22,25     ; Add 250 to R25
T3:	NOP            ; do nothoing
	NOP            ; do nothoing
	DEC R22        ; decrement R22
	BRNE T3        ;branch if not equal to t3
	DEC R21        ; decrement R21
	BRNE T2        ;branch if not equal to t2
    RET
///////////////////////
////////////////////
//////////////////
Show_initials:
 LDI R16,0xF7     ; send zero to 4th bit
   OUT PORTD,R16    ; send command to portD to on 4th segmet
   LDI R16,0x77     ; send zero to 4th bit
   OUT PORTB,R16    ; send command to portD to on 4th segmet
   rcall FDelay     ; give delay between to show next number
   ;;
   LDI R16,0xFB     ; send zero to 3rd bit
   OUT PORTD,R16    ; send command to portD to on 3rd segmet
   LDI R16,0x06     ; send zero to 3rd bit
   OUT PORTB,R16    ; send command to portD to on 3rd  segmet
   rcall FDelay     ; give delay between to show next number
   ;;
   LDI R16,0xFD     ; send zero to 2nd bit
   OUT PORTD,R16    ; send command to portD to on 2nd segmet
   LDI R16,0x39     ; send zero to 2nd bit
   OUT PORTB,R16    ; send command to portD to on 2nd segmet
   rcall FDelay     ; give delay between to show next number
   ;;
   LDI R16,0xFE     ; send zero to 1st bit
   OUT PORTD,R16    ; send command to portD to on 1st segmet
   LDI R16,0x77     ; send zero to 1st bit
   OUT PORTB,R16    ; send command to portD to on 1st segmet
   rcall FDelay     ; give delay between to show next number
ret