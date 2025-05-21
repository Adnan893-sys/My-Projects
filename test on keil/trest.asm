; put data in RAM
    MOV 30H, #'1'
	MOV 31H, #'C'
	MOV 32H, #'A'
  	MOV 33H, #'K'
	MOV 34H, #'E'
	MOV 35H, #' '	
    MOV 36H, #'6'
    MOV 37H, #'$'
    MOV 38H, #' '	
    MOV 39H, #'2'
	MOV 3AH, #'C'
	MOV 3BH, #'A'
  	MOV 3CH, #'N'
    MOV 3DH, #' '	
    MOV 3EH, #'5'
    MOV 3FH, #'$'
    MOV 40H, #'t'
	MOV 41H, #0	; end of data marker
    MOV 42H, #'3'
	MOV 43H, #'M'
	MOV 44H, #'i'
  	MOV 45H, #'l'
	MOV 46H, #'k'
	MOV 47H, #' '	
    MOV 48H, #'4'
    MOV 49H, #'$'
    MOV 4AH, #' '	
    MOV 4BH, #'4'
	MOV 4CH, #'T'
	MOV 4DH, #'e'
  	MOV 4EH, #'a'
    MOV 4FH, #' '	
    MOV 50H, #'3'
    MOV 51H, #'$'
	MOV 52H, #0	; end of data marker
    MOV 53H, #'I'
    MOV 54H, #'n'
    MOV 55H, #'s'
    MOV 56H, #'e'
    MOV 57H, #'r'
    MOV 58H, #'t'
    MOV 59H, #0
    MOV 5AH, #' '
    MOV 5BH, #0
    MOV 5AH, #' '
 MOV 5BH, #' '
 MOV 5CH, #' '
 MOV 5DH, #' '
 MOV 5EH, #' '
 MOV 5FH, #' '
 MOV 60H, #' '
 MOV 61H, #' '
 MOV 62H, #' '
 MOV 63H, #' '
 MOV 64H, #' '
 MOV 65H, #' '
 MOV 66H, #' '
 MOV 67H, #' '
 MOV 68H, #' '
 MOV 69H, #' '
 MOV 6AH, #0

   


Again_do:
	CLR P1.3		; clear RS - indicates that instructions are being sent to the module

    Acall FuncSet
    Acall DispCon
    Acall EntryMode

; send data
	SETB P1.3		; clear RS - indicates that data is being sent to module
  
	MOV R1, #30H		; data to be sent to LCD is stored in 8051 RAM, starting at location 30H
loop:
	MOV A, @R1		; move data pointed to by R1 to A
	JZ next	; if A is 0, then end of data has been reached - jump out of loop
	CALL sendCharacter	; send data in A to LCD module
	INC R1			; point to next piece of data
	JMP loop		; repeat

next:
  	
    Acall CursorPos
    SETB P1.3	
	MOV R1, #42H		; data to be sent to LCD is stored in 8051 RAM, starting at location 30H
loop1:
	MOV A, @R1		; move data pointed to by R1 to A
	JZ Next1	; if A is 0, then end of data has been reached - jump out of loop
	CALL sendCharacter	; send data in A to LCD module
	INC R1			; point to next piece of data
	JMP loop1		; repeat
 Next1:	
	Call ScanKeyPad
            Acall CursorPos1
			SetB P1.3				; RS=1 - Data register is selected. 
				
			Clr A
          
			Mov A,R7
			Call sendCharacter		;Display the key that is pressed.
     SETB P1.3	
	MOV R1, #53H		; data to be sent to LCD is stored in 8051 RAM, starting at location 30H
loop2:
	MOV A, @R1		; move data pointed to by R1 to A
	JZ go	; if A is 0, then end of data has been reached - jump out of loop
	CALL sendCharacter	; send data in A to LCD module
	INC R1			; point to next piece of data
	JMP loop2 	; repeat
