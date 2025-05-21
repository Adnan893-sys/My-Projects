; ****************************************************
; EEET2256 - Laboratory 1 (2022)
; Author: Dr. Glenn Matthews
; Last Updated:  19/07/2023 2:45:00 PM
; tableSearch.asm

; Define here the variables
.def  temp  =r16
.def  Smallest_Value  =r17
.def  Smallest_Value_Index  =r18


; Define here Reset and interrupt vectors, if any.
; The only one at the moment is the reset vector
; that points to the start of the program (i.e., label: start)
reset:
   rjmp start
   reti      ; Addr 0x01
   reti      ; Addr 0x02
   reti      ; Addr 0x03
   reti      ; Addr 0x04
   reti      ; Addr 0x05
   reti      ; Addr 0x06        Use 'rjmp myVector'
   reti      ; Addr 0x07        to define a interrupt vector
   reti      ; Addr 0x08
   reti      ; Addr 0x09
   reti      ; Addr 0x0A
   reti      ; Addr 0x0B        This is just an example
   reti      ; Addr 0x0C        Not all MCUs have the same
   reti      ; Addr 0x0D        number of interrupt vectors
   reti      ; Addr 0x0E
   reti      ; Addr 0x0F
   reti      ; Addr 0x10

; Program starts here after Reset
start:		; start here

; The Z register is used as a pointer to the the entries in the table 
; so we need to load the location of the table into the high and 
; low byte of Z. 

; Note how we use the directives 'high' and 'low' to do this.
   ; LDI Largest_Value,0x00
	;LDI Largest_Value_Index,0x00
	LDI ZH, high(Tble << 1)			; Initialize Z-pointer
	LDI ZL, low(Tble << 1)			; a byte at a time  (why <<1?)

loop:
	LPM temp, Z						; Load constant from table in memory pointed to by Z (r31:r30)
	cp temp,Smallest_Value
	brgt do_nothing
	mov Smallest_Value,temp
	mov Smallest_Value_Index,ZL

	

do_nothing:
	INC ZL 							; Move the array pointer

; Note here that we only increment and compare the lower byte
; (very risky - why risky?).

	CPI ZL, LOW((Tble << 1) + 64)	; Tble+64 is one past the final entry
	BRNE loop

here:
   JMP here							; Why do we need this?

; Create 64 bytes in code memory of table to search.
; The DC directive defines constants in (code) memory
; you will search this table for the desired entry.
Tble:
	.DB  91, 109, 110, -32,   7, -74,  81,  38
	.DB  45,  39, 117,   0, -19,  94,  89,  91
	.DB  98,  42,  -3,  23,  90,  83,  76,  13
	.DB  13, -15, -86, -77,  16,  98, 123,  24
	.DB 102,  19,  17,  10,  25,  68,  31,  12
	.DB  81,  27,  80,  43,  59,  52, -44, -76 
	.DB  64, -22, -105, 18,  40,  24,  48, -17
	.DB  28,  16,  25,  55,  26,  21, -45, -58
.exit  ;done



