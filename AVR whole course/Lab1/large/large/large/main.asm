
; Define here the variables
.def  temp  =r0          ;value storage from the menorty
.def  Biggest_Value  =r1    ;Biggest value in R1 register
.def  Index_Biggest  =r2    ; index of biggest
.def  location_Biggest =r3  ; location of the biggest in memory
.def  counter =r4           ; counter for counting index fron 0 to 63


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


start:	
	LDI ZH, high(Tble << 1)			; Initialize Z-pointer
	LDI ZL, low(Tble << 1)			; a byte at a time  (why <<1?)

loop:
	LPM temp, Z			           ; load value from memory to the temp 			
	cp  temp, Biggest_Value        ;compare that value to the biggest value already      
	brlt next                ; if less than goto else           
	mov Biggest_Value,temp         ;store biggest value          
    mov Index_Biggest,counter    ; store its index 
    mov location_Biggest,ZL      ; store its location in register  
	

next:
	INC ZL 							; Move the array pointer
	inc counter                     ; also increment the counter

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



