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
RESET_VECTOR    CODE    0x0000       ; processor reset vector

        goto    main                ; go to beginning of program

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

main

status equ 0x003
PORTC equ 0x007
PORTB equ 0x006
PORTA equ 0x005
TRISA equ 0x085
TRISB equ 0x086
TRISC equ 0x087
PCL equ 0x02


;table   addwf PCL,f
        ;DT 0x3F,0x06,0x5B,0x4F,0x66,0x6D,0x7D,0x07,0x7F,0x67   

R1 equ 0x20      
R2 equ 0x21
R3 equ 0x22

T1 equ 0x24
num1 equ 0x25
num2 equ 0x26
copy equ 0x27
copy1 equ 0x29
copy2 equ 0x30
num3 equ 0x31
x    equ 0x32
counter equ 0x28
         movlw 0x00
         movwf counter

          bsf status,RP0     ;select bank1 
          MOVLW 0x00         ;load 0 to W
          MOVWF TRISC        ;PORTC AS output
          bcf status,RP0     ;Select bank0

          BCF STATUS,RP0     ;Bank 0
          BCF STATUS,RP1     ;
          Movlw 0xFF         ;make all pins of PORTB as HIGH
          movwf  PORTB       ;Init PORTB
          BSF STATUS,RP0     ;Bank 1
          MOVLW 0xC0         ;Set RB<7:6> as inputs
          MOVWF TRISB ;      ;set PORTB
          BCF STATUS,RP0     ;Bank 0
   
L1:
          CLRF PORTC            ;Clear PORTC
          CLRW                  ;clear Wreg
Again     BTFSC PORTB,6         ;check Up Button if pressed
          goto Check_second     ;if not pressed check 2nd button
          movlw D'13'           ;load W=13
          movwf x               ;save  that value to x
TE1       Call S_delay          ;call delay
          call Display          ;Display during debouncing
          decf x,f              ;decrement x
          Bnz TE1               ;if x is not zero go back
          BTFSS PORTB,6         ;chcek if button is pressed long
          goto Again            ; goto again
          incf counter,f        ; increment counter
          movf counter,w        ; load that counter to W
          xorlw 0x64            ;comapre that counter with 99(0x64)
          bz make_zero          ;if counter became 99 then branch
          goto show             ;else show number
make_zero
          movlw 0x00            ;mov 0 to W
          movwf counter         ;make counter to 0 if it becane 99
          goto show             ;then show number
          
Check_second
          BTFSC PORTB,7          ;check Down Button if pressed
          goto show              ;else show number
          movlw D'13'            ;load W=13  
          movwf x                ;save  that value to x
TE2       Call S_delay           ;call delay
          call Display           ;Display during debouncing
          decf x,f               ;decrement x
          Bnz TE2                ;if x is not zero go back
          BTFSS PORTB,7          ;chcek if button is pressed long
          goto Check_second      ; goto check_second
          decf counter,f         ; increment counter
          movf counter,w         ; load that counter to W
          xorlw 0x00             ;comapre that counter with 00(0x00)
          bz make_ninty_nine     ;if counter became 00 then branch
          goto show              ;then show number
make_ninty_nine
          movlw 0x63             ;mov 0 to W
          movwf counter          ;make counter to 99 if it became 00
          goto show              ;then show number
show
       
        movf counter,w           ;mov counter to W register
        movwf copy               ; also save its copy in copy variable
        clrc                     ; clear carry 
        movlw 0x00               ; move 0 to W register
        movwf num3               ; 0 to num3 to clear it
        call make_number         ; call make_number subroutine
        call Display             ;call dislay subraotine
        goto Again               ; again check both buttons status


make_number
        movf copy,w             ;load copy variab;e to W register
        movwf copy1             ;also save one copy in copy1 variable