go:
Mov A,R7
CJNE A,#'1',OV1         ;jump if A is not 1
Mov A,#'6'
SJMP OV4
OV1:
CJNE A,#'2',OV2         ;jump if A is not 2
Mov A,#'5'
SJMP OV4
OV2:
CJNE A,#'3',OV3         ;jump if A is not 3
Mov A,#'4'
SJMP OV4
OV3:
CJNE A,#'4',OV4         ;jump if A is not 3
Mov A,#'3'
OV4:
Mov R6,A 
;;;;;;;;;;;;;;;;;;;;;;;;;;;add space;;;;;;;;;;;
  Mov A, #' '
  Call sendCharacter	 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  Mov A, R6
  Call sendCharacter	
  Mov A, #'$'
  Call sendCharacter	
   Mov A, #' '
  Call sendCharacter	
  Mov A,# 'C'
  Call sendCharacter	
  Mov A, # 'o'
  Call sendCharacter	
  Mov A, #'i'
  Call sendCharacter	
  Mov A, #'n'
  Call sendCharacter	
  Acall CursorPos
 SETB P1.3	
	MOV R1, #5BH		; data to be sent to LCD is stored in 8051 RAM, starting at location 30H
loop3:
	MOV A, @R1		; move data pointed to by R1 to A
	JZ h1	; if A is 0, then end of data has been reached - jump out of loop
	CALL sendCharacter	; send data in A to LCD module
	INC R1			; point to next piece of data
	JMP loop3 	; repeat
    
h1:
    Acall CursorPos   
    	Call ScanKeyPad  
        SetB P1.3				; RS=1 - Data register is selected. 
				
		Clr A
       	Mov A,R7
		Call sendCharacter		;Display the key that is pressed.   

Mov A,R6
SUBB A,R7
JNZ ED
Setb p3.1
clr p3.0
Acall DELAY_1s
clr p3.1
clr p3.0
ED:   
jmp Again_do
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DELAY_1s:
 
MOV R2,#20 
RE1:MOV R3,#150 
RE: NOP 
NOP 
DJNZ R3,RE 
DJNZ R2,RE1 

RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CursorPos:
      Clr p1.3    ;RS
      setb P1.7
      setb P1.6
      Clr p1.5
      Clr p1.4
  
      call Pulse
      Clr P1.7
      Clr P1.6
      Clr p1.5
      Clr p1.4
      call Pulse
	  CALL delay	
 Ret
Clear:
      Clr p1.3    ;RS
      Clr P1.7
      Clr P1.6
      Clr p1.5
      Clr p1.4
  
      call Pulse
      Clr P1.7
      Clr P1.6
      Clr p1.5
      Clr p1.4
      call Pulse
	  CALL delay	
 Ret
CursorPos1:
      Clr p1.3    ;RS
      setb P1.7
      CLR P1.6
      Clr p1.5
      Clr p1.4
  
      call Pulse
      Clr P1.7
      Clr P1.6
      Clr p1.5
      Clr p1.4
      call Pulse
	  CALL delay	
 Ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

FuncSet:
; function set	
	CLR P1.7		; |
	CLR P1.6		; |
	SETB P1.5		; |
	CLR P1.4		; | high nibble set ;;;;;

	SETB P1.2		; |
	CLR P1.2		; | negative edge on E

	CALL delay		; wait for BF to clear	
				; function set sent for first time - tells module to go into 4-bit mode
; Why is function set high nibble sent twice? See 4-bit operation on pages 39 and 42 of HD44780.pdf.

	SETB P1.2		; |
	CLR P1.2		; | negative edge on E
				; same function set high nibble sent a second time

	SETB P1.7		; low nibble set (only P1.7 needed to be changed)

	SETB P1.2		; |
	CLR P1.2		; | negative edge on E
				; function set low nibble sent
	CALL delay		; wait for BF to clear

Ret
;;;;;;;;;;;;;;;;;;;;;;; set to increment with no shift
EntryMode:
	CLR P1.7		; |
	CLR P1.6		; |
	CLR P1.5		; |
	CLR P1.4		; | high nibble set

	Acall Pulse

	SETB P1.6		; |
	SETB P1.5		; |low nibble set
    Acall Pulse
	CALL delay		; wait for BF to clear
Ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DispCon:
	CLR P1.7		; |
	CLR P1.6		; |
	CLR P1.5		; |
	CLR P1.4		; | high nibble set
    Acall Pulse

	SETB P1.7		; |
	SETB P1.6		; |
	SETB P1.5		; |
	SETB P1.4		; | low nibble set
    Acall Pulse
    CALL delay		; wait for BF to clear
