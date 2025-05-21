
_main:

;abc.c,46 :: 		void main() {
;abc.c,47 :: 		do_write();
	CALL        _do_write+0, 0
;abc.c,49 :: 		Keypad_Init();                           // Initialize Keypad
	CALL        _Keypad_Init+0, 0
;abc.c,50 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;abc.c,51 :: 		TRISB.F6=0; //for motor
	BCF         TRISB+0, 6 
;abc.c,52 :: 		TRISB.F7=0; //for motor
	BCF         TRISB+0, 7 
;abc.c,53 :: 		TRISB.F0=1;  //for button
	BSF         TRISB+0, 0 
;abc.c,54 :: 		TRISB.F4=1;  //for sensor
	BSF         TRISB+0, 4 
;abc.c,55 :: 		while(1){
L_main0:
;abc.c,56 :: 		while(PORTB.F0 == 0){
L_main2:
	BTFSC       PORTB+0, 0 
	GOTO        L_main3
;abc.c,57 :: 		Delay_ms(10);
	MOVLW       104
	MOVWF       R12, 0
	MOVLW       228
	MOVWF       R13, 0
L_main4:
	DECFSZ      R13, 1, 1
	BRA         L_main4
	DECFSZ      R12, 1, 1
	BRA         L_main4
	NOP
;abc.c,58 :: 		if(PORTB.F0 == 0){
	BTFSC       PORTB+0, 0 
	GOTO        L_main5
;abc.c,59 :: 		change_settings();}
	CALL        _change_settings+0, 0
L_main5:
;abc.c,60 :: 		}
	GOTO        L_main2
L_main3:
;abc.c,61 :: 		if(PORTB.F0 == 1){
	BTFSS       PORTB+0, 0 
	GOTO        L_main6
;abc.c,62 :: 		do_setup();
	CALL        _do_setup+0, 0
;abc.c,63 :: 		while(PORTB.F0 == 1) {
L_main7:
	BTFSS       PORTB+0, 0 
	GOTO        L_main8
;abc.c,64 :: 		take= EEPROM_Read(0x02);             // Read data from address 2 and display it on PORTB
	MOVLW       2
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _take+0 
	MOVLW       0
	MOVWF       _take+1 
;abc.c,65 :: 		IntToStr(take,txt2);
	MOVF        _take+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _take+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _txt2+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_txt2+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;abc.c,66 :: 		Lcd_Out(1,9,txt2);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       9
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _txt2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_txt2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;abc.c,67 :: 		if(PORTB.F4 == 0){
	BTFSC       PORTB+0, 4 
	GOTO        L_main9
;abc.c,68 :: 		Delay_ms(50);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_main10:
	DECFSZ      R13, 1, 1
	BRA         L_main10
	DECFSZ      R12, 1, 1
	BRA         L_main10
	DECFSZ      R11, 1, 1
	BRA         L_main10
;abc.c,69 :: 		if(PORTB.F4 == 0){
	BTFSC       PORTB+0, 4 
	GOTO        L_main11
;abc.c,70 :: 		count=count+1;
	INFSNZ      _count+0, 1 
	INCF        _count+1, 1 
;abc.c,71 :: 		IntToStr(count,txt2);
	MOVF        _count+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _count+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _txt2+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_txt2+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;abc.c,72 :: 		Lcd_Out(2,10,txt2);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       10
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _txt2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_txt2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;abc.c,73 :: 		if(count==take){
	MOVF        _count+1, 0 
	XORWF       _take+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main94
	MOVF        _take+0, 0 
	XORWF       _count+0, 0 
L__main94:
	BTFSS       STATUS+0, 2 
	GOTO        L_main12
;abc.c,74 :: 		total=total+count;
	MOVF        _count+0, 0 
	ADDWF       _total+0, 1 
	MOVF        _count+1, 0 
	ADDWFC      _total+1, 1 
;abc.c,75 :: 		Lcd_Cmd(_LCD_THIRD_ROW);
	MOVLW       148
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;abc.c,76 :: 		Lcd_Cmd(_LCD_RETURN_HOME);
	MOVLW       2
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;abc.c,77 :: 		Lcd_Cmd(_LCD_MOVE_CURSOR_RIGHT);
	MOVLW       20
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;abc.c,78 :: 		IntToStr(total,txt2);
	MOVF        _total+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _total+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _txt2+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_txt2+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;abc.c,79 :: 		Lcd_Out(3,2,txt2);
	MOVLW       3
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _txt2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_txt2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;abc.c,80 :: 		PORTB.F6 = 0 ;
	BCF         PORTB+0, 6 
;abc.c,81 :: 		PORTB.F7 = 1;
	BSF         PORTB+0, 7 
;abc.c,82 :: 		Delay_ms(500);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_main13:
	DECFSZ      R13, 1, 1
	BRA         L_main13
	DECFSZ      R12, 1, 1
	BRA         L_main13
	DECFSZ      R11, 1, 1
	BRA         L_main13
	NOP
;abc.c,83 :: 		PORTB.F6 = 0 ;
	BCF         PORTB+0, 6 
;abc.c,84 :: 		PORTB.F7 = 0;
	BCF         PORTB+0, 7 
;abc.c,85 :: 		count=0;
	CLRF        _count+0 
	CLRF        _count+1 
;abc.c,86 :: 		IntToStr(count,txt2);
	CLRF        FARG_IntToStr_input+0 
	CLRF        FARG_IntToStr_input+1 
	MOVLW       _txt2+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_txt2+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;abc.c,87 :: 		Lcd_Out(2,10,txt2);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       10
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _txt2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_txt2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;abc.c,89 :: 		}
L_main12:
;abc.c,92 :: 		}
L_main11:
;abc.c,94 :: 		}
L_main9:
;abc.c,95 :: 		}
	GOTO        L_main7
L_main8:
;abc.c,96 :: 		}
L_main6:
;abc.c,97 :: 		}
	GOTO        L_main0
;abc.c,98 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_read_pass:

;abc.c,101 :: 		void read_pass(void){
;abc.c,102 :: 		read[0]= EEPROM_Read(0x03);
	MOVLW       3
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _read+0 
;abc.c,103 :: 		read[1]= EEPROM_Read(0x04);
	MOVLW       4
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _read+1 
;abc.c,104 :: 		read[2]= EEPROM_Read(0x05);
	MOVLW       5
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _read+2 
;abc.c,105 :: 		read[3]= EEPROM_Read(0x06);
	MOVLW       6
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _read+3 
;abc.c,106 :: 		read[4]= EEPROM_Read(0x07);
	MOVLW       7
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _read+4 
;abc.c,107 :: 		}
L_end_read_pass:
	RETURN      0
; end of _read_pass

_read_pass1:

;abc.c,108 :: 		void read_pass1(void){
;abc.c,109 :: 		read[0]= EEPROM_Read(0x08);
	MOVLW       8
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _read+0 
;abc.c,110 :: 		read[1]= EEPROM_Read(0x09);
	MOVLW       9
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _read+1 
;abc.c,111 :: 		read[2]= EEPROM_Read(0x0A);
	MOVLW       10
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _read+2 
;abc.c,112 :: 		read[3]= EEPROM_Read(0x0B);
	MOVLW       11
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _read+3 
;abc.c,113 :: 		read[4]= EEPROM_Read(0x0C);
	MOVLW       12
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _read+4 
;abc.c,114 :: 		}
L_end_read_pass1:
	RETURN      0
; end of _read_pass1

_do_write:

;abc.c,115 :: 		void do_write(void){
;abc.c,117 :: 		EEPROM_Write(0x03,0x31);
	MOVLW       3
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       49
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;abc.c,118 :: 		Delay_ms(25);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_do_write14:
	DECFSZ      R13, 1, 1
	BRA         L_do_write14
	DECFSZ      R12, 1, 1
	BRA         L_do_write14
	DECFSZ      R11, 1, 1
	BRA         L_do_write14
	NOP
;abc.c,119 :: 		EEPROM_Write(0x04,0x32);
	MOVLW       4
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       50
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;abc.c,120 :: 		Delay_ms(25);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_do_write15:
	DECFSZ      R13, 1, 1
	BRA         L_do_write15
	DECFSZ      R12, 1, 1
	BRA         L_do_write15
	DECFSZ      R11, 1, 1
	BRA         L_do_write15
	NOP
;abc.c,121 :: 		EEPROM_Write(0x05,0x33);
	MOVLW       5
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       51
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;abc.c,122 :: 		Delay_ms(25);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_do_write16:
	DECFSZ      R13, 1, 1
	BRA         L_do_write16
	DECFSZ      R12, 1, 1
	BRA         L_do_write16
	DECFSZ      R11, 1, 1
	BRA         L_do_write16
	NOP
;abc.c,123 :: 		EEPROM_Write(0x06,0x23);
	MOVLW       6
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       35
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;abc.c,124 :: 		Delay_ms(25);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_do_write17:
	DECFSZ      R13, 1, 1
	BRA         L_do_write17
	DECFSZ      R12, 1, 1
	BRA         L_do_write17
	DECFSZ      R11, 1, 1
	BRA         L_do_write17
	NOP
;abc.c,125 :: 		EEPROM_Write(0x07,0x00);
	MOVLW       7
	MOVWF       FARG_EEPROM_Write_address+0 
	CLRF        FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;abc.c,126 :: 		Delay_ms(25);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_do_write18:
	DECFSZ      R13, 1, 1
	BRA         L_do_write18
	DECFSZ      R12, 1, 1
	BRA         L_do_write18
	DECFSZ      R11, 1, 1
	BRA         L_do_write18
	NOP
;abc.c,128 :: 		EEPROM_Write(0x08,0x34);
	MOVLW       8
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       52
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;abc.c,129 :: 		Delay_ms(25);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_do_write19:
	DECFSZ      R13, 1, 1
	BRA         L_do_write19
	DECFSZ      R12, 1, 1
	BRA         L_do_write19
	DECFSZ      R11, 1, 1
	BRA         L_do_write19
	NOP
;abc.c,130 :: 		EEPROM_Write(0x09,0x35);
	MOVLW       9
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       53
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;abc.c,131 :: 		Delay_ms(25);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_do_write20:
	DECFSZ      R13, 1, 1
	BRA         L_do_write20
	DECFSZ      R12, 1, 1
	BRA         L_do_write20
	DECFSZ      R11, 1, 1
	BRA         L_do_write20
	NOP
;abc.c,132 :: 		EEPROM_Write(0x0A,0x36);
	MOVLW       10
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       54
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;abc.c,133 :: 		Delay_ms(25);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_do_write21:
	DECFSZ      R13, 1, 1
	BRA         L_do_write21
	DECFSZ      R12, 1, 1
	BRA         L_do_write21
	DECFSZ      R11, 1, 1
	BRA         L_do_write21
	NOP
;abc.c,134 :: 		EEPROM_Write(0x0B,0x23);
	MOVLW       11
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       35
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;abc.c,135 :: 		Delay_ms(25);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_do_write22:
	DECFSZ      R13, 1, 1
	BRA         L_do_write22
	DECFSZ      R12, 1, 1
	BRA         L_do_write22
	DECFSZ      R11, 1, 1
	BRA         L_do_write22
	NOP
;abc.c,136 :: 		EEPROM_Write(0x0C,0x00);
	MOVLW       12
	MOVWF       FARG_EEPROM_Write_address+0 
	CLRF        FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;abc.c,137 :: 		Delay_ms(25);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_do_write23:
	DECFSZ      R13, 1, 1
	BRA         L_do_write23
	DECFSZ      R12, 1, 1
	BRA         L_do_write23
	DECFSZ      R11, 1, 1
	BRA         L_do_write23
	NOP
;abc.c,138 :: 		}
L_end_do_write:
	RETURN      0
; end of _do_write

_change_settings:

;abc.c,141 :: 		void change_settings(void){
;abc.c,142 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;abc.c,143 :: 		Lcd_Out(1, 1, "Admin:");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_abc+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_abc+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;abc.c,144 :: 		get_password();
	CALL        _get_password+0, 0
;abc.c,145 :: 		read_pass();
	CALL        _read_pass+0, 0
;abc.c,146 :: 		show=strcmp(kp,read);
	MOVLW       _kp+0
	MOVWF       FARG_strcmp_s1+0 
	MOVLW       hi_addr(_kp+0)
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       _read+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(_read+0)
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVF        R0, 0 
	MOVWF       _show+0 
	MOVF        R1, 0 
	MOVWF       _show+1 
;abc.c,147 :: 		if(show=='\0'){
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__change_settings99
	MOVLW       0
	XORWF       R0, 0 
L__change_settings99:
	BTFSS       STATUS+0, 2 
	GOTO        L_change_settings24
;abc.c,148 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;abc.c,149 :: 		Lcd_Out(1, 1, "Password:");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_abc+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_abc+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;abc.c,150 :: 		get_password();
	CALL        _get_password+0, 0
;abc.c,151 :: 		read_pass1();
	CALL        _read_pass1+0, 0
;abc.c,152 :: 		show1=strcmp(kp,read);
	MOVLW       _kp+0
	MOVWF       FARG_strcmp_s1+0 
	MOVLW       hi_addr(_kp+0)
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       _read+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(_read+0)
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVF        R0, 0 
	MOVWF       _show1+0 
	MOVF        R1, 0 
	MOVWF       _show1+1 
;abc.c,153 :: 		if(show1=='\0'){
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__change_settings100
	MOVLW       0
	XORWF       R0, 0 
L__change_settings100:
	BTFSS       STATUS+0, 2 
	GOTO        L_change_settings25
;abc.c,154 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;abc.c,155 :: 		Lcd_Out(1, 1, "Change Setting");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr3_abc+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr3_abc+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;abc.c,156 :: 		Lcd_Out(2, 1, "Tablets:");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr4_abc+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr4_abc+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;abc.c,157 :: 		GetNumber();
	CALL        _GetNumber+0, 0
;abc.c,158 :: 		V2=num;
	MOVF        _num+0, 0 
	MOVWF       _V2+0 
	MOVF        _num+1, 0 
	MOVWF       _V2+1 
;abc.c,159 :: 		EEPROM_Write(0x02,V2);               // Write some data at address 2
	MOVLW       2
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _num+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;abc.c,160 :: 		Delay_ms(100);}
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       15
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_change_settings26:
	DECFSZ      R13, 1, 1
	BRA         L_change_settings26
	DECFSZ      R12, 1, 1
	BRA         L_change_settings26
	DECFSZ      R11, 1, 1
	BRA         L_change_settings26
	GOTO        L_change_settings27
L_change_settings25:
;abc.c,162 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;abc.c,163 :: 		Lcd_Out(1, 1, " password invalid");}
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr5_abc+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr5_abc+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
L_change_settings27:
;abc.c,164 :: 		}
	GOTO        L_change_settings28
L_change_settings24:
;abc.c,167 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;abc.c,168 :: 		Lcd_Out(1, 1, "invalid");}
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr6_abc+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr6_abc+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
L_change_settings28:
;abc.c,173 :: 		}
L_end_change_settings:
	RETURN      0
