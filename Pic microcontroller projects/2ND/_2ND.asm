
_main:

;_2ND.c,21 :: 		void main(){
;_2ND.c,22 :: 		ADCON1=0x0E;
	MOVLW       14
	MOVWF       ADCON1+0 
;_2ND.c,23 :: 		TRISA.RA0=1;                 //taking PoRTA pin0 as input for sensor
	BSF         TRISA+0, 0 
;_2ND.c,24 :: 		ADC_Init();                 // initialize ADC
	CALL        _ADC_Init+0, 0
;_2ND.c,25 :: 		Lcd_Init();                 // initialize LCD
	CALL        _Lcd_Init+0, 0
;_2ND.c,26 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);   // lcd cursor off
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;_2ND.c,27 :: 		Lcd_Out(1,1,"Muhammad Alalimi");     //  printing name on first line
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1__2ND+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1__2ND+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;_2ND.c,30 :: 		do{
L_main0:
;_2ND.c,31 :: 		temperature= ADC_Read(0);        //taking reading in temperature varible
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _temperature+0 
	MOVF        R1, 0 
	MOVWF       _temperature+1 
;_2ND.c,32 :: 		mv=temperature*5000.0/1024.0;
	CALL        _word2double+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       64
	MOVWF       R5 
	MOVLW       28
	MOVWF       R6 
	MOVLW       139
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       137
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _mv+0 
	MOVF        R1, 0 
	MOVWF       _mv+1 
	MOVF        R2, 0 
	MOVWF       _mv+2 
	MOVF        R3, 0 
	MOVWF       _mv+3 
;_2ND.c,33 :: 		mv=mv/10.0;                     //converting to degree centigrade
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       32
	MOVWF       R6 
	MOVLW       130
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__main+0 
	MOVF        R1, 0 
	MOVWF       FLOC__main+1 
	MOVF        R2, 0 
	MOVWF       FLOC__main+2 
	MOVF        R3, 0 
	MOVWF       FLOC__main+3 
	MOVF        FLOC__main+0, 0 
	MOVWF       _mv+0 
	MOVF        FLOC__main+1, 0 
	MOVWF       _mv+1 
	MOVF        FLOC__main+2, 0 
	MOVWF       _mv+2 
	MOVF        FLOC__main+3, 0 
	MOVWF       _mv+3 
;_2ND.c,34 :: 		fht=(mv*9/5)+32;                //converting to faranhite
	MOVF        FLOC__main+0, 0 
	MOVWF       R0 
	MOVF        FLOC__main+1, 0 
	MOVWF       R1 
	MOVF        FLOC__main+2, 0 
	MOVWF       R2 
	MOVF        FLOC__main+3, 0 
	MOVWF       R3 
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       16
	MOVWF       R6 
	MOVLW       130
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       32
	MOVWF       R6 
	MOVLW       129
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       132
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _fht+0 
	MOVF        R1, 0 
	MOVWF       _fht+1 
	MOVF        R2, 0 
	MOVWF       _fht+2 
	MOVF        R3, 0 
	MOVWF       _fht+3 
;_2ND.c,35 :: 		FloatToStr(mv,txt);            // changing type to show on lcd
	MOVF        FLOC__main+0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        FLOC__main+1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        FLOC__main+2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        FLOC__main+3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       _txt+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;_2ND.c,36 :: 		FloatToStr(fht,txt1);          // changing type to show on lcd
	MOVF        _fht+0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        _fht+1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        _fht+2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        _fht+3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       _txt1+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(_txt1+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;_2ND.c,37 :: 		txt[4]=0;
	CLRF        _txt+4 
;_2ND.c,38 :: 		txt1[4]=0;
	CLRF        _txt1+4 
;_2ND.c,39 :: 		Lcd_Out(2,1,txt);              //printing txt on second line
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _txt+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;_2ND.c,40 :: 		Lcd_Chr(2,5,'C');              //printing C on second line
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       67
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;_2ND.c,41 :: 		Lcd_Out(2,10,txt1);             //printing txt1 on second line
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       10
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _txt1+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_txt1+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;_2ND.c,42 :: 		Lcd_Chr(2,14,'F');             //printing F on second line
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       70
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;_2ND.c,43 :: 		Delay_ms(300);                 //delay for 300ms
	MOVLW       13
	MOVWF       R11, 0
	MOVLW       45
	MOVWF       R12, 0
	MOVLW       215
	MOVWF       R13, 0
L_main3:
	DECFSZ      R13, 1, 1
	BRA         L_main3
	DECFSZ      R12, 1, 1
	BRA         L_main3
	DECFSZ      R11, 1, 1
	BRA         L_main3
	NOP
	NOP
;_2ND.c,45 :: 		while(1);
	GOTO        L_main0
;_2ND.c,46 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
