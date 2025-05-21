#ifndef LCD_LIB_h
#define LCD_LIB_h
void LCD_Write(char cmd,int cmddta);
void LCD_Init();
void LCD_Clear();
void LCD_SetCursor(int row, int col);
void LCD_Char(char character);
void LCD_int(int n);
void LCD_string(char *character);
#endif