; end of _change_settings

_do_setup:

;abc.c,175 :: 		void  do_setup(void){
;abc.c,176 :: 		cnt = 0;                                 // Reset counter
	CLRF        _cnt+0 
;abc.c,177 :: 		Lcd_Cmd(_LCD_CLEAR);                     // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;abc.c,178 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);                // Cursor off
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;abc.c,179 :: 		Lcd_Out(1, 1, "To fill:");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr7_abc+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr7_abc+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;abc.c,180 :: 		Lcd_Out(2, 1, "Currently:");                 // Write message text on LCD
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr8_abc+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr8_abc+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;abc.c,181 :: 		Lcd_Cmd(_LCD_THIRD_ROW);
	MOVLW       148
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;abc.c,182 :: 		Lcd_Cmd(_LCD_RETURN_HOME);
	MOVLW       2
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;abc.c,183 :: 		Lcd_Out(3, -3, "Total:");
	MOVLW       3
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       253
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr9_abc+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr9_abc+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;abc.c,184 :: 		Lcd_Cmd(_LCD_FOURTH_ROW);
	MOVLW       212
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;abc.c,185 :: 		Lcd_Cmd(_LCD_RETURN_HOME);
	MOVLW       2
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;abc.c,186 :: 		Lcd_Out(4, -3, "Button to Change");
	MOVLW       4
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       253
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr10_abc+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr10_abc+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;abc.c,187 :: 		}
L_end_do_setup:
	RETURN      0