Ret
;;;;;;;;;;;;;;;;;;;;
Pulse:
	SETB P1.2		; |
	CLR P1.2		; | negative edge on E
Ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
sendCharacter:
	MOV C, ACC.7		; |
	MOV P1.7, C		; |
	MOV C, ACC.6		; |
	MOV P1.6, C		; |
	MOV C, ACC.5		; |
	MOV P1.5, C		; |
	MOV C, ACC.4		; |
	MOV P1.4, C		; | high nibble set

	SETB P1.2		; |
	CLR P1.2		; | negative edge on E

	MOV C, ACC.3		; |
	MOV P1.7, C		; |
	MOV C, ACC.2		; |
	MOV P1.6, C		; |
	MOV C, ACC.1		; |
	MOV P1.5, C		; |
	MOV C, ACC.0		; |
	MOV P1.4, C		; | low nibble set

	SETB P1.2		; |
	CLR P1.2		; | negative edge on E

	CALL delay		; wait for BF to clear

delay:
	MOV R0, #50
	DJNZ R0, $
	RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ScanKeyPad:	CLR P0.3			;Clear Row3
			CALL IDCode0		;Call scan column subroutine
			SetB P0.3			;Set Row 3
			JB F0,Done  		;If F0 is set, end scan 
						
			;Scan Row2
			CLR P0.2			;Clear Row2
			CALL IDCode1		;Call scan column subroutine
			SetB P0.2			;Set Row 2
			JB F0,Done		 	;If F0 is set, end scan 						

			;Scan Row1
			CLR P0.1			;Clear Row1
			CALL IDCode2		;Call scan column subroutine
			SetB P0.1			;Set Row 1
			JB F0,Done			;If F0 is set, end scan

			;Scan Row0			
			CLR P0.0			;Clear Row0
			CALL IDCode3		;Call scan column subroutine
			SetB P0.0			;Set Row 0
			JB F0,Done			;If F0 is set, end scan 
														
			JMP ScanKeyPad		;Go back to scan Row3
							
Done:		Clr F0		        ;Clear F0 flag before exit
			Ret
;--------------------------------------------------------------------------------			
;---------------------------- Scan column subroutine ----------------------------
IDCode0:	JNB P0.4, KeyCode03	;If Col0 Row3 is cleared - key found
			JNB P0.5, KeyCode13	;If Col1 Row3 is cleared - key found
			JNB P0.6, KeyCode23	;If Col2 Row3 is cleared - key found
			RET					

KeyCode03:	SETB F0			;Key found - set F0
			Mov R7,#'3'		;Code for '3'
			RET				

KeyCode13:	SETB F0			;Key found - set F0
			Mov R7,#'2'		;Code for '2'
			RET				

KeyCode23:	SETB F0			;Key found - set F0
			Mov R7,#'1'		;Code for '1'
			RET				

IDCode1:	JNB P0.4, KeyCode02	;If Col0 Row2 is cleared - key found
			JNB P0.5, KeyCode12	;If Col1 Row2 is cleared - key found
			JNB P0.6, KeyCode22	;If Col2 Row2 is cleared - key found
			RET					

KeyCode02:	SETB F0			;Key found - set F0
			Mov R7,#'6'		;Code for '6'

			RET				

KeyCode12:	SETB F0			;Key found - set F0
			Mov R7,#'5'		;Code for '5'
			RET				

KeyCode22:	SETB F0			;Key found - set F0
			Mov R7,#'4'		;Code for '4'
			RET				

IDCode2:	JNB P0.4, KeyCode01	;If Col0 Row1 is cleared - key found
			JNB P0.5, KeyCode11	;If Col1 Row1 is cleared - key found
			JNB P0.6, KeyCode21	;If Col2 Row1 is cleared - key found
			RET					

KeyCode01:	SETB F0			;Key found - set F0
			Mov R7,#'9'		;Code for '9'
			RET				

KeyCode11:	SETB F0			;Key found - set F0
			Mov R7,#'8'		;Code for '8'
			RET				

KeyCode21:	SETB F0			;Key found - set F0
			Mov R7,#'7'		;Code for '7'
			RET				

IDCode3:	JNB P0.4, KeyCode00	;If Col0 Row0 is cleared - key found
			JNB P0.5, KeyCode10	;If Col1 Row0 is cleared - key found
			JNB P0.6, KeyCode20	;If Col2 Row0 is cleared - key found
			RET					

KeyCode00:	SETB F0			;Key found - set F0
			Mov R7,#'#'		;Code for '#' 
			RET				

KeyCode10:	SETB F0			;Key found - set F0
			Mov R7,#'0'		;Code for '0'
			RET				

KeyCode20:	SETB F0			;Key found - set F0
			Mov R7,#'*'	   	;Code for '*' 
			RET						
;--------------------------------- End of subroutines ---------------------------
	
Stop:		Jmp $
	
			End
