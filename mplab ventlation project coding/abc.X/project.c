#include <xc.h>
#include "conbits.h"
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <pic18f4620.h>
void lcdcmd(unsigned char value);
void lcddata(unsigned char value);
void MSDelay(unsigned int itime);
void send_commands(void);
void select_interval();
int get(void);
int CO=0,XO=0;
int get1(void);
void do_task(void);
void print(char z[]);
void convert1 (int num1);
void show(void);
int map(int value, int fS, int fE, int tS, int tE);

void convert (int num);
void convert2 (int );
void set_interval(void);
int do_plus(int );
int do_minus(int );
#define ldata PORTD
#define rs  PORTEbits.RE2 
#define rw  PORTEbits.RE0 
#define en  PORTEbits.RE1
#define B  PORTBbits.RB0 
#define U  PORTBbits.RB1
#define D PORTBbits.RB2
#define E PORTBbits.RB3
#define O_Led  PORTBbits.RB5 
#define S_Led  PORTBbits.RB6
#define A_Led  PORTBbits.RB7

#define R_fault  PORTCbits.RC0
#define BZ  PORTCbits.RC1
#define Vent PORTCbits.RC2
#define H_speed PORTBbits.RB4
    
unsigned char mybyte;
int Quantity;
unsigned char L_byte,H_byte;
int Bin_temp,Bin_temp1;
int  b[4]={0,0,0,0};
char a[4]={0,0,0,0};
char c[2]={0,0};
char c1[2]={0,0};

int interval=30;
  
   int copy;
int main(){
    TRISCbits.TRISC0=0;
    TRISCbits.TRISC1=0;
    TRISCbits.TRISC2=0;
   
    TRISBbits.TRISB0=1;
    TRISBbits.TRISB1=1;
    TRISBbits.TRISB2=1;
    TRISBbits.TRISB3=1;
    TRISBbits.TRISB4=0;
    TRISBbits.TRISB5=0;
    TRISBbits.TRISB6=0;
    TRISBbits.TRISB7=0;
    TRISD=0;
    TRISE=0;
   // TRISC=0;
    TRISA = 0XFF;                /* PORTA configured as i/p*/
     en=0;
    send_commands();
    set_interval();
    while(1){
    
       do_task();
     /* if(Bin_temp>2000){
        lcdcmd(0x88);
        print("p\0");
        O_Led=0;}*/
       if(CO>2000){
        lcdcmd(0x89);
        print("z\0");
         Vent=1;}
      /* else{
           print("p\0");
        O_Led=0;}*/
       /*R_fault=1;
        MSDelay(2000);
       R_fault=0;
        MSDelay(2000);
        O_Led=1;
        MSDelay(2000);
        O_Led=0;
        MSDelay(2000);*/
       
}
    return 0;
}
void set_interval(void){
    S_Led=1;
    O_Led=0;
    copy=interval;
        lcdcmd(0x80);
        MSDelay(15);
        print("Interval:\0");
    while(E==1 && B==1){
          if(D==0){
          MSDelay(500);    
          interval = do_minus(interval);
              convert1(interval);}
          if(U==0){
              MSDelay(500);
              interval=do_plus(interval);
              convert2(interval);}
           }
            convert1 (interval);
           if(B==0){
               interval=copy;
               convert1 (interval);}
            MSDelay(1500);
            lcdcmd(0x01);
            lcdcmd(0x80);
            MSDelay(15);
            
       S_Led=0;      
}
void send_commands(void){
    MSDelay(250);
    lcdcmd(0x38);
    MSDelay(250);
    lcdcmd(0x0E);
     MSDelay(15);
    lcdcmd(0x01);
     MSDelay(15);
    lcdcmd(0x06);
     MSDelay(15);
    lcdcmd(0x86);
     MSDelay(15);
}
void lcdcmd(unsigned char value){
    ldata=value;
    rs=0;
    rw=0;
    en=1;
    MSDelay(1);
    en=0;
}
void lcddata(unsigned char value){
    MSDelay(15);
    ldata=value;
    rs=1;
    rw=0;
    en=1;
    MSDelay(1);
    en=0;
}
void MSDelay(unsigned int itime){
    unsigned int i,j;
    for(i=0;i<itime;i++)
       for(j=0;j<135;j++);
  }