; end of _do_setup

_get_password:

;abc.c,189 :: 		void get_password(void){
;abc.c,190 :: 		int cn=11;
	MOVLW       11
	MOVWF       get_password_cn_L0+0 
	MOVLW       0
	MOVWF       get_password_cn_L0+1 
;abc.c,191 :: 		for(i=0;i<=3;i++){
	CLRF        _i+0 
L_get_password29:
	MOVF        _i+0, 0 
	SUBLW       3
	BTFSS       STATUS+0, 0 
	GOTO        L_get_password30
;abc.c,192 :: 		do
L_get_password32:
;abc.c,193 :: 		kp[i] = Keypad_Key_Click();
	MOVLW       _kp+0
	MOVWF       FLOC__get_password+0 
	MOVLW       hi_addr(_kp+0)
	MOVWF       FLOC__get_password+1 
	MOVF        _i+0, 0 
	ADDWF       FLOC__get_password+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FLOC__get_password+1, 1 
	CALL        _Keypad_Key_Click+0, 0
	MOVFF       FLOC__get_password+0, FSR1L+0
	MOVFF       FLOC__get_password+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;abc.c,194 :: 		while (!kp[i]);
	MOVLW       _kp+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_kp+0)
	MOVWF       FSR0L+1 
	MOVF        _i+0, 0 
	ADDWF       FSR0L+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0L+1, 1 
	MOVF        POSTINC0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_get_password32
;abc.c,195 :: 		switch (kp[i]) {
	MOVLW       _kp+0
	MOVWF       R1 
	MOVLW       hi_addr(_kp+0)
	MOVWF       R2 
	MOVF        _i+0, 0 
	ADDWF       R1, 1 
	BTFSC       STATUS+0, 0 
	INCF        R2, 1 
	GOTO        L_get_password35
;abc.c,196 :: 		case  1: kp[i] = 55; break; // 7   55      // Uncomment this block for keypad4x4
L_get_password37:
	MOVLW       _kp+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_kp+0)
	MOVWF       FSR1L+1 
	MOVF        _i+0, 0 
	ADDWF       FSR1L+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1L+1, 1 
	MOVLW       55
	MOVWF       POSTINC1+0 
	GOTO        L_get_password36
;abc.c,197 :: 		case  2: kp[i] = 56; break; // 8   56
L_get_password38:
	MOVLW       _kp+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_kp+0)
	MOVWF       FSR1L+1 
	MOVF        _i+0, 0 
	ADDWF       FSR1L+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1L+1, 1 
	MOVLW       56
	MOVWF       POSTINC1+0 
	GOTO        L_get_password36