back    movlw 0x0A              ;load 10 to w  
 
         subwf copy1,w          ;subtract 10 from the number
         btfss status,C         ;if carry is set skip next instruction
         goto less              ;else gotor less label 
         incf num3,f            ;increment num3  
         movwf copy1            ;update copy1 variable by W
         xorlw 0x09             ;check if 09 reamined in copy1
         bz less                ;if yes branch to less label

         movf copy1,w           ;load copy1 in W
         xorlw 0x08             ;check if 08 reamined in copy1          
         bz less                ;if yes branch to less label

         movf copy1,w           ;load copy1 in W
         xorlw 0x07             ;check if 07 reamined in copy1
         bz less                ;if yes branch to less label

         movf copy1,w           ;load copy1 in W
         xorlw 0x06             ;check if 06 reamined in copy1
         bz less                ;if yes branch to less label

         movf copy1,w           ;load copy1 in W
         xorlw 0x05             ;check if 05 reamined in copy1
         bz less                ;if yes branch to less label

         movf copy1,w           ;load copy1 in W
         xorlw 0x04             ;check if 04 reamined in copy1
         bz less                ;if yes branch to less label

         movf copy1,w           ;load copy1 in W
         xorlw 0x03             ;check if 03 reamined in copy1
         bz less                ;if yes branch to less label

         movf copy1,w           ;load copy1 in W
         xorlw 0x02             ;check if 02 reamined in copy1
         bz less                ;if yes branch to less label

         movf copy1,w           ;load copy1 in W
         xorlw 0x01             ;check if 01 reamined in copy1
         bz less                ;if yes branch to less label
        
         movf copy1,w           ;load copy1 in W
         xorlw 0x00             ;check if 00 reamined in copy1
         bz less                ;if yes branch to less label
         goto back              ;else go back to subtract next
         
less
        Return                  ;return from subrotine
          
Display        
          Bcf PORTB,4           ;s1 on
          Bsf PORTB,5           ;s2 off
          movf num3,w           ;load number to W       
          call table            ;load number from table
          Movwf PORTC           ;load respective number to PORTC
          Call Delay            ;call delay to show number on 1st 7seg
         
          Bsf PORTB,4           ;s1 off
          Bsf PORTB,5           ;s2 off
          call S_delay          ;off both digits and give short delay      
          
         Bsf PORTB,4            ;s2 on   
         Bcf PORTB,5            ;s1 off
         movf copy1,w           ;load number to W    
         call table             ;load number from table
         Movwf PORTC            ;load respective number to PORTC
         Call Delay             ;call delay to show number on 2nd 7seg

          Return                ;return from subrotine
         
table  
         addwf PCL,f            ;add PCL with wreg 
         retlw 0x3F             ;0     
         retlw 0x06             ;1
         retlw 0x5B             ;2
         retlw 0x4F             ;3
         retlw 0x66             ;4
         retlw 0x6D             ;5
         retlw 0x7D             ;6
         retlw 0x07             ;7
         retlw 0x7F             ;8
         retlw 0x67             ;9         

S_delay
          MOVLW D'70'           ;load 70 to Wreg
          MOVWF R2              ;load W to R2
T2        MOVLW D'100'          ;load 100 to Wreg
          MOVWF R3              ;load W to R3
T3        
          NOP                   ;do nothing
          NOP                   ;do nothing
          DECF R3,F             ;decrement R3
          BNZ T3                ;branch to T3 if not 0
          DECF R2,F             ;decrement R2
          BNZ T2                ;branch to T2 if not 0
          Return                ;return from subrotine

Delay
          MOVLW D'1'            ;load 1 to Wreg  
          MOVWF R1              ;load W to R2
D1        MOVLW D'35'           ;load 35 to Wreg 
          MOVWF R2              ;load W to R2
D2        MOVLW D'12'           ;load 12 to Wreg  
          MOVWF R3              ;load W to R2
D3        
          NOP                   ;do nothing
          NOP                   ;do nothing
          DECF R3,F             ;decrement R3
          BNZ D3                ;branch to D3 if not 0
          DECF R2,F             ;decrement R2
          BNZ D2                ;branch to D2 if not 0
          DECF R1,F             ;decrement R1
          BNZ D1                ;branch to D1 if not 0
          Return                ;return from subrotine
           END                       