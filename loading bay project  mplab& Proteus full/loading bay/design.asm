;******************************************************************************
;                                                                             *
;   This file is a basic code template for code generation on the             *
;   PIC18F45K20. This file contains the basic code building blocks to build   *
;   upon.                                                                     *
;                                                                             *
;   Refer to the MPASM User's Guide for additional information on features    *
;   of the assembler.                                                         *
;                                                                             *
;   Refer to the respective data sheet for additional information on the      *
;   instruction set.                                                          *
;                                                                             *
;******************************************************************************
;                                                                             *
;    Filename:         xxx.asm                                                *
;    Date:                                                                    *
;    File Version:                                                            *
;    Author:                                                                  *
;    Company:                                                                 *
;                                                                             *
;******************************************************************************
;                                                                             *
;    Files Required:                                                          *
;                                                                             *
;******************************************************************************
;                                                                             *
;    Notes:                                                                   *
;                                                                             *
;******************************************************************************
;                                                                             *
;    Revision History:                                                        *
;                                                                             *
;******************************************************************************

;------------------------------------------------------------------------------
; PROCESSOR DECLARATION
;------------------------------------------------------------------------------

     LIST      P=PIC18F45K20          ; list directive to define processor
     #INCLUDE <P18F45K20.INC>         ; processor specific variable definitions

;------------------------------------------------------------------------------
;
; CONFIGURATION WORD SETUP
;
; The 'CONFIG' directive is used to embed the configuration word within the 
; .asm file. The lables following the directive are located in the respective 
; .inc file.  See the data sheet for additional information on configuration 
; word settings.
;
;------------------------------------------------------------------------------

     CONFIG FOSC = INTIO7, FCMEN = OFF, IESO = OFF, PWRT = OFF, BOREN = OFF
     CONFIG BORV = 18, WDTEN = OFF, WDTPS = 1, MCLRE = ON, HFOFST = ON
     CONFIG LPT1OSC = OFF, PBADEN = OFF, CCP2MX = PORTC, STVREN = OFF
     CONFIG LVP = OFF,  XINST = OFF, CP0 = OFF, CP1 = OFF, CP2 = OFF
     CONFIG CP3 = OFF, CPB = OFF, CPD = OFF, WRT0 = OFF, WRT1 = OFF
     CONFIG WRT2 = OFF, WRT3 = OFF, WRTB = OFF, WRTC = OFF, WRTD = OFF
     CONFIG EBTR0 = OFF, EBTR1 = OFF, EBTR2 = OFF, EBTR3 = OFF
     CONFIG EBTRB = OFF

;------------------------------------------------------------------------------
;
; VARIABLE DEFINITIONS
;
;------------------------------------------------------------------------------

    CBLOCK 0x60 ; Sample GPR variable register allocations
        MYVAR1  ; user variable at address 0x60
        MYVAR2  ; user variable at address 0x61
        MYVAR3  ; user variable at address 0x62
    ENDC

W_TEMP         EQU        0x000  ; w register for context saving (ACCESS)
STATUS_TEMP    EQU        0x001  ; status used for context saving 
BSR_TEMP       EQU        0x002  ; bank select used for ISR context saving

;------------------------------------------------------------------------------
; EEPROM INITIALIZATION
;
; The 18F45K20 has non-volatile EEPROM starting at 0xF00000
; 
;------------------------------------------------------------------------------

DATAEE    ORG  0xF00000 ; Starting address for EEPROM for 18F45K20

    DE    "MCHP"        ; Place 'M' 'C' 'H' 'P' at address 0,1,2,3

;------------------------------------------------------------------------------
; RESET VECTOR
;------------------------------------------------------------------------------

RES_VECT  ORG     0x0000            ; processor reset vector
          GOTO    main            ; go to beginning of program

;------------------------------------------------------------------------------
; HIGH PRIORITY INTERRUPT VECTOR
;------------------------------------------------------------------------------

ISRH      ORG     0x0008

          ; Run the High Priority Interrupt Service Routine
          GOTO    HIGH_ISR             