;abc.c,198 :: 		case  3: kp[i] = 57; break; // 9   57
L_get_password39:
	MOVLW       _kp+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_kp+0)
	MOVWF       FSR1L+1 
	MOVF        _i+0, 0 
	ADDWF       FSR1L+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1L+1, 1 
	MOVLW       57
	MOVWF       POSTINC1+0 
	GOTO        L_get_password36
;abc.c,199 :: 		case  4: kp[i] = 214; break; // /   214
L_get_password40:
	MOVLW       _kp+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_kp+0)
	MOVWF       FSR1L+1 
	MOVF        _i+0, 0 
	ADDWF       FSR1L+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1L+1, 1 
	MOVLW       214
	MOVWF       POSTINC1+0 
	GOTO        L_get_password36
;abc.c,200 :: 		case  5: kp[i] = 52; break; // 4   52
L_get_password41:
	MOVLW       _kp+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_kp+0)
	MOVWF       FSR1L+1 
	MOVF        _i+0, 0 
	ADDWF       FSR1L+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1L+1, 1 
	MOVLW       52
	MOVWF       POSTINC1+0 
	GOTO        L_get_password36
;abc.c,201 :: 		case  6: kp[i] = 53; break; // 5   53
L_get_password42:
	MOVLW       _kp+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_kp+0)
	MOVWF       FSR1L+1 
	MOVF        _i+0, 0 
	ADDWF       FSR1L+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1L+1, 1 
	MOVLW       53
	MOVWF       POSTINC1+0 
	GOTO        L_get_password36
