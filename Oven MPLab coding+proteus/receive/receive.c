#include <reg51.h>
void MSDelay(unsigned int);
void SerTx(unsigned char);
void initialize(void);
void display(void);
unsigned char DisTable[10]={0x3f,0x06,0x5b,0x4f,0x66,0x6d,0x7d,0x07,0x7f,0x6f};
sbit S1 =P2^6;
sbit S2 =P2^7;
sbit check =P2^5;
unsigned char get;
int lower,upper=0;
int i=1;
unsigned char bcdbyte;
unsigned char w;
unsigned char z;

void main(void){
initialize();
while (1) {
	while (RI==0){ //wait to receive
      display();}
	get=SBUF; //save value
	get=get-'0';
	lower=get;
	upper=1;
  w=upper;
  z=lower;
  w=w&0x0F;
  w=w<<4;
  z=z&0x0F;
  bcdbyte=w|z;
  P0=~bcdbyte;
  display();
  check=0;
  SerTx(lower);
	RI=0;
	
}
}
//#####################################################
void initialize(void){
	TMOD=0x20;            //use Timer 1, mode 2
  TH1=0xFD;             //9600 baud rate
  SCON=0x50;
  TR1=1; 	//start timer
}
//######################################################
void display(void){
	int i=0;
	
	S1=0;
	S2=1;
	P1=DisTable[upper];
  MSDelay(1);
	S1=0;
	S2=0;
	MSDelay(1);
	S1=1;
	S2=0;
	P1=DisTable[lower];
	MSDelay(1);
	S1=0;
	S2=0;
	MSDelay(1);
	
	
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