void convert (int num){
    int temp,factor=1,i=0,y;
    temp=num;
            while(temp){
            temp=temp/10;
            factor=factor*10; }
             while(factor>1){
             factor = factor/10;
             y=num/factor;
             
             b[i]=y;
             num = num%factor;
             i++;}
}
int map(int value, int fS, int fE, int tS, int tE) {
    return ((long)(value - fS) * (long)(tE - tS)) / ((fE - fS) + tS);
}
void do_task(void){
    O_Led=1;
    lcdcmd(0x80);
    MSDelay(15);
     print("C0:\0");
    ADCON0= 0x01; 
    ADCON1= 0x0E;          
    ADCON2= 0xAA;   
      MSDelay(1);
      Bin_temp=get();
      CO=Bin_temp;
     convert(Bin_temp);
     lcdcmd(0x83);
      show();
    ADCON0= 0x05; 
    ADCON1= 0x0D;          
    ADCON2= 0xAA;  
     lcdcmd(0xC0);
      MSDelay(15);
     print("CO2:\0");
     Bin_temp1=get1();
     XO=Bin_temp1;
     convert(Bin_temp1);
     lcdcmd(0xC4);
     show();
     
     
     
    
}
void show(void){
    a[0]=b[0]+48;
     a[1]=b[1]+48;
     a[2]=b[2]+48;
     a[3]=b[3]+48;
     lcddata(a[0]);
     lcddata(a[1]);
     lcddata(a[2]);
     lcddata(a[3]);
}
int get(){
    int digital;
    ADCON0bits.GO=1;
     while(ADCON0bits.DONE==1);
     digital = (ADRESH*256) | (ADRESL);
     return (digital);
     //return ((((unsigned int)ADRESH)<<2)|(ADRESL>>6));
}
int get1(){
    int digital;
    ADCON0bits.GO=1;
     while(ADCON0bits.DONE==1);
     digital = (ADRESH*256) | (ADRESL);
     return (digital);
     //return ((((unsigned int)ADRESH)<<2)|(ADRESL>>6));
}
void convert1 (int num1){
  int  temp1,factor1=1,y1,i=0;
    temp1=num1;
            while(temp1){
            temp1=temp1/10;
            factor1=factor1*10; }
             while(factor1>1){
             factor1 = factor1/10;
             y1=num1/factor1;
             c[i]=y1;
             num1 = num1%factor1;
             i++;}
     a[0]=c[0]+48;
     a[1]=c[1]+48;
     lcdcmd(0xC0);
     MSDelay(15);
     lcddata(a[0]);
     lcddata(a[1]);
}
void convert2 (int num2){
  int  temp2,factor2=1,y2,i=0;
    temp2=num2;
            while(temp2){
            temp2=temp2/10;
            factor2=factor2*10; }
             while(factor2>1){
             factor2 = factor2/10;
             y2=num2/factor2;
             c1[i]=y2;
             num2 = num2%factor2;
             i++;}
     a[0]=c1[0]+48;
     a[1]=c1[1]+48;
     lcdcmd(0xC0);
     MSDelay(15);
     lcddata(a[0]);
     lcddata(a[1]);
}
void print(char z[]){
    int i;
    for(i=0;z[i]!='\0';i++){
        lcddata(z[i]);}
}
int do_plus(int K){
    K=K+10; 
          if(K>=60){K=60;}
          lcdcmd(0xC4);
          MSDelay(15);
          
         
          return K;
}
int do_minus(int K1){
    K1=K1-10;
               if(K1==0){K1=0;}
               lcdcmd(0xC7);
               MSDelay(15);
               return K1;
}
       