;abc.c,202 :: 		case  7: kp[i] = 54; break; // 6   54
L_get_password43:
	MOVLW       _kp+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_kp+0)
	MOVWF       FSR1L+1 
	MOVF        _i+0, 0 
	ADDWF       FSR1L+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1L+1, 1 
	MOVLW       54
	MOVWF       POSTINC1+0 
	GOTO        L_get_password36
;abc.c,203 :: 		case  8: kp[i] = 120; break; // *   120
L_get_password44:
	MOVLW       _kp+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_kp+0)
	MOVWF       FSR1L+1 
	MOVF        _i+0, 0 
	ADDWF       FSR1L+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1L+1, 1 
	MOVLW       120
	MOVWF       POSTINC1+0 
	GOTO        L_get_password36
;abc.c,204 :: 		case  9: kp[i] = 49; break; // 1  49
L_get_password45:
	MOVLW       _kp+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_kp+0)
	MOVWF       FSR1L+1 
	MOVF        _i+0, 0 
	ADDWF       FSR1L+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1L+1, 1 
	MOVLW       49
	MOVWF       POSTINC1+0 
	GOTO        L_get_password36
;abc.c,205 :: 		case 10: kp[i] = 50; break; // 2    50
L_get_password46:
	MOVLW       _kp+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_kp+0)
	MOVWF       FSR1L+1 
	MOVF        _i+0, 0 
	ADDWF       FSR1L+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1L+1, 1 
	MOVLW       50
	MOVWF       POSTINC1+0 
	GOTO        L_get_password36
;abc.c,206 :: 		case 11: kp[i] = 51; break; // 3    51
L_get_password47:
	MOVLW       _kp+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_kp+0)
	MOVWF       FSR1L+1 
	MOVF        _i+0, 0 
	ADDWF       FSR1L+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1L+1, 1 
	MOVLW       51
	MOVWF       POSTINC1+0 
	GOTO        L_get_password36
;abc.c,207 :: 		case 12: kp[i] = 208; break; // -    208
L_get_password48:
	MOVLW       _kp+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_kp+0)
	MOVWF       FSR1L+1 
	MOVF        _i+0, 0 
	ADDWF       FSR1L+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1L+1, 1 
	MOVLW       208
	MOVWF       POSTINC1+0 
	GOTO        L_get_password36
;abc.c,208 :: 		case 13: kp[i] = 35; break; // #   35
L_get_password49:
	MOVLW       _kp+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_kp+0)
	MOVWF       FSR1L+1 
	MOVF        _i+0, 0 
	ADDWF       FSR1L+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1L+1, 1 
	MOVLW       35
	MOVWF       POSTINC1+0 
	GOTO        L_get_password36
;abc.c,209 :: 		case 14: kp[i] = 48; break; // 0
L_get_password50:
	MOVLW       _kp+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_kp+0)
	MOVWF       FSR1L+1 
	MOVF        _i+0, 0 
	ADDWF       FSR1L+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1L+1, 1 
	MOVLW       48
	MOVWF       POSTINC1+0 
	GOTO        L_get_password36
;abc.c,210 :: 		case 15: kp[i] = 61; break; // =    61
L_get_password51:
	MOVLW       _kp+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_kp+0)
	MOVWF       FSR1L+1 
	MOVF        _i+0, 0 
	ADDWF       FSR1L+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1L+1, 1 
	MOVLW       61
	MOVWF       POSTINC1+0 
	GOTO        L_get_password36
;abc.c,211 :: 		case 16: kp[i] = 43; break; // +    43
L_get_password52:
	MOVLW       _kp+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_kp+0)
	MOVWF       FSR1L+1 
	MOVF        _i+0, 0 
	ADDWF       FSR1L+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1L+1, 1 
	MOVLW       43
	MOVWF       POSTINC1+0 
	GOTO        L_get_password36
