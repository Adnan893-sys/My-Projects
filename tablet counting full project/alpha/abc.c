unsigned short kpx, cnt, oldstate ,i= 0;
char ii;
int V2,V1,count=0;

int num = 0;
int total = 0;
unsigned int take=0,x=0;


 //char Admin[5]="123#";
 //char pass[5]="456#";
 int show,show1;
void get_password(void);
void  do_setup(void);
void get_Counter(void);
void GetNumber(void);
void change_settings(void);
void do_write(void);
 void read_pass(void);
 void read_pass1(void);
unsigned char txt[15];
unsigned char txt1[15];
unsigned char txt2[15];
unsigned  short  kp[5]={0,0,0,0,'\0'};
unsigned  short read[5]={0,0,0,0,'\0'};

char  keypadPort at PORTD;

// LCD module connections
sbit LCD_RS at RC2_bit;
sbit LCD_EN at RC3_bit;
sbit LCD_D4 at RC4_bit;
sbit LCD_D5 at RC5_bit;
sbit LCD_D6 at RC6_bit;
sbit LCD_D7 at RC7_bit;

sbit LCD_RS_Direction at TRISC2_bit;
sbit LCD_EN_Direction at TRISC3_bit;
sbit LCD_D4_Direction at TRISC4_bit;
sbit LCD_D5_Direction at TRISC5_bit;
sbit LCD_D6_Direction at TRISC6_bit;
sbit LCD_D7_Direction at TRISC7_bit;

// End LCD module connections

void main() {
do_write();

Keypad_Init();                           // Initialize Keypad
Lcd_Init();
 TRISB.F6=0; //for motor
 TRISB.F7=0; //for motor
 TRISB.F0=1;  //for button
 TRISB.F4=1;  //for sensor
while(1){
 while(PORTB.F0 == 0){
    Delay_ms(10);
    if(PORTB.F0 == 0){
    change_settings();}
  }
 if(PORTB.F0 == 1){
  do_setup();
 while(PORTB.F0 == 1) {
  take= EEPROM_Read(0x02);             // Read data from address 2 and display it on PORTB
  IntToStr(take,txt2);
   Lcd_Out(1,9,txt2);
                 if(PORTB.F4 == 0){
                  Delay_ms(50);
                     if(PORTB.F4 == 0){
                      count=count+1;
                      IntToStr(count,txt2);
                       Lcd_Out(2,10,txt2);
                       if(count==take){
                       total=total+count;
                       Lcd_Cmd(_LCD_THIRD_ROW);
                       Lcd_Cmd(_LCD_RETURN_HOME);
                       Lcd_Cmd(_LCD_MOVE_CURSOR_RIGHT);
                       IntToStr(total,txt2);
                       Lcd_Out(3,2,txt2);
                       PORTB.F6 = 0 ;
                       PORTB.F7 = 1;
                       Delay_ms(500);
                       PORTB.F6 = 0 ;
                       PORTB.F7 = 0;
                       count=0;
                       IntToStr(count,txt2);
                       Lcd_Out(2,10,txt2);

                       }


                       }

                        }
 }
  }
  }
  }
 ////////////////////////////////////////////////////////////////////////////////////////////////////////
 ////////////////////////////////////////////////////////////////////////////////////////////////////////
 void read_pass(void){
 read[0]= EEPROM_Read(0x03);
 read[1]= EEPROM_Read(0x04);
 read[2]= EEPROM_Read(0x05);
 read[3]= EEPROM_Read(0x06);
 read[4]= EEPROM_Read(0x07);
 }
 void read_pass1(void){
 read[0]= EEPROM_Read(0x08);
 read[1]= EEPROM_Read(0x09);
 read[2]= EEPROM_Read(0x0A);
 read[3]= EEPROM_Read(0x0B);
 read[4]= EEPROM_Read(0x0C);
 }
 void do_write(void){
      ///for admin
EEPROM_Write(0x03,0x31);
Delay_ms(25);
EEPROM_Write(0x04,0x32);
Delay_ms(25);
EEPROM_Write(0x05,0x33);
Delay_ms(25);
EEPROM_Write(0x06,0x23);
Delay_ms(25);
EEPROM_Write(0x07,0x00);
Delay_ms(25);
/////for password
EEPROM_Write(0x08,0x34);
Delay_ms(25);
EEPROM_Write(0x09,0x35);
Delay_ms(25);
EEPROM_Write(0x0A,0x36);
Delay_ms(25);
EEPROM_Write(0x0B,0x23);
Delay_ms(25);
EEPROM_Write(0x0C,0x00);
Delay_ms(25);
}
 
 ////////////////////////////////////////////////////////////////////////////////////////////////////////
  void change_settings(void){
  Lcd_Cmd(_LCD_CLEAR);
  Lcd_Out(1, 1, "Admin:");
  get_password();
  read_pass();
  show=strcmp(kp,read);
  if(show=='\0'){
  Lcd_Cmd(_LCD_CLEAR);
  Lcd_Out(1, 1, "Password:");
  get_password();
  read_pass1();
  show1=strcmp(kp,read);
             if(show1=='\0'){
             Lcd_Cmd(_LCD_CLEAR);
             Lcd_Out(1, 1, "Change Setting");
             Lcd_Out(2, 1, "Tablets:");
              GetNumber();
              V2=num;
              EEPROM_Write(0x02,V2);               // Write some data at address 2
              Delay_ms(100);}
             else{
             Lcd_Cmd(_LCD_CLEAR);
             Lcd_Out(1, 1, " password invalid");}
     }

  else{
      Lcd_Cmd(_LCD_CLEAR);
      Lcd_Out(1, 1, "invalid");}
            //  take= EEPROM_Read(0x02);             // Read data from address 2 and display it on PORTB
             // IntToStr(take,txt2);
             // Lcd_Out(3,1,txt2);

  }
  ///////////////////////////////////////////////////////////////////////////////////
  void  do_setup(void){
  cnt = 0;                                 // Reset counter
  Lcd_Cmd(_LCD_CLEAR);                     // Clear display
  Lcd_Cmd(_LCD_CURSOR_OFF);                // Cursor off
  Lcd_Out(1, 1, "To fill:");
  Lcd_Out(2, 1, "Currently:");                 // Write message text on LCD
  Lcd_Cmd(_LCD_THIRD_ROW);
  Lcd_Cmd(_LCD_RETURN_HOME);
  Lcd_Out(3, -3, "Total:");
  Lcd_Cmd(_LCD_FOURTH_ROW);
  Lcd_Cmd(_LCD_RETURN_HOME);
  Lcd_Out(4, -3, "Button to Change");
  }
