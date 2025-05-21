ORG 250H
Data1: DB "1Cake 6$",0
Data2: DB "2CAN 5$",0
Data3: DB "3Milk 4$",0
Data4: DB "4Tea 3$",0
Data5: DB "Insert",0
Data6: DB "Coin",0
	
KEYPAD_PORT	EQU	P3
LEDS_PORT	EQU	P0


ORG 00H
AGAIN:
ACALL Initialize_LCD
ACALL GetData
ACALL take_Number
Acall Set_place
ACall Print_message1
ACall Print_doller
ACall Print_message2
ACALL take_Number
Acall Set_place1
Acall Compare
SJMP AGAIN     


Compare:
Mov A,R1
SUBB A,R2
JNZ ED
SETB P2.3          
CLR P2.4         ;motor runs
Acall DELAY_1s
CLR P2.3          
CLR P2.4         ;motor stops after 4 seconds
ED:
Ret
;#####################################################
Print_doller:
MOV A,#88H              ;cursor at line 1, pos. 9
ACALL COMNWRT           ;call command subroutine
ACALL DELAY             ;give LCD some time
Mov A,R1
CJNE A,#31h,OV1         ;jump if A is not 1
Mov A,#6H
SJMP OV4
OV1:
CJNE A,#32h,OV2         ;jump if A is not 2
Mov A,#5H
SJMP OV4
OV2:
CJNE A,#33h,OV3         ;jump if A is not 3
Mov A,#4H
SJMP OV4
OV3:
CJNE A,#34h,OV4         ;jump if A is not 3
Mov A,#3H
OV4:
Add A,#30H
Mov R2,A                ;save for comparison
ACALL DATAWRT           ;call display subroutine
ACALL DELAY             ;give LCD some time
MOV A,#89H              ;cursor at line 1, pos. 9
ACALL COMNWRT           ;call command subroutine
ACALL DELAY             ;give LCD some time
Mov A,#24h
ACALL DATAWRT           ;call display subroutine
ACALL DELAY             ;give LCD some time
Ret


;##################################################
Print_message1:
MOV A,#81H              ;cursor at line 1, pos. 0
ACALL COMNWRT           ;call command subroutine
ACALL DELAY             ;give LCD some time
MOV DPTR,#DATA5        ;load ROM pointer
Go1: 
CLR A                    ;A=O
MOVC A,@A+DPTR           ;move data from code space
JZ Exe1                  ;exit if null character
ACALL DATAWRT           ;call display subroutine
ACALL DELAY             ;give LCD some time
INC DPTR                 ;increment ROM pointer
SJMP Go1                ;loop
Exe1:
Ret
;#####################################################
Print_message2:
MOV A,#8BH              ;cursor at line 1, pos. 11
ACALL COMNWRT           ;call command subroutine
ACALL DELAY             ;give LCD some time
MOV DPTR,#DATA6        ;load ROM pointer
Go2: 
CLR A                    ;A=O
MOVC A,@A+DPTR           ;move data from code space
JZ Ex2                  ;exit if null character
ACALL DATAWRT           ;call display subroutine
ACALL DELAY             ;give LCD some time
INC DPTR                 ;increment ROM pointer
SJMP Go2                ;loop
Ex2:
Ret
;###############################################################
GetData:
;################################### First Data #############################
MOV A,#80H              ;cursor at line 1, pos. 0
ACALL COMNWRT           ;call command subroutine
ACALL DELAY             ;give LCD some time
MOV DPTR,#DATA1        ;load ROM pointer
BACK1: 
CLR A                    ;A=O
MOVC A,@A+DPTR           ;move data from code space
JZ Exit1                  ;exit if null character
ACALL DATAWRT           ;call display subroutine
ACALL DELAY             ;give LCD some time
INC DPTR                 ;increment ROM pointer
SJMP BACK1                ;loop
Exit1:
;################################### Second Data #############################
MOV A,#89H              ;cursor at line 1, pos. 9
ACALL COMNWRT           ;call command subroutine
ACALL DELAY             ;give LCD some time
MOV DPTR,#DATA2        ;load ROM pointer
BACK2: 
CLR A                    ;A=O
MOVC A,@A+DPTR           ;move data from code space
JZ Exit2                  ;exit if null character
ACALL DATAWRT           ;call display subroutine
ACALL DELAY             ;give LCD some time
INC DPTR                 ;increment ROM pointer
SJMP BACK2                ;loop
Exit2:
;################################### Third Data #############################
MOV A,#0C0H              ;cursor at line 2, pos. 0
ACALL COMNWRT           ;call command subroutine
ACALL DELAY             ;give LCD some time
MOV DPTR,#DATA3        ;load ROM pointer
BACK3: 
CLR A                    ;A=O
MOVC A,@A+DPTR           ;move data from code space
JZ Exit3                  ;exit if null character
ACALL DATAWRT           ;call display subroutine
ACALL DELAY             ;give LCD some time
INC DPTR                 ;increment ROM pointer
SJMP BACK3               ;loop
Exit3:
;################################### Fourth Data #############################
MOV A,#0C9H              ;cursor at line 2, pos. 9
ACALL COMNWRT           ;call command subroutine
ACALL DELAY             ;give LCD some time
MOV DPTR,#DATA4          ;load ROM pointer
BACK4: 
CLR A                    ;A=O
MOVC A,@A+DPTR           ;move data from code space
JZ Exit4                  ;exit if null character
ACALL DATAWRT           ;call display subroutine
ACALL DELAY             ;give LCD some time
INC DPTR                 ;increment ROM pointer
SJMP BACK4                ;loop
Exit4:
RET

