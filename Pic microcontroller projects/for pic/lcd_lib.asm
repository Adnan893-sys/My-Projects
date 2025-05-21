
_LCD_Write:

;lcd_lib.c,4 :: 		void LCD_Write(char cmd,int cmddta)
;lcd_lib.c,7 :: 		PORTB.F4=cmddta;
	BTFSC      FARG_LCD_Write_cmddta+0, 0
	GOTO       L__LCD_Write20
	BCF        PORTB+0, 4
	GOTO       L__LCD_Write21
L__LCD_Write20:
	BSF        PORTB+0, 4
L__LCD_Write21:
;lcd_lib.c,9 :: 		PORTB.F0=(cmd & 0b00010000)>>4;
	MOVLW      16
	ANDWF      FARG_LCD_Write_cmd+0, 0
	MOVWF      R2
	MOVF       R2, 0
	MOVWF      R0
	LSRF       R0, 1
	LSRF       R0, 1
	LSRF       R0, 1
	LSRF       R0, 1
	BTFSC      R0, 0
	GOTO       L__LCD_Write22
	BCF        PORTB+0, 0
	GOTO       L__LCD_Write23
L__LCD_Write22:
	BSF        PORTB+0, 0
L__LCD_Write23:
;lcd_lib.c,11 :: 		PORTB.F1=(cmd & 0b00100000)>>5;
	MOVLW      32
	ANDWF      FARG_LCD_Write_cmd+0, 0
	MOVWF      R2
	MOVLW      5
	MOVWF      R1
	MOVF       R2, 0
	MOVWF      R0
	MOVF       R1, 0
L__LCD_Write24:
	BTFSC      STATUS+0, 2
	GOTO       L__LCD_Write25
	LSRF       R0, 1
	ADDLW      255
	GOTO       L__LCD_Write24
L__LCD_Write25:
	BTFSC      R0, 0
	GOTO       L__LCD_Write26
	BCF        PORTB+0, 1
	GOTO       L__LCD_Write27
L__LCD_Write26:
	BSF        PORTB+0, 1
L__LCD_Write27:
;lcd_lib.c,13 :: 		PORTB.F2=(cmd & 0b01000000)>>6;
	MOVLW      64
	ANDWF      FARG_LCD_Write_cmd+0, 0
	MOVWF      R2
	MOVLW      6
	MOVWF      R1
	MOVF       R2, 0
	MOVWF      R0
	MOVF       R1, 0
L__LCD_Write28:
	BTFSC      STATUS+0, 2
	GOTO       L__LCD_Write29
	LSRF       R0, 1
	ADDLW      255
	GOTO       L__LCD_Write28
L__LCD_Write29:
	BTFSC      R0, 0
	GOTO       L__LCD_Write30
	BCF        PORTB+0, 2
	GOTO       L__LCD_Write31
L__LCD_Write30:
	BSF        PORTB+0, 2
L__LCD_Write31:
;lcd_lib.c,15 :: 		PORTB.F3=(cmd & 0b10000000)>>7;
	MOVLW      128
	ANDWF      FARG_LCD_Write_cmd+0, 0
	MOVWF      R2
	MOVLW      7
	MOVWF      R1
	MOVF       R2, 0
	MOVWF      R0
	MOVF       R1, 0
L__LCD_Write32:
	BTFSC      STATUS+0, 2
	GOTO       L__LCD_Write33
	LSRF       R0, 1
	ADDLW      255
	GOTO       L__LCD_Write32
L__LCD_Write33:
	BTFSC      R0, 0
	GOTO       L__LCD_Write34
	BCF        PORTB+0, 3
	GOTO       L__LCD_Write35
L__LCD_Write34:
	BSF        PORTB+0, 3
L__LCD_Write35:
;lcd_lib.c,16 :: 		delay_us(500);
	MOVLW      2
	MOVWF      R12
	MOVLW      75
	MOVWF      R13
L_LCD_Write0:
	DECFSZ     R13, 1
	GOTO       L_LCD_Write0
	DECFSZ     R12, 1
	GOTO       L_LCD_Write0
;lcd_lib.c,18 :: 		PORTB.F5=1;
	BSF        PORTB+0, 5
;lcd_lib.c,19 :: 		delay_us(500);
	MOVLW      2
	MOVWF      R12
	MOVLW      75
	MOVWF      R13
