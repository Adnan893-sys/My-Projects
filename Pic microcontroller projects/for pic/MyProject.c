#include"lcd_lib.h"
void main() {
LCD_Init();
LCD_Clear();
delay_ms(100);
LCD_SetCursor(0,0);
LCD_string("ID: H00354030");
//First row
LCD_SetCursor(0,1);
LCD_string("Reem Faisal"); //second row
}

/*// LCD module connections
sbit LCD_RS at RE2_bit;   //Rs pin connected on RE2
sbit LCD_EN at RE1_bit;   //EN pin connected on RE1
sbit LCD_D4 at RD4_bit;   //D4 pin connected on  RD4
sbit LCD_D5 at RD5_bit;   //D5 pin connected on RD5
sbit LCD_D6 at RD6_bit;    //D6 pin connected on RD6
sbit LCD_D7 at RD7_bit;    //D7 pin connected on RD7

sbit LCD_RS_Direction at TRISE2_bit;
sbit LCD_EN_Direction at TRISE1_bit;
sbit LCD_D4_Direction at TRISD4_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D7_Direction at TRISD7_bit;
// End LCD module connections
 unsigned int temperature=0;     // taking temperature as variable
 float mv;                       // flaot mv variable
 float fht;
 unsigned char txt[15];
 unsigned char txt1[15];
void main(){
  ADCON1=0x0E;
  TRISA.RA0=1;                 //taking PoRTA pin0 as input for sensor
  ADC_Init();                 // initialize ADC
  Lcd_Init();                 // initialize LCD
  Lcd_Cmd(_LCD_CURSOR_OFF);   // lcd cursor off
  Lcd_Out(1,1,"MYNAMEIS");     //  printing name on first line
 // Lcd_Chr(2,8,223);

  do{
  temperature= ADC_Read(0);        //taking reading in temperature varible
  mv=temperature*5000.0/1024.0;
  mv=mv/10.0;                     //converting to degree centigrade
  fht=(mv*9/5)+32;                //converting to faranhite
  FloatToStr(mv,txt);            // changing type to show on lcd
  FloatToStr(fht,txt1);          // changing type to show on lcd
  txt[4]=0;
  txt1[4]=0;
  Lcd_Out(2,1,txt);              //printing txt on second line
  Lcd_Chr(2,5,'C');              //printing C on second line
  Lcd_Out(2,10,txt1);             //printing txt1 on second line
  Lcd_Chr(2,14,'F');             //printing F on second line
  Delay_ms(300);                 //delay for 300ms
  }
  while(1);
  }       */