;------------------------------------------------------------------------------
; LOW PRIORITY INTERRUPT VECTOR
;------------------------------------------------------------------------------

ISRL      ORG     0x0018
          
          ; Run the High Priority Interrupt Service Routine
          GOTO    LOW_ISR             

;------------------------------------------------------------------------------
; HIGH PRIORITY INTERRUPT SERVICE ROUTINE
;------------------------------------------------------------------------------

HIGH_ISR  

          ; Insert High Priority ISR Here

          RETFIE  FAST

;------------------------------------------------------------------------------
; LOW PRIORITY INTERRUPT SERVICE ROUTINE
;------------------------------------------------------------------------------

LOW_ISR
          ; Context Saving for Low ISR
          MOVWF   W_TEMP              ; save W register
          MOVFF   STATUS, STATUS_TEMP ; save status register
          MOVFF   BSR, BSR_TEMP       ; save bankselect register

          ; Insert Low Priority ISR Here

          ; Context Saving for Low ISR
          MOVFF   BSR_TEMP, BSR       ; restore bankselect register
          MOVF    W_TEMP, W           ; restore W register
          MOVFF   STATUS_TEMP, STATUS ; restore status register
          RETFIE

;------------------------------------------------------------------------------
; MAIN PROGRAM
;------------------------------------------------------------------------------

main
 ;   #INCLUDE P18F45K20.INC
    R1 equ 0x1
    R2 equ 0x2
    R3 equ 0x3
    R4 equ 0x4
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;macro for copying variable to some port 
SEND MACRO K,REG
      MOVLW K
      MOVWF REG
      ENDM
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; macro for copying immediate valueto the port
MOVLF MACRO K,REG
      MOVF K,W
      MOVWF REG
      ENDM
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

      CLRF TRISB         ; make portb as output
      CLRF TRISC         ; make port c as output
      BSF  TRISD,7       ; clear pin for ir sensor
      BCF  TRISD,6       ;set pin for buzzer
      BSF  TRISD,5       ;set pin for operater indication
      MOVLF 0,R3         ; macro call for moving 0 to R3
L2    CALL STARTMOTOR    ; start  motor
      BTFSS PORTD,7      ;check for high
      BRA L2             ; branch to L2 if low
      MOVLF R3,PORTC     ;mov R3 to portc to show on 7 segment
      INCF R3,F          ; increment F
      CALL QDELAY        ; take delay
      MOVLW D'10'        ; limit for bin(10-1)
      CPFSLT R3          ;if R3 becomes 9 then mov to L3
      BRA L3
      BRA L2             ; if R3<9 mov to L2
L3    
      BSF PORTD,6        ; make buzzer high
      BTFSS PORTD,5      ; check for operater bin change 
      BRA L4             ; if button pressed goto L4
      BRA L3             ;else continue ringing buzzer
L4                   
     BCF PORTD,6         ; Stop buzzer
     SEND 0,PORTC        ;set  0 to PortC
     SEND 0,R3           ; Clear R3
     BRA L2
     
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;This subroutine is for creating delay
QDELAY
    MOVLW D'100'
    MOVWF R1
D1  MOVLW D'100'
    MOVWF R2
D2  NOP
    NOP 
    DECF R2,F
    BNZ D2
    DECF R1,F
    BNZ D1
    RETURN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; This is for speed for stepper motor
SPEED
    MOVLW D'100'
    MOVWF R1
Z1  MOVLW D'100'
    MOVWF R2
Z2  NOP
    NOP 
    DECF R2,F
    BNZ Z2
    DECF R1,F
    BNZ Z1
    RETURN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; this is for stating stepper motor
STARTMOTOR
       SEND  0x66,PORTB  
       CALL SPEED
       SEND  0x33,PORTB  
       CALL SPEED
       SEND  0x99,PORTB  
       CALL SPEED
       SEND  0xCC,PORTB  
       CALL SPEED
      
      RETURN
      END
      

