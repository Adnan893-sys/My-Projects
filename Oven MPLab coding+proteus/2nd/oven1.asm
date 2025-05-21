;******************************************************************************
;   This file is a basic template for creating relocatable assembly code for  *
;   a PIC18F8722. Copy this file into your project directory and modify or    *
;   add to it as needed.                                                      *
;                                                                             *
;   The PIC18FXXXX architecture allows two interrupt configurations. This     *
;   template code is written for priority interrupt levels and the IPEN bit   *
;   in the RCON register must be set to enable priority levels. If IPEN is    *
;   left in its default zero state, only the interrupt vector at 0x008 will   *
;   be used and the WREG_TEMP, BSR_TEMP and STATUS_TEMP variables will not    *
;   be needed.                                                                *
;                                                                             *
;   Refer to the MPASM User's Guide for additional information on the         *
;   features of the assembler and linker.                                     *
;                                                                             *
;   Refer to the PIC18FXX22/XX27 Data Sheet for additional information on the *
;   architecture and instruction set.                                         *
;                                                                             *
;******************************************************************************
;                                                                             *
;    Filename:                                                                *
;    Date:                                                                    *
;    File Version:                                                            *
;                                                                             *
;    Author:                                                                  *
;    Company:                                                                 *
;                                                                             * 
;******************************************************************************
;                                                                             *
;    Files required: P18F8722.INC                                             *
;                                                                             *
;******************************************************************************

	LIST P=18F8722, F=INHX32 ;directive to define processor and file format
	#include <P18F8722.INC>	 ;processor specific variable definitions

;******************************************************************************
;Configuration bits
;Microchip has changed the format for defining the configuration bits, please 
;see the .inc file for futher details on notation.  Below are a few examples.



;   Oscillator Selection:
    CONFIG	OSC = LP             ;LP

;******************************************************************************
;Variable definitions
; These variables are only needed if low priority interrupts are used. 
; More variables may be needed to store other special function registers used
; in the interrupt routines.

		UDATA

WREG_TEMP	RES	1	;variable in RAM for context saving 
STATUS_TEMP	RES	1	;variable in RAM for context saving
BSR_TEMP	RES	1	;variable in RAM for context saving

		UDATA_ACS

EXAMPLE		RES	1	;example of a variable in access RAM

;******************************************************************************
;EEPROM data
; Data to be programmed into the Data EEPROM is defined here

DATA_EEPROM	CODE	0xf00000

		DE	"Test Data",0,1,2,3,4,5

;******************************************************************************
;Reset vector
; This code will start executing when a reset occurs.

RESET_VECTOR	CODE	0x0000

		goto	Main		;go to start of main code

;******************************************************************************
;High priority interrupt vector
; This code will start executing when a high priority interrupt occurs or
; when any interrupt occurs if interrupt priorities are not enabled.

HI_INT_VECTOR	CODE	0x0008

		bra	HighInt		;go to high priority interrupt routine

;******************************************************************************
;Low priority interrupt vector
; This code will start executing when a low priority interrupt occurs.
; This code can be removed if low priority interrupts are not used.

LOW_INT_VECTOR	CODE	0x0018

		bra	LowInt		;go to low priority interrupt routine

;******************************************************************************
;High priority interrupt routine
; The high priority interrupt code is placed here.

		CODE

HighInt:

;	*** high priority interrupt code goes here ***


		retfie	FAST

;******************************************************************************
;Low priority interrupt routine
; The low priority interrupt code is placed here.
; This code can be removed if low priority interrupts are not used.

LowInt:
		movff	STATUS,STATUS_TEMP	;save STATUS register
		movff	WREG,WREG_TEMP		;save working register
		movff	BSR,BSR_TEMP		;save BSR register

;	*** low priority interrupt code goes here ***


		movff	BSR_TEMP,BSR		;restore BSR register
		movff	WREG_TEMP,WREG		;restore working register
		movff	STATUS_TEMP,STATUS	;restore STATUS register
		retfie

;******************************************************************************
;Start of main program
; The main program code is placed here.
R1 equ 0
R2 equ 8
R3 equ 9
P3 equ 0
Q3 equ 0
Copy  equ 0
Copy1  equ 0
Main:

Count  equ 0
County  equ 0
Count1 equ 1
Count2 equ 2
Count3 equ 3
Count4 equ 4
Limit  equ 5
Limit1  equ 6
Limit2  equ 0x0A
comp  equ   0x8
comp1  equ  0x3
Check  equ 0x4
Check1 equ 0x5
Check2 equ 0x6
Check3 equ 0x7
Limit3  equ 0x08
Limit4  equ 0x09

NUM   equ 0x3
    movlw 0x0A
    movwf Limit
    movlw 0x03
    movwf Limit1
    movlw 0x0A
    movwf Limit2
    movlw 0x0B
    movwf Limit3
    movlw 0x01
    movwf Limit4
    movlw 0x01
    movwf County
   
    
  
   
  


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;macro for copying immediate value  to some port 
SEND MACRO K,REG
      MOVLW K
      MOVWF REG
      ENDM
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;macro for copying variable to some port
MOVLF MACRO K,REG
      MOVF K,W
      MOVWF REG
      ENDM
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     
     CLRF TRISC
     CLRF TRISE
     CLRF TRISF
     CLRF TRISG
     CLRF TRISH
     CLRF TRISJ
     CLRF TRISA
     SETF TRISD
     CALL PWR_SET
     movlw 0x00
     movwf R1
     movlw 0x00
     movwf R2
     movlw 0x00
     movwf R3


