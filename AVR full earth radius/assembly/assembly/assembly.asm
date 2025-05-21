;***********************************************************
;*	This is the final project  for ECE375 Winter 2021
;***********************************************************
;*	 Author: Your name here
;*   Date: Place date here
;***********************************************************
.include "m128def.inc"			; Include definition file
;***********************************************************
//Internal Register Definitions and Constants
;*	(feel free to edit these or add others)
.EQU GM_VALUE=0x140
.EQU GM_VALUE1=0x0637
.EQU Quotient=0x0E00
.EQU Velocity=0x0E03
.EQU Product=0x0E05
.EQU Period=0x0E0C
;***********************************************************
;Start of Code Segment
.cseg							; Beginning of code segment

.org	$0000					; Beginning of IVs
		rjmp 	INIT			; Reset interrupt
.org	$0046					; End of Interrupt Vectors
;-----------------------------------------------------------
; Program Initialization
;-----------------------------------------------------------
INIT:	                       ; The initialization routine

LDI R16,HIGH(RAMEND)
OUT SPH,R16
LDI R16,LOW(RAMEND)
OUT SPL,R16
 LDI R20, 3                    ;FOR SLECTING PLANET
 //RCALL SelectPlanet
 RCALL SelectPlanet                //calling the subroutine for selection of planet
 RCALL CalculateQuotient           //  calling calculating quotient subroutine 
 RCALL CalculateVelocity           // calling calculating velocity subrotine
 RCALL CalculateProduct            //calling claculating product   subroutine
 RCALL CalculatePeriod
 Grading: 
        NOP
 RJMP Grading
//###############################################################################################
CalculateQuotient:
    LDI ZL,LOW(Quotient1<<1)                //loading Z by initial address of Quotient1
    LDI ZH,HIGH(Quotient1<<1)
	LDI YL,LOW(Quotient)                    //loading X by initial address of Quotient where value of quotient to be saved
    LDI YH,HIGH(Quotient)
	
	CPI R20,4
	BRLT A1                                //compare if value less than 4
	INC ZL
	INC ZL
	INC ZL                                 // incrementing Z
	INC ZL
	
	LDI R21,4
	MOV R18,R20                            // loading value  from R20 to r18       
	SUB R18,R21                            // subtracting R21 from R18
	MOV R19,R18                            // Mov r18 into r19
	CPI R18,0                              // if R18 is zero then 1st two bytes will come 
	BRNE A2                                //else jump to A2
	LPM R21,Z+
	ST Y+,R21                              // store 2 bytes t0 quotient
	LPM R21,Z
	ST Y,R21
	RJMP LAST                              //jump at terminating loop
 
    
    
A2:
	INC ZL                            //if r18 is not equa to zero
	INC ZL                            // then increment and calculate
	DEC R18
	BRNE A2
	LPM R21,Z+
	ST Y+,R21                        // loading two bytes and save in quotient
	LPM R21,Z+
	ST Y+,R21
	CPI R19,4
	BREQ g1                          // if diffetrence is equal to 4
	RJMP LAST                       //else jump last
G1:
    LPM R21,Z+
	ST Y+,R21
	RJMP LAST                       //load another bytein case of last

A1:
   LDI R18,1
    MUL R18,R20                     // mov r20 to r18
	MOV R18,R0
	CPI R18,0                      //compare r18 to zero
	BRNE HQ1
	LPM  R21,Z                    //load from programe memory and save in 
    ST Y,R21                      //save to the addres pointed by Y
     RJMP LAST
HQ1: INC ZL
	 DEC R18
	 BRNE HQ1                     // calculating which byte to be load
	 LPM  R21,Z
	 ST Y,R21                    //and store in the place pointed by Y
	 RJMP LAST
LAST:
	 RET
//####################################################################
// this subrotine calculates the velocity and save ito the location indicated as Velocity
CalculateVelocity:
    LDI zL,LOW(Velocity1<<1)             // loading address of velocity1 in Z
    LDI ZH,HIGH(Velocity1<<1)
	LDI YL,LOW(Velocity)                 // loading address of velocity where value to be saved after calculation
    LDI YH,HIGH(Velocity)              
    LDI R18,1
    MUL R18,R20                          //multiply r20 from R18 and storing result in R0
	MOV R18,R0                           // mov R0 to r18 
	MOV R19,R18
    CPI R18,0
	BRNE HQ2                            //if R18 is zero then skip this
	LPM  R21,Z                          //and store value in place indicated by Y
    ST Y,R21
     RJMP LAST                         // jump to last position
HQ2: INC ZL
	 DEC R18
	 BRNE HQ2                          //calculating which byte to be load and calculate
	 LPM  R21,Z+
	 ST Y+,R21
	 CPI R19,8                         //storing value in place shown by Y
	 BREQ B1
	 RJMP LAST1
