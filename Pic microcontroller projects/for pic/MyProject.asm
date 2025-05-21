
_main:

;MyProject.c,2 :: 		void main() {
;MyProject.c,3 :: 		LCD_Init();
	CALL       _Lcd_Init+0
;MyProject.c,4 :: 		LCD_Clear();
	CALL       _LCD_Clear+0
;MyProject.c,5 :: 		delay_ms(100);
	MOVLW      5
	MOVWF      R11
	MOVLW      15
	MOVWF      R12
	MOVLW      241
	MOVWF      R13
L_main0:
	DECFSZ     R13, 1
	GOTO       L_main0
	DECFSZ     R12, 1
	GOTO       L_main0
	DECFSZ     R11, 1
	GOTO       L_main0
;MyProject.c,6 :: 		LCD_SetCursor(0,0);
	CLRF       FARG_LCD_SetCursor_row+0
	CLRF       FARG_LCD_SetCursor_row+1
	CLRF       FARG_LCD_SetCursor_col+0
	CLRF       FARG_LCD_SetCursor_col+1
	CALL       _LCD_SetCursor+0
;MyProject.c,7 :: 		LCD_string("ID: H00354030");
	MOVLW      ?lstr1_MyProject+0
	MOVWF      FARG_LCD_string_character+0
	MOVLW      hi_addr(?lstr1_MyProject+0)
	MOVWF      FARG_LCD_string_character+1
	CALL       _LCD_string+0
;MyProject.c,9 :: 		LCD_SetCursor(0,1);
	CLRF       FARG_LCD_SetCursor_row+0
	CLRF       FARG_LCD_SetCursor_row+1
	MOVLW      1
	MOVWF      FARG_LCD_SetCursor_col+0
	MOVLW      0
	MOVWF      FARG_LCD_SetCursor_col+1
	CALL       _LCD_SetCursor+0
;MyProject.c,10 :: 		LCD_string("Reem Faisal"); //second row
	MOVLW      ?lstr2_MyProject+0
	MOVWF      FARG_LCD_string_character+0
	MOVLW      hi_addr(?lstr2_MyProject+0)
	MOVWF      FARG_LCD_string_character+1
	CALL       _LCD_string+0
;MyProject.c,11 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