;abc.c,212 :: 		}
L_get_password35:
	MOVFF       R1, FSR0L+0
	MOVFF       R2, FSR0H+0
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_get_password37
	MOVFF       R1, FSR0L+0
	MOVFF       R2, FSR0H+0
	MOVF        POSTINC0+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_get_password38
	MOVFF       R1, FSR0L+0
	MOVFF       R2, FSR0H+0
	MOVF        POSTINC0+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_get_password39
	MOVFF       R1, FSR0L+0
	MOVFF       R2, FSR0H+0
	MOVF        POSTINC0+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_get_password40
	MOVFF       R1, FSR0L+0
	MOVFF       R2, FSR0H+0
	MOVF        POSTINC0+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_get_password41
	MOVFF       R1, FSR0L+0
	MOVFF       R2, FSR0H+0
	MOVF        POSTINC0+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_get_password42
	MOVFF       R1, FSR0L+0
	MOVFF       R2, FSR0H+0
	MOVF        POSTINC0+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_get_password43
	MOVFF       R1, FSR0L+0
	MOVFF       R2, FSR0H+0
	MOVF        POSTINC0+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_get_password44
	MOVFF       R1, FSR0L+0
	MOVFF       R2, FSR0H+0
	MOVF        POSTINC0+0, 0 
	XORLW       9
	BTFSC       STATUS+0, 2 
	GOTO        L_get_password45
	MOVFF       R1, FSR0L+0
	MOVFF       R2, FSR0H+0
	MOVF        POSTINC0+0, 0 
	XORLW       10
	BTFSC       STATUS+0, 2 
	GOTO        L_get_password46
	MOVFF       R1, FSR0L+0
	MOVFF       R2, FSR0H+0
	MOVF        POSTINC0+0, 0 
	XORLW       11
	BTFSC       STATUS+0, 2 
	GOTO        L_get_password47
	MOVFF       R1, FSR0L+0
	MOVFF       R2, FSR0H+0
	MOVF        POSTINC0+0, 0 
	XORLW       12
	BTFSC       STATUS+0, 2 
	GOTO        L_get_password48
	MOVFF       R1, FSR0L+0
	MOVFF       R2, FSR0H+0
	MOVF        POSTINC0+0, 0 
	XORLW       13
	BTFSC       STATUS+0, 2 
	GOTO        L_get_password49
	MOVFF       R1, FSR0L+0
	MOVFF       R2, FSR0H+0
	MOVF        POSTINC0+0, 0 
	XORLW       14
	BTFSC       STATUS+0, 2 
	GOTO        L_get_password50
	MOVFF       R1, FSR0L+0
	MOVFF       R2, FSR0H+0
	MOVF        POSTINC0+0, 0 
	XORLW       15
	BTFSC       STATUS+0, 2 
	GOTO        L_get_password51
	MOVFF       R1, FSR0L+0
	MOVFF       R2, FSR0H+0
	MOVF        POSTINC0+0, 0 
	XORLW       16
	BTFSC       STATUS+0, 2 
	GOTO        L_get_password52
L_get_password36:
;abc.c,213 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;abc.c,214 :: 		Lcd_Chr(1, cn, kp[i]);
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVF        get_password_cn_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       _kp+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_kp+0)
	MOVWF       FSR0L+1 
	MOVF        _i+0, 0 
	ADDWF       FSR0L+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0L+1, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;abc.c,215 :: 		cn++;
	INFSNZ      get_password_cn_L0+0, 1 
	INCF        get_password_cn_L0+1, 1 
;abc.c,191 :: 		for(i=0;i<=3;i++){
	INCF        _i+0, 1 
;abc.c,216 :: 		}
	GOTO        L_get_password29
L_get_password30:
;abc.c,217 :: 		}
L_end_get_password:
	RETURN      0
; end of _get_password

_get_Counter:

;abc.c,219 :: 		void get_Counter(void){
;abc.c,220 :: 		do
L_get_Counter53:
;abc.c,221 :: 		kpx = Keypad_Key_Click();
	CALL        _Keypad_Key_Click+0, 0
	MOVF        R0, 0 
	MOVWF       _kpx+0 
;abc.c,222 :: 		while (!kpx);
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_get_Counter53
;abc.c,223 :: 		switch (kpx) {
	GOTO        L_get_Counter56
;abc.c,224 :: 		case  1: kpx = 55; break; // 7   55      // Uncomment this block for keypad4x4
L_get_Counter58:
	MOVLW       55
	MOVWF       _kpx+0 
	GOTO        L_get_Counter57
;abc.c,225 :: 		case  2: kpx = 56; break; // 8   56
L_get_Counter59:
	MOVLW       56
	MOVWF       _kpx+0 
	GOTO        L_get_Counter57
;abc.c,226 :: 		case  3: kpx = 57; break; // 9   57
L_get_Counter60:
	MOVLW       57
	MOVWF       _kpx+0 
	GOTO        L_get_Counter57
;abc.c,227 :: 		case  4: kpx = 214; break; // /   214
L_get_Counter61:
	MOVLW       214
	MOVWF       _kpx+0 
	GOTO        L_get_Counter57
;abc.c,228 :: 		case  5: kpx = 52; break; // 4   52
L_get_Counter62:
	MOVLW       52
	MOVWF       _kpx+0 
	GOTO        L_get_Counter57
;abc.c,229 :: 		case  6: kpx = 53; break; // 5   53
L_get_Counter63:
	MOVLW       53
	MOVWF       _kpx+0 
	GOTO        L_get_Counter57
;abc.c,230 :: 		case  7: kpx = 54; break; // 6   54
L_get_Counter64:
	MOVLW       54
	MOVWF       _kpx+0 
	GOTO        L_get_Counter57
;abc.c,231 :: 		case  8: kpx = 120; break; // *   120
L_get_Counter65:
	MOVLW       120
	MOVWF       _kpx+0 
	GOTO        L_get_Counter57
;abc.c,232 :: 		case  9: kpx = 49; break; // 1  49
L_get_Counter66:
	MOVLW       49
	MOVWF       _kpx+0 
	GOTO        L_get_Counter57
;abc.c,233 :: 		case 10: kpx = 50; break; // 2    50
L_get_Counter67:
	MOVLW       50
	MOVWF       _kpx+0 
	GOTO        L_get_Counter57
;abc.c,234 :: 		case 11: kpx = 51; break; // 3    51
L_get_Counter68:
	MOVLW       51
	MOVWF       _kpx+0 
	GOTO        L_get_Counter57
;abc.c,235 :: 		case 12: kpx = 208; break; // -    208
L_get_Counter69:
	MOVLW       208
	MOVWF       _kpx+0 
	GOTO        L_get_Counter57
;abc.c,236 :: 		case 13: kpx = 35; break; // #   35
L_get_Counter70:
	MOVLW       35
	MOVWF       _kpx+0 
	GOTO        L_get_Counter57
;abc.c,237 :: 		case 14: kpx = 48; break; // 0
L_get_Counter71:
	MOVLW       48
	MOVWF       _kpx+0 
	GOTO        L_get_Counter57
;abc.c,238 :: 		case 15: kpx = 61; break; // =    61
L_get_Counter72:
	MOVLW       61
	MOVWF       _kpx+0 
	GOTO        L_get_Counter57
;abc.c,239 :: 		case 16: kpx = 43; break; // +    43
L_get_Counter73:
	MOVLW       43
	MOVWF       _kpx+0 
	GOTO        L_get_Counter57
;abc.c,240 :: 		}
L_get_Counter56:
	MOVF        _kpx+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_get_Counter58
	MOVF        _kpx+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_get_Counter59
	MOVF        _kpx+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_get_Counter60
	MOVF        _kpx+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_get_Counter61
	MOVF        _kpx+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_get_Counter62
	MOVF        _kpx+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_get_Counter63
	MOVF        _kpx+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_get_Counter64
	MOVF        _kpx+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_get_Counter65
	MOVF        _kpx+0, 0 
	XORLW       9
	BTFSC       STATUS+0, 2 
	GOTO        L_get_Counter66
	MOVF        _kpx+0, 0 
	XORLW       10
	BTFSC       STATUS+0, 2 
	GOTO        L_get_Counter67
	MOVF        _kpx+0, 0 
	XORLW       11
	BTFSC       STATUS+0, 2 
	GOTO        L_get_Counter68
	MOVF        _kpx+0, 0 
	XORLW       12
	BTFSC       STATUS+0, 2 
	GOTO        L_get_Counter69
	MOVF        _kpx+0, 0 
	XORLW       13
	BTFSC       STATUS+0, 2 
	GOTO        L_get_Counter70
	MOVF        _kpx+0, 0 
	XORLW       14
	BTFSC       STATUS+0, 2 
	GOTO        L_get_Counter71
	MOVF        _kpx+0, 0 
	XORLW       15
	BTFSC       STATUS+0, 2 
	GOTO        L_get_Counter72
	MOVF        _kpx+0, 0 
	XORLW       16
	BTFSC       STATUS+0, 2 
	GOTO        L_get_Counter73
L_get_Counter57:
;abc.c,241 :: 		}
L_end_get_Counter:
	RETURN      0
; end of _get_Counter

_GetNumber:

;abc.c,243 :: 		void GetNumber(){
;abc.c,244 :: 		int cn1=10;
	MOVLW       10
	MOVWF       GetNumber_cn1_L0+0 
	MOVLW       0
	MOVWF       GetNumber_cn1_L0+1 
;abc.c,246 :: 		get_Counter();
	CALL        _get_Counter+0, 0
;abc.c,247 :: 		V1=kpx;
	MOVF        _kpx+0, 0 
	MOVWF       _V1+0 
	MOVLW       0
	MOVWF       _V1+1 
;abc.c,249 :: 		while(V1 != 35){
L_GetNumber74:
	MOVLW       0
	XORWF       _V1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetNumber105
	MOVLW       35
	XORWF       _V1+0, 0 
L__GetNumber105:
	BTFSC       STATUS+0, 2 
	GOTO        L_GetNumber75
;abc.c,250 :: 		Lcd_Chr(2, cn1, kpx);
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVF        GetNumber_cn1_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVF        _kpx+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;abc.c,251 :: 		cn1++;
	INFSNZ      GetNumber_cn1_L0+0, 1 
	INCF        GetNumber_cn1_L0+1, 1 
;abc.c,252 :: 		switch (V1){
	GOTO        L_GetNumber76
;abc.c,254 :: 		case 48: case 49: case 50: case 51: case 52:
L_GetNumber78:
L_GetNumber79:
L_GetNumber80:
L_GetNumber81:
L_GetNumber82:
;abc.c,255 :: 		case 53: case 54: case 55: case 56: case 57:
L_GetNumber83:
L_GetNumber84:
L_GetNumber85:
L_GetNumber86:
L_GetNumber87:
;abc.c,256 :: 		num = num * 10 + (V1 - '0');
	MOVF        _num+0, 0 
	MOVWF       R0 
	MOVF        _num+1, 0 
	MOVWF       R1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       48
	SUBWF       _V1+0, 0 
	MOVWF       R2 
	MOVLW       0
	SUBWFB      _V1+1, 0 
	MOVWF       R3 
	MOVF        R2, 0 
	ADDWF       R0, 0 
	MOVWF       _num+0 
	MOVF        R3, 0 
	ADDWFC      R1, 0 
	MOVWF       _num+1 
;abc.c,258 :: 		break;
	GOTO        L_GetNumber77
;abc.c,260 :: 		case 214:  case 120: case 208: case 43: case 61:
L_GetNumber88:
L_GetNumber89:
L_GetNumber90:
L_GetNumber91:
L_GetNumber92:
;abc.c,261 :: 		num = 0;
	CLRF        _num+0 
	CLRF        _num+1 
;abc.c,262 :: 		break;
	GOTO        L_GetNumber77
;abc.c,263 :: 		}
L_GetNumber76:
	MOVLW       0
	XORWF       _V1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetNumber106
	MOVLW       48
	XORWF       _V1+0, 0 
L__GetNumber106:
	BTFSC       STATUS+0, 2 
	GOTO        L_GetNumber78
	MOVLW       0
	XORWF       _V1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetNumber107
	MOVLW       49
	XORWF       _V1+0, 0 
L__GetNumber107:
	BTFSC       STATUS+0, 2 
	GOTO        L_GetNumber79
	MOVLW       0
	XORWF       _V1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetNumber108
	MOVLW       50
	XORWF       _V1+0, 0 
L__GetNumber108:
	BTFSC       STATUS+0, 2 
	GOTO        L_GetNumber80
	MOVLW       0
	XORWF       _V1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetNumber109
	MOVLW       51
	XORWF       _V1+0, 0 
L__GetNumber109:
	BTFSC       STATUS+0, 2 
	GOTO        L_GetNumber81
	MOVLW       0
	XORWF       _V1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetNumber110
	MOVLW       52
	XORWF       _V1+0, 0 
L__GetNumber110:
	BTFSC       STATUS+0, 2 
	GOTO        L_GetNumber82
	MOVLW       0
	XORWF       _V1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetNumber111
	MOVLW       53
	XORWF       _V1+0, 0 
L__GetNumber111:
	BTFSC       STATUS+0, 2 
	GOTO        L_GetNumber83
	MOVLW       0
	XORWF       _V1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetNumber112
	MOVLW       54
	XORWF       _V1+0, 0 
L__GetNumber112:
	BTFSC       STATUS+0, 2 
	GOTO        L_GetNumber84
	MOVLW       0
	XORWF       _V1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetNumber113
	MOVLW       55
	XORWF       _V1+0, 0 
L__GetNumber113:
	BTFSC       STATUS+0, 2 
	GOTO        L_GetNumber85
	MOVLW       0
	XORWF       _V1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetNumber114
	MOVLW       56
	XORWF       _V1+0, 0 
L__GetNumber114:
	BTFSC       STATUS+0, 2 
	GOTO        L_GetNumber86
	MOVLW       0
	XORWF       _V1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetNumber115
	MOVLW       57
	XORWF       _V1+0, 0 
L__GetNumber115:
	BTFSC       STATUS+0, 2 
	GOTO        L_GetNumber87
	MOVLW       0
	XORWF       _V1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetNumber116
	MOVLW       214
	XORWF       _V1+0, 0 
L__GetNumber116:
	BTFSC       STATUS+0, 2 
	GOTO        L_GetNumber88
	MOVLW       0
	XORWF       _V1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetNumber117
	MOVLW       120
	XORWF       _V1+0, 0 
L__GetNumber117:
	BTFSC       STATUS+0, 2 
	GOTO        L_GetNumber89
	MOVLW       0
	XORWF       _V1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetNumber118
	MOVLW       208
	XORWF       _V1+0, 0 
L__GetNumber118:
	BTFSC       STATUS+0, 2 
	GOTO        L_GetNumber90
	MOVLW       0
	XORWF       _V1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetNumber119
	MOVLW       43
	XORWF       _V1+0, 0 
L__GetNumber119:
	BTFSC       STATUS+0, 2 
	GOTO        L_GetNumber91
	MOVLW       0
	XORWF       _V1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetNumber120
	MOVLW       61
	XORWF       _V1+0, 0 
L__GetNumber120:
	BTFSC       STATUS+0, 2 
	GOTO        L_GetNumber92
L_GetNumber77:
;abc.c,265 :: 		get_Counter();
	CALL        _get_Counter+0, 0
;abc.c,266 :: 		V1=kpx;
	MOVF        _kpx+0, 0 
	MOVWF       _V1+0 
	MOVLW       0
	MOVWF       _V1+1 
;abc.c,267 :: 		}
	GOTO        L_GetNumber74
L_GetNumber75:
;abc.c,268 :: 		}
L_end_GetNumber:
	RETURN      0
; end of _GetNumber