B1:	 LPM  R21,Z                         //loading from programe memory
	 ST Y,R21                             //storing in placr indicated by Y     
     RJMP LAST1
LAST1:
	 RET                                // return to placr from where it is called
//###################################################################################
//This subroutine copies the GM value to another place so that its value may remain preserved during calculations
CalculateProduct:
       LDI ZL,LOW(Product1<<1)       //loading address of product1 in Z register
       LDI ZH,HIGH(Product1<<1)
	   LDI YL,LOW(Product)           //loading address of product in Z register
       LDI YH,HIGH(Product)
	   LDI R17,7
	K1: LPM R21,Z+                  //loading from programe memory into R21
	   ST Y+,R21                   //storing in y
	   DEC R17
	   BRNE K1                   //looping again to load all 4 bytes
	   RET
//##################################################################################################
// this subroutine calculates the period and save it to the location indicated as period
CalculatePeriod:
    LDI ZL,LOW(Period1<<1)        // this address of period1 is loaded in Z
    LDI ZH,HIGH(Period1<<1)
	LDI YL,LOW(Period)            // this address of period is loaded in Y where value will be saved
    LDI YH,HIGH(Period)   
	MOV R17,R20
	CPI R17,0                     //determining and calculating by copmaring which value to be loaded
	BREQ FG                       //jump to Fg point if equal 
L8:INC ZL                        // else incrementing zl
   INC ZL
    DEC R17
    BRNE L8                      // calculting how many times to looped and incremented
    RJMP FG                     // jump to fg point
	
    FG:LPM  R21,Z               // loas from programe memory
       ST  Y,R21               //store to place indicated by Y
	   INC ZL                  // incrementing ZL
	   INC YL
	   LPM  R21,Z              //loading from programe memory
       ST  Y,R21              // storing value of R21 to place indicated by Y
	   RJMP HERE8
HERE8: 
    RET                        // return to adress from where it is called
	 


//###################################################################################################
// this subroutine takes the value and after processing that value gives the Gm value of a specific planet
SelectPlanet:
LDI R18,4
LDI R17,4
MUL R17,R20
LDI ZL,LOW(PlanetInfo<<1)                  //loading Z by initial address of palnetinfo
LDI ZH,HIGH(PlanetInfo<<1)
LDI XL,LOW(GM_VALUE)
LDI XH,HIGH(GM_VALUE)                     // loading x by the address were GM value should be saved 
//FOR SELECTION OF BYTE
L2:INC ZL
DEC R0                                   //incrementing Z to specify which planet should be selected
BRNE L2
RJMP L1
// FOR LOADING ON ANOTER PLACE	
L1:LPM  R21,Z+                          // loading R21 by value which is pointed by Z 
CPI R18,0                               // comparing it with
BREQ HERE1                              //storing that value in the place which is pointed by X 
ST  X+,R21                            
DEC R18                                 //decremeting R18 
RJMP L1                                 // continue loop 4 times tostore all four bytes of Gm value
HERE1:                
    RET 
//###############################################################################
.ORG 0x160
OrbitalRadius:	.DB	0x64, 0x19, 0x00, 0x00
.ORG 0x250											
PlanetInfo:									
MercuryGM:		.DB	0x0E, 0x56, 0x00, 0x00	
VenusGM:		.DB	0x24, 0xF5, 0x04, 0x00	
EarthGM:		.DB	0x08, 0x15, 0x06, 0x00	
MarsGM:			.DB	0x4E, 0xA7, 0x00, 0x00
JupiterGM:		.DB	0x30, 0x13, 0x8D, 0x07	
SaturnGM:		.DB	0xF8, 0xC7, 0x42, 0x02	
UranusGM:		.DB	0xD0, 0x68, 0x58, 0x00	
NeptuneGM:		.DB	0x38, 0x4B, 0x68, 0x00
FinalGM:		.DB	0xFF, 0xFF, 0xFF, 0xFF
.ORG 0x126
Quotient1: .DB 0x03, 0x31, 0x3D, 0x06, 0x4C, 0x22, 0x16, 0xCB, 0x03, 0x7B, 0x04, 0x1B, 0x0A, 0x15, 0x1C, 0x00
.ORG 0x150
Velocity1: .DB 0x01, 0x07, 0x07, 0x02, 0x8b, 0x4C, 0x10, 0x20, 0x03, 0x2C
.ORG 0x180
Product1:  .DB  0x00, 0xDA, 0x05, 0xA5, 0xFD, 0x09, 0x00, 0x00
.ORG 0x220
Period1:   .DB 0x57, 0x3A, 0x16, 0xB6, 0x14, 0X81, 0x3E, 0x8E, 0x01, 0x26, 0x02, 0x1A, 0x05, 0x60, 0x04, 0XF3, 0x32, 0x00