Initialize_LCD:
MOV A,#38H             ;INIT. LCD 2 LINES, 5X7 MATRIX
ACALL COMNWRT          ;call command subroutine
ACALL DELAY            ;give LCD some time
MOV A,#0EH             ;display on, cursor on
ACALL COMNWRT          ;call command subroutine
ACALL DELAY             ;give LCD some time
MOV A,#01               ;clear LCD
ACALL COMNWRT           ;call command subroutine
ACALL DELAY             ;give LCD some time
RET

;//////////////////////////////////////////
COMNWRT:          ;send command to LCD
MOV P1,A          ;copy reg A to port 1
CLR P2.0          ;RS=0 for command
CLR P2.1          ;R/W=0 for write
SETB P2.2         ;E=1 for high pulse
ACALL DELAY       ;give LCD some time
CLR P2.2          ;E=0 for H-to-L pulse
RET
;//////////////////////////////////////////
DATAWRT:             ;write data to LCD
MOV P1,A             ;copy reg A to port 1
SETB P2.0            ;RS=1 for data
CLR P2.1             ;R/W=0 for write
SETB P2.2            ;E=1 for high pulse
ACALL DELAY          ;give LCD some time
CLR P2.2             ;E=0 for H-to-L pulse
RET
;//////////////////////////////////////////

DELAY:
MOV R3,#50              ;50 or higher for fast CPUs
HERE2: MOV R4,#25      ;R4 = 255
HERE: DJNZ R4,HERE      ;stay until R4 becomes 0
DJNZ R3,HERE2
RET
;###########################################
DELAY_1s:
    mov R1,#4
RE2:MOV R2,#200 
RE1:MOV R3,#250 
RE: NOP 
NOP 
DJNZ R3,RE 
DJNZ R2,RE1 
DJNZ R1,RE2
RET
;############################################
take_Number:
KEYSCAN:	
	MOV	KEYPAD_PORT,#00001111B
	MOV	A,KEYPAD_PORT
	CJNE	A,#00001111B,KEYSCAN

K2:	
	ACALL	DELAY1		;CHECK IF A KEY IS PRESSED
	MOV	A,KEYPAD_PORT
	CJNE	A,#00001111B,OVER
	SJMP	K2

OVER:	
	ACALL	DELAY1
	MOV	A,KEYPAD_PORT
	CJNE	A,#00001111B,OVER1
	SJMP	K2

OVER1:	
	MOV	KEYPAD_PORT,#11101111B	;TO CHECK IF PRESSED KEY IS FROM ROW0
	MOV	A,KEYPAD_PORT
	CJNE	A,#11101111B,ROW_0

	MOV	KEYPAD_PORT,#11011111B
	MOV	A,KEYPAD_PORT
	CJNE	A,#11011111B,ROW_1

	MOV	KEYPAD_PORT,#10111111B
	MOV	A,KEYPAD_PORT
	CJNE	A,#10111111B,ROW_2

	MOV	KEYPAD_PORT,#01111111B
	MOV	A,KEYPAD_PORT
	CJNE	A,#01111111B,ROW_3
	SJMP	K2
	
ROW_0:	
	MOV	DPTR,#KCODE0
	SJMP	FIND

ROW_1:	
	MOV	DPTR,#KCODE1
	SJMP	FIND

ROW_2:	
	MOV	DPTR,#KCODE2
	SJMP	FIND

ROW_3:	
	MOV	DPTR,#KCODE3
	
FIND:	
	RRC	A
	JNC	MATCH
	INC	DPTR
	SJMP	FIND

MATCH:	
	CLR	A
	MOVC	A,@A+DPTR
	MOV	LEDS_PORT,A
	Add A,#30H
	Mov R1,A
	
	;SJMP	KEYSCAN
RET

;======== DELAYS ================================
Set_place:
    MOV A,#01               ;clear LCD
    ACALL COMNWRT           ;call command subroutine
    ACALL DELAY             ;give LCD some time
	MOV A,#80H              ;cursor at line 1, pos. 0
    ACALL COMNWRT           ;call command subroutine
    ACALL DELAY             ;give LCD some time
	Mov A,R1
	Mov R2,A
	ACALL DATAWRT           ;call display subroutine
    ACALL DELAY             ;give LCD some time
	Ret
	
;#####################################################################
Set_place1:
    
	MOV A,#0C0H              ;cursor at line 1, pos. 0
    ACALL COMNWRT           ;call command subrutine
    ACALL DELAY             ;give LCD some time
	Mov A,R1
	ACALL DATAWRT           ;call display subroutine
    ACALL DELAY             ;give LCD some time
	Ret
;#############################################################
DELAY1:	
	MOV	R7,#255
	DJNZ	R7,$
	RET	
	
;======== CODES =================================
				
KCODE0:	DB	0FFH, 01H, 02H, 03H		
KCODE1:	DB	0FFH, 04H, 05H, 06H
KCODE2:	DB	0FFH, 07H, 08H, 09H
KCODE3:	DB	0FFH, 0AH, 00H, 0BH	
END