/////////////////////////////////////////////////////////////////////////////////////////////////////////
  void get_password(void){
    int cn=11;
  for(i=0;i<=3;i++){
         do
         kp[i] = Keypad_Key_Click();
         while (!kp[i]);
      switch (kp[i]) {
      case  1: kp[i] = 55; break; // 7   55      // Uncomment this block for keypad4x4
      case  2: kp[i] = 56; break; // 8   56
      case  3: kp[i] = 57; break; // 9   57
      case  4: kp[i] = 214; break; // /   214
      case  5: kp[i] = 52; break; // 4   52
      case  6: kp[i] = 53; break; // 5   53
      case  7: kp[i] = 54; break; // 6   54
      case  8: kp[i] = 120; break; // *   120
      case  9: kp[i] = 49; break; // 1  49
      case 10: kp[i] = 50; break; // 2    50
      case 11: kp[i] = 51; break; // 3    51
      case 12: kp[i] = 208; break; // -    208
      case 13: kp[i] = 35; break; // #   35
      case 14: kp[i] = 48; break; // 0
      case 15: kp[i] = 61; break; // =    61
      case 16: kp[i] = 43; break; // +    43
      }
      Lcd_Cmd(_LCD_CURSOR_OFF);
      Lcd_Chr(1, cn, kp[i]);
      cn++;
 }
}
///////////////////////////////////////////////////////////////////////////////////////
 void get_Counter(void){
         do
         kpx = Keypad_Key_Click();
         while (!kpx);
      switch (kpx) {
      case  1: kpx = 55; break; // 7   55      // Uncomment this block for keypad4x4
      case  2: kpx = 56; break; // 8   56
      case  3: kpx = 57; break; // 9   57
      case  4: kpx = 214; break; // /   214
      case  5: kpx = 52; break; // 4   52
      case  6: kpx = 53; break; // 5   53
      case  7: kpx = 54; break; // 6   54
      case  8: kpx = 120; break; // *   120
      case  9: kpx = 49; break; // 1  49
      case 10: kpx = 50; break; // 2    50
      case 11: kpx = 51; break; // 3    51
      case 12: kpx = 208; break; // -    208
      case 13: kpx = 35; break; // #   35
      case 14: kpx = 48; break; // 0
      case 15: kpx = 61; break; // =    61
      case 16: kpx = 43; break; // +    43
      }
  }
 /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 void GetNumber(){
   int cn1=10;
   int k;
   get_Counter();
   V1=kpx;
  // Lcd_Chr(2, 7, V1);
    while(V1 != 35){
    Lcd_Chr(2, cn1, kpx);
       cn1++;
    switch (V1){

         case 48: case 49: case 50: case 51: case 52:
         case 53: case 54: case 55: case 56: case 57:
            num = num * 10 + (V1 - '0');
            k++;
            break;

         case 214:  case 120: case 208: case 43: case 61:
            num = 0;
            break;
      }

       get_Counter();
       V1=kpx;
   }
}