;**********************************************************************
;   This file is a basic code template for object module code         *
;   generation on the PIC16F690. This file contains the               *
;   basic code building blocks to build upon.                         *
;                                                                     *
;   Refer to the MPASM User's Guide for additional information on     *
;   features of the assembler and linker (Document DS33014).          *
;                                                                     *
;   Refer to the respective PIC data sheet for additional             *
;   information on the instruction set.                               *
;                                                                     *
;**********************************************************************
;                                                                     *
;    Filename:      xxx.asm                                           *
;    Date:                                                            *
;    File Version:                                                    *
;                                                                     *
;    Author:                                                          *
;    Company:                                                         *
;                                                                     *
;                                                                     *
;**********************************************************************
;                                                                     *
;    Files required: P16F690.INC                                      *
;                                                                     *
;                                                                     *
;                                                                     *
;**********************************************************************
;                                                                     *
;    Notes:                                                           *
;                                                                     *
;                                                                     *
;                                                                     *
;                                                                     *
;**********************************************************************

    list      p=16F690           ; list directive to define processor
    #include <p16F690.inc>        ; processor specific variable definitions

    errorlevel  -302              ; suppress message 302 from list file

    __CONFIG   _CP_OFF & _CPD_OFF & _BOR_OFF & _MCLRE_ON & _WDT_OFF & _PWRTE_ON & _INTRC_OSC_NOCLKOUT & _FCMEN_OFF & _IESO_OFF 

; '__CONFIG' directive is used to embed configuration word within .asm file.
; The lables following the directive are located in the respective .inc file.
; See data sheet for additional information on configuration word settings.

;***** VARIABLE DEFINITIONS (examples)

; example of using Shared Uninitialized Data Section
INT_VAR     UDATA_SHR     
w_temp      RES     1       ; variable used for context saving 
status_temp RES     1       ; variable used for context saving
pclath_temp RES     1       ; variable used for context saving

;**********************************************************************
RESET_VECTOR    CODE    0x0000       ; processor reset vector        goto    main                ; go to beginning of program

INT_VECTOR      CODE    0x0004       ; interrupt vector location

INTERRUPT

        movwf   w_temp            ; save off current W register contents
        movf    STATUS,w          ; move status register into W register
        movwf   status_temp       ; save off contents of STATUS register
        movf    PCLATH,w          ; move pclath register into W register
        movwf   pclath_temp       ; save off contents of PCLATH register



; isr code can go here or be located as a call subroutine elsewhere


        movf    pclath_temp,w     ; retrieve copy of PCLATH register
        movwf   PCLATH            ; restore pre-isr PCLATH register contents
        movf    status_temp,w     ; retrieve copy of STATUS register
        movwf   STATUS            ; restore pre-isr STATUS register contents
        swapf   w_temp,f
        swapf   w_temp,w          ; restore pre-isr W register contents
        retfie                    ; return from interrupt

MAIN_PROG       CODE





        
; initialize eeprom locations

EE      CODE    0x2100
        DE  0x00, 0x01, 0x02, 0x03




main

status equ 0x003
PORTC equ 0x007
PORTB equ 0x006
PCL equ 0x02




R1 equ 0x20
R2 equ 0x21
R3 equ 0x22
;Count equ 0x23


;B1 equ 0x23
;B2 equ 0x24
;S1 equ 0x25
;S2 equ 0x26
          bsf status,RP0
          Bsf TRISB,6  ;Up Button
          Bsf TRISB,7  ;Down button
          Bcf TRISB,4  ;s1
          Bcf TRISB,5  ;s2
          MOVLW 0x00
          MOVWF TRISC        ;PORTC AS output

          bcf status,RP0
L1:
          CLRF PORTC     
Again     BTFSC PORTB,6   ;check Up Button if pressed
          goto Check_second      
          ;Call Show_number
          Call One
          goto L1
Check_second
          BTFSC PORTB,7   ;check Down Button if pressed
          goto L1
          Call Two
         Call Show_number1
           goto L1


Delay
          MOVLW D'10'
          MOVWF R1
D1        MOVLW D'250'
          MOVWF R2
D2        MOVLW D'250'
          MOVWF R3
D3        
          NOP
          NOP
          DECF R3,F
          BNZ D3
          DECF R2,F
          BNZ D2
          DECF R1,F
          BNZ D1
          Return
One
          MOVLW 0x06
          MOVWF PORTC
          Return   
Two
          MOVLW 0x5B
          MOVWF PORTC
          Return 
Three
          MOVLW 0x4F
          MOVWF PORTC
          Return     
Four
          MOVLW 0x66
          MOVWF PORTC
          Return  
Five
          MOVLW 0x6D
          MOVWF PORTC
          Return  
Six
          MOVLW 0x7D
          MOVWF PORTC
          Return 
Seven
          MOVLW 0x07
          MOVWF PORTC
          Return
Eight
          MOVLW 0x7F
          MOVWF PORTC
          Return   
Nine
          MOVLW 0x67
          MOVWF PORTC
          Return  
Zero
          MOVLW 0x3F
          MOVWF PORTC
          Return        
Show_number
          Bcf PORTB,4  ;s1 on
          Bsf PORTB,5  ;s2 off
          Call Seven
          Call S_delay
          Bsf PORTB,4  ;s1 off
          Bcf PORTB,5  ;s2 on
          Call One
          Call S_delay
          Return
Show_number1
          Bcf PORTB,4  ;s1 on
          Bsf PORTB,5  ;s2 off
          Call Five
          Call S_delay
          Bsf PORTB,4  ;s1 off
          Bcf PORTB,5  ;s2 on
          Call Two
          Call S_delay
          Return

          



S_delay
          
          MOVLW D'10'
          MOVWF R2
T2        MOVLW D'10'
          MOVWF R3
T3        
          NOP
          NOP
          DECF R3,F
          BNZ T3
          DECF R2,F
          BNZ T2
          Return



          
          END                       ; directive 'end of program'