L_LCD_Write1:
	DECFSZ     R13, 1
	GOTO       L_LCD_Write1
	DECFSZ     R12, 1
	GOTO       L_LCD_Write1
;lcd_lib.c,21 :: 		PORTB.F5=0;
	BCF        PORTB+0, 5
;lcd_lib.c,22 :: 		delay_us(500);
	MOVLW      2
	MOVWF      R12
	MOVLW      75
	MOVWF      R13
L_LCD_Write2:
	DECFSZ     R13, 1
	GOTO       L_LCD_Write2
	DECFSZ     R12, 1
	GOTO       L_LCD_Write2
;lcd_lib.c,24 :: 		PORTB.F0=(cmd & 0b00000001)>>0;
	MOVLW      1
	ANDWF      FARG_LCD_Write_cmd+0, 0
	MOVWF      R0
	BTFSC      R0, 0
	GOTO       L__LCD_Write36
	BCF        PORTB+0, 0
	GOTO       L__LCD_Write37
L__LCD_Write36:
	BSF        PORTB+0, 0
L__LCD_Write37:
;lcd_lib.c,26 :: 		PORTB.F1=(cmd & 0b00000010)>>1;
	MOVLW      2
	ANDWF      FARG_LCD_Write_cmd+0, 0
	MOVWF      R2
	MOVF       R2, 0
	MOVWF      R0
	LSRF       R0, 1
	BTFSC      R0, 0
	GOTO       L__LCD_Write38
	BCF        PORTB+0, 1
	GOTO       L__LCD_Write39
L__LCD_Write38:
	BSF        PORTB+0, 1
L__LCD_Write39:
;lcd_lib.c,28 :: 		PORTB.F2=(cmd & 0b00000100)>>2;
	MOVLW      4
	ANDWF      FARG_LCD_Write_cmd+0, 0
	MOVWF      R2
	MOVF       R2, 0
	MOVWF      R0
	LSRF       R0, 1
	LSRF       R0, 1
	BTFSC      R0, 0
	GOTO       L__LCD_Write40
	BCF        PORTB+0, 2
	GOTO       L__LCD_Write41
L__LCD_Write40:
	BSF        PORTB+0, 2
L__LCD_Write41:
;lcd_lib.c,30 :: 		PORTB.F3=(cmd & 0b00001000)>>3;
	MOVLW      8
	ANDWF      FARG_LCD_Write_cmd+0, 0
	MOVWF      R2
	MOVF       R2, 0
	MOVWF      R0
	LSRF       R0, 1
	LSRF       R0, 1
	LSRF       R0, 1
	BTFSC      R0, 0
	GOTO       L__LCD_Write42
	BCF        PORTB+0, 3
	GOTO       L__LCD_Write43
L__LCD_Write42:
	BSF        PORTB+0, 3
L__LCD_Write43:
;lcd_lib.c,31 :: 		delay_us(500);
	MOVLW      2
	MOVWF      R12
	MOVLW      75
	MOVWF      R13
L_LCD_Write3:
	DECFSZ     R13, 1
	GOTO       L_LCD_Write3
	DECFSZ     R12, 1
	GOTO       L_LCD_Write3
;lcd_lib.c,33 :: 		PORTB.F5=1;
	BSF        PORTB+0, 5
;lcd_lib.c,34 :: 		delay_us(500);
	MOVLW      2
	MOVWF      R12
	MOVLW      75
	MOVWF      R13
L_LCD_Write4:
	DECFSZ     R13, 1
	GOTO       L_LCD_Write4
	DECFSZ     R12, 1
	GOTO       L_LCD_Write4
;lcd_lib.c,36 :: 		PORTB.F5=0;
	BCF        PORTB+0, 5
;lcd_lib.c,37 :: 		delay_us(500);
	MOVLW      2
	MOVWF      R12
	MOVLW      75
	MOVWF      R13
L_LCD_Write5:
	DECFSZ     R13, 1
	GOTO       L_LCD_Write5
	DECFSZ     R12, 1
	GOTO       L_LCD_Write5
;lcd_lib.c,38 :: 		}
L_end_LCD_Write:
	RETURN
; end of _LCD_Write

_LCD_Init:

;lcd_lib.c,40 :: 		void LCD_Init(){
;lcd_lib.c,41 :: 		TRISB=0x00;
	CLRF       TRISB+0
;lcd_lib.c,42 :: 		ANSELB=0x00;
	CLRF       ANSELB+0
;lcd_lib.c,43 :: 		LCD_Write(0x33,0);
	MOVLW      51
	MOVWF      FARG_LCD_Write_cmd+0
	CLRF       FARG_LCD_Write_cmddta+0
	CLRF       FARG_LCD_Write_cmddta+1
	CALL       _LCD_Write+0
;lcd_lib.c,44 :: 		delay_us(500);
	MOVLW      2
	MOVWF      R12
	MOVLW      75
	MOVWF      R13
L_LCD_Init6:
	DECFSZ     R13, 1
	GOTO       L_LCD_Init6
	DECFSZ     R12, 1
	GOTO       L_LCD_Init6
;lcd_lib.c,45 :: 		LCD_Write(0x32,0);
	MOVLW      50
	MOVWF      FARG_LCD_Write_cmd+0
	CLRF       FARG_LCD_Write_cmddta+0
	CLRF       FARG_LCD_Write_cmddta+1
	CALL       _LCD_Write+0
;lcd_lib.c,46 :: 		delay_us(500);
	MOVLW      2
	MOVWF      R12
	MOVLW      75
	MOVWF      R13
L_LCD_Init7:
	DECFSZ     R13, 1
	GOTO       L_LCD_Init7
	DECFSZ     R12, 1
	GOTO       L_LCD_Init7
;lcd_lib.c,47 :: 		LCD_Write(0x28,0);
	MOVLW      40
	MOVWF      FARG_LCD_Write_cmd+0
	CLRF       FARG_LCD_Write_cmddta+0
	CLRF       FARG_LCD_Write_cmddta+1
	CALL       _LCD_Write+0
;lcd_lib.c,48 :: 		delay_us(500);
	MOVLW      2
	MOVWF      R12
	MOVLW      75
	MOVWF      R13
L_LCD_Init8:
	DECFSZ     R13, 1
	GOTO       L_LCD_Init8
	DECFSZ     R12, 1
	GOTO       L_LCD_Init8
;lcd_lib.c,49 :: 		LCD_Write(0x0C,0);
	MOVLW      12
	MOVWF      FARG_LCD_Write_cmd+0
	CLRF       FARG_LCD_Write_cmddta+0
	CLRF       FARG_LCD_Write_cmddta+1
	CALL       _LCD_Write+0
;lcd_lib.c,50 :: 		delay_us(500);
	MOVLW      2
	MOVWF      R12
	MOVLW      75
	MOVWF      R13
L_LCD_Init9:
	DECFSZ     R13, 1
	GOTO       L_LCD_Init9
	DECFSZ     R12, 1
	GOTO       L_LCD_Init9
;lcd_lib.c,51 :: 		LCD_Write(0x06,0);
	MOVLW      6
	MOVWF      FARG_LCD_Write_cmd+0
	CLRF       FARG_LCD_Write_cmddta+0
	CLRF       FARG_LCD_Write_cmddta+1
	CALL       _LCD_Write+0
;lcd_lib.c,52 :: 		delay_us(500);
	MOVLW      2
	MOVWF      R12
	MOVLW      75
	MOVWF      R13
L_LCD_Init10:
	DECFSZ     R13, 1
	GOTO       L_LCD_Init10
	DECFSZ     R12, 1
	GOTO       L_LCD_Init10
;lcd_lib.c,53 :: 		LCD_Write(0x01,0);
	MOVLW      1
	MOVWF      FARG_LCD_Write_cmd+0
	CLRF       FARG_LCD_Write_cmddta+0
	CLRF       FARG_LCD_Write_cmddta+1
	CALL       _LCD_Write+0
;lcd_lib.c,54 :: 		delay_us(500);
	MOVLW      2
	MOVWF      R12
	MOVLW      75
	MOVWF      R13
L_LCD_Init11:
	DECFSZ     R13, 1
	GOTO       L_LCD_Init11
	DECFSZ     R12, 1
	GOTO       L_LCD_Init11
;lcd_lib.c,55 :: 		}
L_end_LCD_Init:
	RETURN
; end of _LCD_Init

_LCD_Clear:

;lcd_lib.c,57 :: 		void LCD_Clear(){
;lcd_lib.c,58 :: 		LCD_Write(0x01,0);
	MOVLW      1
	MOVWF      FARG_LCD_Write_cmd+0
	CLRF       FARG_LCD_Write_cmddta+0
	CLRF       FARG_LCD_Write_cmddta+1
	CALL       _LCD_Write+0
;lcd_lib.c,59 :: 		}
L_end_LCD_Clear:
	RETURN
