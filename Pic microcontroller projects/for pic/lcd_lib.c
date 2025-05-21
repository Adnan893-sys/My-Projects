//====================================================
//------------[ LCD Converter Routines ]--------------
#include"lcd_lib.h"
void LCD_Write(char cmd,int cmddta)
{
  //digitalWrite(RS,cmddta); //Change RS for command/data
  PORTB.F4=cmddta;
//digitalWrite(D4,(cmd & 0b00010000)>>4);
  PORTB.F0=(cmd & 0b00010000)>>4;
  //digitalWrite(D5,(cmd & 0b00100000)>>5);
  PORTB.F1=(cmd & 0b00100000)>>5;
  //digitalWrite(D6,(cmd & 0b01000000)>>6);
  PORTB.F2=(cmd & 0b01000000)>>6;
  //digitalWrite(D7,(cmd & 0b10000000)>>7);
  PORTB.F3=(cmd & 0b10000000)>>7;
  delay_us(500);
  //digitalWrite(E,HIGH);
  PORTB.F5=1;
  delay_us(500);
  //digitalWrite(E,LOW);
  PORTB.F5=0;
  delay_us(500);
  //digitalWrite(D4,(cmd & 0b00000001)>>0);
  PORTB.F0=(cmd & 0b00000001)>>0;
  //digitalWrite(D5,(cmd & 0b00000010)>>1);
  PORTB.F1=(cmd & 0b00000010)>>1;
  //digitalWrite(D6,(cmd & 0b00000100)>>2);
  PORTB.F2=(cmd & 0b00000100)>>2;
  //digitalWrite(D7,(cmd & 0b00001000)>>3);
  PORTB.F3=(cmd & 0b00001000)>>3;
  delay_us(500);
  //digitalWrite(E,HIGH);
  PORTB.F5=1;
  delay_us(500);
  //digitalWrite(E,LOW);
  PORTB.F5=0;
  delay_us(500);
}

void LCD_Init(){
  TRISB=0x00;
  ANSELB=0x00;
  LCD_Write(0x33,0);
  delay_us(500);
  LCD_Write(0x32,0);
  delay_us(500);
  LCD_Write(0x28,0);
  delay_us(500);
  LCD_Write(0x0C,0);
  delay_us(500);
  LCD_Write(0x06,0);
  delay_us(500);
  LCD_Write(0x01,0);
  delay_us(500);
}

void LCD_Clear(){
  LCD_Write(0x01,0);
}

void LCD_SetCursor(int row, int col){
   if (col == 0)LCD_Write((row | 0x80),0);
   if (col == 1)LCD_Write((row | 0x80)+ 0x40,0);
   if (col == 2)LCD_Write((row | 0x80)+ 0x10,0);
   if (col == 3)LCD_Write((row | 0x80)+ 0x50,0);
   delay_us(500);

}

void LCD_Char(char character){

  LCD_Write(character,1);
}

void LCD_int(int n)
{
  int n1,n2,n3,n4,n2_1,n3_1;
  n1=n%10;
  n2=(((n%100)-n1)/10);
  n3=(((n%1000)-(n2*10+n1))/100);
  n4=(((n%10000)-(n3*100+n2*10+n1))/1000);
  LCD_Char(n4+48);
  LCD_Char(n3+48);
  LCD_Char(n2+48);
  LCD_Char(n1+48);
}

void LCD_string(char *character)
{
        while(*character)
        {
        LCD_Write(*character++,1);
        }
}






