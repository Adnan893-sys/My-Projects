#line 1 "C:/Users/Zulfiqar/Desktop/my work done/PIC/for pic/MyProject.c"
#line 1 "c:/users/zulfiqar/desktop/my work done/pic/for pic/lcd_lib.h"


void LCD_Write(char cmd,int cmddta);
void LCD_Init();
void LCD_Clear();
void LCD_SetCursor(int row, int col);
void LCD_Char(char character);
void LCD_int(int n);
void LCD_string(char *character);
#line 2 "C:/Users/Zulfiqar/Desktop/my work done/PIC/for pic/MyProject.c"
void main() {
LCD_Init();
LCD_Clear();
delay_ms(100);
LCD_SetCursor(0,0);
LCD_string("ID: H00354030");

LCD_SetCursor(0,1);
LCD_string("Reem Faisal");
}