; end of _LCD_Clear

_LCD_SetCursor:

;lcd_lib.c,61 :: 		void LCD_SetCursor(int row, int col){
;lcd_lib.c,62 :: 		if (col == 0)LCD_Write((row | 0x80),0);
	MOVLW      0
	XORWF      FARG_LCD_SetCursor_col+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__LCD_SetCursor47
	MOVLW      0
	XORWF      FARG_LCD_SetCursor_col+0, 0
L__LCD_SetCursor47:
	BTFSS      STATUS+0, 2
	GOTO       L_LCD_SetCursor12
	MOVLW      128
	IORWF       FARG_LCD_SetCursor_row+0, 0
	MOVWF      FARG_LCD_Write_cmd+0
	CLRF       FARG_LCD_Write_cmddta+0
	CLRF       FARG_LCD_Write_cmddta+1
	CALL       _LCD_Write+0
L_LCD_SetCursor12:
;lcd_lib.c,63 :: 		if (col == 1)LCD_Write((row | 0x80)+ 0x40,0);
	MOVLW      0
	XORWF      FARG_LCD_SetCursor_col+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__LCD_SetCursor48
	MOVLW      1
	XORWF      FARG_LCD_SetCursor_col+0, 0
L__LCD_SetCursor48:
	BTFSS      STATUS+0, 2
	GOTO       L_LCD_SetCursor13
	MOVLW      128
	IORWF       FARG_LCD_SetCursor_row+0, 0
	MOVWF      FARG_LCD_Write_cmd+0
	MOVLW      64
	ADDWF      FARG_LCD_Write_cmd+0, 1
	CLRF       FARG_LCD_Write_cmddta+0
	CLRF       FARG_LCD_Write_cmddta+1
	CALL       _LCD_Write+0
L_LCD_SetCursor13:
;lcd_lib.c,64 :: 		if (col == 2)LCD_Write((row | 0x80)+ 0x10,0);
	MOVLW      0
	XORWF      FARG_LCD_SetCursor_col+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__LCD_SetCursor49
	MOVLW      2
	XORWF      FARG_LCD_SetCursor_col+0, 0
L__LCD_SetCursor49:
	BTFSS      STATUS+0, 2
	GOTO       L_LCD_SetCursor14
	MOVLW      128
	IORWF       FARG_LCD_SetCursor_row+0, 0
	MOVWF      FARG_LCD_Write_cmd+0
	MOVLW      16
	ADDWF      FARG_LCD_Write_cmd+0, 1
	CLRF       FARG_LCD_Write_cmddta+0
	CLRF       FARG_LCD_Write_cmddta+1
	CALL       _LCD_Write+0
L_LCD_SetCursor14:
;lcd_lib.c,65 :: 		if (col == 3)LCD_Write((row | 0x80)+ 0x50,0);
	MOVLW      0
	XORWF      FARG_LCD_SetCursor_col+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__LCD_SetCursor50
	MOVLW      3
	XORWF      FARG_LCD_SetCursor_col+0, 0
L__LCD_SetCursor50:
	BTFSS      STATUS+0, 2
	GOTO       L_LCD_SetCursor15
	MOVLW      128
	IORWF       FARG_LCD_SetCursor_row+0, 0
	MOVWF      FARG_LCD_Write_cmd+0
	MOVLW      80
	ADDWF      FARG_LCD_Write_cmd+0, 1
	CLRF       FARG_LCD_Write_cmddta+0
	CLRF       FARG_LCD_Write_cmddta+1
	CALL       _LCD_Write+0
L_LCD_SetCursor15:
;lcd_lib.c,66 :: 		delay_us(500);
	MOVLW      2
	MOVWF      R12
	MOVLW      75
	MOVWF      R13
L_LCD_SetCursor16:
	DECFSZ     R13, 1
	GOTO       L_LCD_SetCursor16
	DECFSZ     R12, 1
	GOTO       L_LCD_SetCursor16
;lcd_lib.c,68 :: 		}
L_end_LCD_SetCursor:
	RETURN
; end of _LCD_SetCursor

_LCD_Char:

;lcd_lib.c,70 :: 		void LCD_Char(char character){
;lcd_lib.c,72 :: 		LCD_Write(character,1);
	MOVF       FARG_LCD_Char_character+0, 0
	MOVWF      FARG_LCD_Write_cmd+0
	MOVLW      1
	MOVWF      FARG_LCD_Write_cmddta+0
	MOVLW      0
	MOVWF      FARG_LCD_Write_cmddta+1
	CALL       _LCD_Write+0
;lcd_lib.c,73 :: 		}
L_end_LCD_Char:
	RETURN
; end of _LCD_Char

_LCD_int:

;lcd_lib.c,75 :: 		void LCD_int(int n)
;lcd_lib.c,78 :: 		n1=n%10;
	MOVLW      10
	MOVWF      R4
	MOVLW      0
	MOVWF      R5
	MOVF       FARG_LCD_int_n+0, 0
	MOVWF      R0
	MOVF       FARG_LCD_int_n+1, 0
	MOVWF      R1
	CALL       _Div_16x16_S+0
	MOVF       R8, 0
	MOVWF      R0
	MOVF       R9, 0
	MOVWF      R1
	MOVF       R0, 0
	MOVWF      FLOC__LCD_int+6
	MOVF       R1, 0
	MOVWF      FLOC__LCD_int+7
	MOVF       FLOC__LCD_int+6, 0
	MOVWF      LCD_int_n1_L0+0
	MOVF       FLOC__LCD_int+7, 0
	MOVWF      LCD_int_n1_L0+1
;lcd_lib.c,79 :: 		n2=(((n%100)-n1)/10);
	MOVLW      100
	MOVWF      R4
	MOVLW      0
	MOVWF      R5
	MOVF       FARG_LCD_int_n+0, 0
	MOVWF      R0
	MOVF       FARG_LCD_int_n+1, 0
	MOVWF      R1
	CALL       _Div_16x16_S+0
	MOVF       R8, 0
	MOVWF      R0
	MOVF       R9, 0
	MOVWF      R1
	MOVF       FLOC__LCD_int+6, 0
	SUBWF      R0, 1
	MOVF       FLOC__LCD_int+7, 0
	SUBWFB     R1, 1
	MOVLW      10
	MOVWF      R4
	MOVLW      0
	MOVWF      R5
	CALL       _Div_16x16_S+0
	MOVF       R0, 0
	MOVWF      FLOC__LCD_int+2
	MOVF       R1, 0
	MOVWF      FLOC__LCD_int+3
	MOVF       FLOC__LCD_int+2, 0
	MOVWF      LCD_int_n2_L0+0
	MOVF       FLOC__LCD_int+3, 0
	MOVWF      LCD_int_n2_L0+1
;lcd_lib.c,80 :: 		n3=(((n%1000)-(n2*10+n1))/100);
	MOVLW      232
	MOVWF      R4
	MOVLW      3
	MOVWF      R5
	MOVF       FARG_LCD_int_n+0, 0
	MOVWF      R0
	MOVF       FARG_LCD_int_n+1, 0
	MOVWF      R1
	CALL       _Div_16x16_S+0
	MOVF       R8, 0
	MOVWF      R0
	MOVF       R9, 0
	MOVWF      R1
	MOVF       R0, 0
	MOVWF      FLOC__LCD_int+0
	MOVF       R1, 0
	MOVWF      FLOC__LCD_int+1
	MOVF       FLOC__LCD_int+2, 0
	MOVWF      R0
	MOVF       FLOC__LCD_int+3, 0
	MOVWF      R1
	MOVLW      10
	MOVWF      R4
	MOVLW      0
	MOVWF      R5
	CALL       _Mul_16X16_U+0
	MOVF       R0, 0
	MOVWF      FLOC__LCD_int+4
	MOVF       R1, 0
	MOVWF      FLOC__LCD_int+5
	MOVF       FLOC__LCD_int+6, 0
	ADDWF      FLOC__LCD_int+4, 0
	MOVWF      R0
	MOVF       FLOC__LCD_int+7, 0
	ADDWFC     FLOC__LCD_int+5, 0
	MOVWF      R1
	MOVF       R0, 0
	SUBWF      FLOC__LCD_int+0, 0
	MOVWF      R0
	MOVF       R1, 0
	SUBWFB     FLOC__LCD_int+1, 0
	MOVWF      R1
	MOVLW      100
	MOVWF      R4
	MOVLW      0
	MOVWF      R5
	CALL       _Div_16x16_S+0
	MOVF       R0, 0
	MOVWF      FLOC__LCD_int+2
	MOVF       R1, 0
	MOVWF      FLOC__LCD_int+3
	MOVF       FLOC__LCD_int+2, 0
	MOVWF      LCD_int_n3_L0+0
	MOVF       FLOC__LCD_int+3, 0
	MOVWF      LCD_int_n3_L0+1
