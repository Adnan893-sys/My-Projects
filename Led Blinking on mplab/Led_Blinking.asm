
_main:

;Led_Blinking.c,1 :: 		void main() {
;Led_Blinking.c,2 :: 		TRISA=0;        //make PortA as output Port
	CLRF       TRISA+0
;Led_Blinking.c,3 :: 		while(1){
L_main0:
;Led_Blinking.c,4 :: 		PORTA=63;       //send high on 6 pins
	MOVLW      63
	MOVWF      PORTA+0
;Led_Blinking.c,5 :: 		Delay_ms(1000);   //delay for one second
	MOVLW      25
	MOVWF      R11
	MOVLW      240
	MOVWF      R12
	MOVLW      77
	MOVWF      R13
L_main2:
	DECFSZ     R13, 1
	GOTO       L_main2
	DECFSZ     R12, 1
	GOTO       L_main2
	DECFSZ     R11, 1
	GOTO       L_main2
	NOP
	NOP
;Led_Blinking.c,6 :: 		PORTA=0;         //send low on all pins
	CLRF       PORTA+0
;Led_Blinking.c,7 :: 		Delay_ms(1000);   //delay for one second
	MOVLW      25
	MOVWF      R11
	MOVLW      240
	MOVWF      R12
	MOVLW      77
	MOVWF      R13
L_main3:
	DECFSZ     R13, 1
	GOTO       L_main3
	DECFSZ     R12, 1
	GOTO       L_main3
	DECFSZ     R11, 1
	GOTO       L_main3
	NOP
	NOP
;Led_Blinking.c,8 :: 		}
	GOTO       L_main0
;Led_Blinking.c,9 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
