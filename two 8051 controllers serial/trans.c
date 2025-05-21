#include <reg51.h>
void MSDelay(unsigned int);
void SerTx(unsigned char);
void flicker(int x);
int SerRx(void);
sbit mybit =P3^7;
sbit led =P1^7;
unsigned char get;
int Value;
int i=1;
void main(void){
mybit=1;  //make it input
TMOD=0x20;            //use Timer 1, mode 2
TH1=0xFD;             //9600 baud rate
SCON=0x50;
TR1=1;                 //start timer
while (1) {
 if(mybit==0){
		 MSDelay(50);
		 P1=i;
		 i=i+1;
     if(i==10){
		 SerTx('9');
		 Value=SerRx();
			 P1=Value;
		   led=1;
       MSDelay(500);
       flicker(Value);
       led=0;
       MSDelay(500);
       flicker(Value);
       i=0;}
	 }
			else
		     P2=0x55;
}
}	
//######################################################
void flicker(int x){
	led=1;
	MSDelay(x);
	led=0;
	MSDelay(x);
}
//#######################################################
void MSDelay(unsigned int itime){
unsigned int i,j;
for (i=0;i<itime;i++)
for (j=0;j<1275;j++);
}

//#####################################################
void SerTx(unsigned char x){
SBUF=x; //place value in buffer
while (TI==0); //wait until transmitted
TI=0;
}
//#############################################
int SerRx(){
	while (RI==0); //wait to receive
  get=SBUF; //save value
	get=get-'0';
  RI=0;
	return get;
}