;lcd_lib.c,81 :: 		n4=(((n%10000)-(n3*100+n2*10+n1))/1000);
	MOVLW      16
	MOVWF      R4
	MOVLW      39
	MOVWF      R5
	MOVF       FARG_LCD_int_n+0, 0
	MOVWF      R0
	MOVF       FARG_LCD_int_n+1, 0
	MOVWF      R1
	CALL       _Div_16x16_S+0
	MOVF       R8, 0
	MOVWF      R0
	MOVF       R9, 0
	MOVWF      R1
	MOVF       R0, 0
	MOVWF      FLOC__LCD_int+0
	MOVF       R1, 0
	MOVWF      FLOC__LCD_int+1
	MOVF       FLOC__LCD_int+2, 0
	MOVWF      R0
	MOVF       FLOC__LCD_int+3, 0
	MOVWF      R1
	MOVLW      100
	MOVWF      R4
	MOVLW      0
	MOVWF      R5
	CALL       _Mul_16X16_U+0
	MOVF       FLOC__LCD_int+4, 0
	ADDWF      R0, 1
	MOVF       FLOC__LCD_int+5, 0
	ADDWFC     R1, 1
	MOVF       FLOC__LCD_int+6, 0
	ADDWF      R0, 1
	MOVF       FLOC__LCD_int+7, 0
	ADDWFC     R1, 1
	MOVF       R0, 0
	SUBWF      FLOC__LCD_int+0, 0
	MOVWF      R0
	MOVF       R1, 0
	SUBWFB     FLOC__LCD_int+1, 0
	MOVWF      R1
	MOVLW      232
	MOVWF      R4
	MOVLW      3
	MOVWF      R5
	CALL       _Div_16x16_S+0
;lcd_lib.c,82 :: 		LCD_Char(n4+48);
	MOVLW      48
	ADDWF      R0, 0
	MOVWF      FARG_LCD_Char_character+0
	CALL       _LCD_Char+0
;lcd_lib.c,83 :: 		LCD_Char(n3+48);
	MOVLW      48
	ADDWF      LCD_int_n3_L0+0, 0
	MOVWF      FARG_LCD_Char_character+0
	CALL       _LCD_Char+0
;lcd_lib.c,84 :: 		LCD_Char(n2+48);
	MOVLW      48
	ADDWF      LCD_int_n2_L0+0, 0
	MOVWF      FARG_LCD_Char_character+0
	CALL       _LCD_Char+0
;lcd_lib.c,85 :: 		LCD_Char(n1+48);
	MOVLW      48
	ADDWF      LCD_int_n1_L0+0, 0
	MOVWF      FARG_LCD_Char_character+0
	CALL       _LCD_Char+0
;lcd_lib.c,86 :: 		}
L_end_LCD_int:
	RETURN
; end of _LCD_int

_LCD_string:

;lcd_lib.c,88 :: 		void LCD_string(char *character)
;lcd_lib.c,90 :: 		while(*character)
L_LCD_string17:
	MOVF       FARG_LCD_string_character+0, 0
	MOVWF      FSR0L
	MOVF       FARG_LCD_string_character+1, 0
	MOVWF      FSR0H
	MOVF       INDF0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_LCD_string18
;lcd_lib.c,92 :: 		LCD_Write(*character++,1);
	MOVF       FARG_LCD_string_character+0, 0
	MOVWF      FSR0L
	MOVF       FARG_LCD_string_character+1, 0
	MOVWF      FSR0H
	MOVF       INDF0+0, 0
	MOVWF      FARG_LCD_Write_cmd+0
	MOVLW      1
	MOVWF      FARG_LCD_Write_cmddta+0
	MOVLW      0
	MOVWF      FARG_LCD_Write_cmddta+1
	CALL       _LCD_Write+0
	INCF       FARG_LCD_string_character+0, 1
	BTFSC      STATUS+0, 2
	INCF       FARG_LCD_string_character+1, 1
;lcd_lib.c,93 :: 		}
	GOTO       L_LCD_string17
L_LCD_string18:
;lcd_lib.c,94 :: 		}
L_end_LCD_string:
	RETURN
; end of _LCD_string
