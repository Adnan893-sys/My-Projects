#line 1 "C:/Users/Zulfiqar/Desktop/my work done/PIC/2ND/_2ND.c"

sbit LCD_RS at RD2_bit;
sbit LCD_EN at RD3_bit;
sbit LCD_D4 at RD4_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D7 at RD7_bit;

sbit LCD_RS_Direction at TRISD2_bit;
sbit LCD_EN_Direction at TRISD3_bit;
sbit LCD_D4_Direction at TRISD4_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D7_Direction at TRISD7_bit;

 unsigned int temperature=0;
 float mv;
 float fht;
 unsigned char txt[15];
 unsigned char txt1[15];
void main(){
 ADCON1=0x0E;
 TRISA.RA0=1;
 ADC_Init();
 Lcd_Init();
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Out(1,1,"Muhammad Alalimi");


 do{
 temperature= ADC_Read(0);
 mv=temperature*5000.0/1024.0;
 mv=mv/10.0;
 fht=(mv*9/5)+32;
 FloatToStr(mv,txt);
 FloatToStr(fht,txt1);
 txt[4]=0;
 txt1[4]=0;
 Lcd_Out(2,1,txt);
 Lcd_Chr(2,5,'C');
 Lcd_Out(2,10,txt1);
 Lcd_Chr(2,14,'F');
 Delay_ms(300);
 }
 while(1);
 }