h1   BTFSC PORTD,7
     bra G1
     BTFSC PORTD,4
     bra Add_10SEC
     BTFSC PORTD,5
     bra Add_1MINT
     BTFSC PORTD,6
     bra Add_10MINT
     bra h1
G1
     BTFSS PORTC,4
     bra G1
     bsf PORTJ,0
     bsf PORTJ,1
     bsf PORTA,0
     bsf PORTA,1
     bsf PORTC,5
   ;  call Change1
     call  Change2
     CLRF PORTE
     CLRF PORTF
     CLRF PORTG
     CLRF PORTH
     bsf PORTA,1
     bsf PORTA,0
     bcf PORTC,5
     bsf PORTJ,1
     bsf PORTJ,0
     bsf PORTC,6
rem  bra rem
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Change2
     call Change1
     movf R2,W
     movwf Check1
     cpfseq Limit4
     bra ze
     bra go

ze  
      decf Check1,F
back1 movf Check1,W
     movwf PORTF
     call Change1
     movlw 0x06
     movwf R1
     call Change1
     DECF Check1,F
     BNZ back1
go   
     movlw 0x00
     movwf PORTF
     movlw 0x06
     movwf R1
    call Change1
    return
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Change1
     movf R1,W
     movwf Check
     cpfseq Limit3
     bra do
     bra one_time
do  
     decf Check,F
back movf Check,W
     movwf PORTG
     call Change
     DECF Check,F
     BNZ back
one_time
     movlw 0x00
     movwf PORTG
     call Change
     return 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;     
Change   
     Movlw 0x0A
     movwf Q3
     movlw 0x00
     movwf comp
L1   decf Q3,F
     movf Q3,W
     movwf PORTH
     cpfseq comp
     bra disp
     bra exit
disp 
     call Delay_1s
     movwf PORTH
     bra L1  
exit 
    movlw 0x00
    movwf PORTH
    call Delay_1s
    return  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    
Add_10SEC
     call Delay_200ms
     BTFSS PORTD,4
     bra h1
     movlw 0x00
     movf R1,W
     addlw 0x01
     movwf R1
     movwf PORTG
     CPFSGT Limit
     bra zero 
     bra h1
zero
     movlw 0x00
     movwf R1
     movwf PORTG
     bra h1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Add_1MINT
     call Delay_200ms
     BTFSS PORTD,5
     bra h1
     movlw 0x00
     movf R2,W
     addlw 0x01
     movwf R2
     movwf PORTF
     CPFSGT Limit2
     bra zero2 
     bra h1
zero2
     movlw 0x00
     movwf R2
     movwf PORTF
     bra h1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Add_10MINT
     call Delay_200ms
     BTFSS PORTD,6
     bra h1
     movf R3,W
     addlw 0x01
     movwf R3
     movwf PORTE
     CPFSGT Limit1
     bra zero1 
     bra h1
zero1
     movlw 0x00
     movwf R3
     movwf PORTE
     bra h1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PWR_SET
here MOVF PORTD,W 
     CPFSLT Count
     bra here               
     movwf PORTC
     RETURN
     
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Delay_1s
       MOVLW D'5'
       MOVWF Count1
       MOVLW 0x30          ;1:8 PRESCALAR
       MOVWF T1CON
RE     MOVLW 0x0B      
       MOVWF TMR1H
       MOVLW 0xDC      
       MOVWF TMR1L
       BCF PIR1,TMR1IF     ;clear timer interupt flag
       BSF T1CON,TMR1ON
Again  BTFSS PIR1,TMR1IF
       BRA Again
       BCF PIR1,TMR1ON
       DECF Count1,F
       BNZ RE
       RETURN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Delay_10s
       MOVLW D'10'
       MOVWF Count4
UP2    CALL Delay_1s
       DECF Count4,F
       BNZ UP2
       RETURN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Delay_1mint
       MOVLW D'60'
       MOVWF Count2
UP     CALL Delay_1s
       DECF Count2,F
       BNZ UP
       RETURN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;   
Delay_10mint 
       MOVLW D'10'
       MOVWF Count3
UP1    CALL Delay_1mint
       DECF Count3,F
       BNZ UP1
       RETURN  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Delay_200ms
       MOVLW 0x30          ;1:8 PRESCALAR
       MOVWF T1CON
       MOVLW 0x0B      
       MOVWF TMR1H
       MOVLW 0xDD     
       MOVWF TMR1L
       BCF PIR1,TMR1IF     ;clear timer interupt flag
       BSF T1CON,TMR1ON
Again1  BTFSS PIR1,TMR1IF
       BRA Again1
       BCF PIR1,TMR1ON
       RETURN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
       
      END
