 #ifndef F_CPU
 #define F_CPU 1000000UL
 #endif
#include <avr/io.h>
#include <util/delay.h>
unsigned char keypad [4][4]={{'1','4','7','*'},
{'2','5','8','0'},
{'3','6','9','#'},
{'A','B','C','D'}};
unsigned char colloc,rowloc,key,key1,i,locknumber,locknumber1,ok,ok1,z;
unsigned char Password1[]= {"12152025"};
unsigned char Password2[]= {"30354045"};
unsigned char Password3[]= {"50556065"};
unsigned char Password4[]= {"70758085"};
unsigned char Password5[]= {"90951020"};
unsigned char Password6[]= {"3040506A"};

//function declaration
void Init(void);
void check_locker_number(void);
void show_status(void);
void show_pressed(void);
void ReadSW(void);
void Disply(void);
int main(void){
	Init();              //initialize all variables
	while (1){
	check_locker_number();
  if(locknumber==0x01){
	  ReadSW(); show_pressed(); if(key==Password1[0]){ok=0x01;} else{ok=0x00;}
	  ReadSW(); show_pressed(); if(key==Password1[1]){ok=0x01;} else{ok=0x00;}
	  ReadSW(); show_pressed(); if(key==Password1[2]){ok=0x01;} else{ok=0x00;}
	  ReadSW(); show_pressed(); if(key==Password1[3]){ok=0x01;} else{ok=0x00;}
	  ReadSW(); show_pressed(); if(key==Password1[4]){ok=0x01;} else{ok=0x00;}
	  ReadSW(); show_pressed(); if(key==Password1[5]){ok=0x01;} else{ok=0x00;}
	  ReadSW(); show_pressed(); if(key==Password1[6]){ok=0x01;} else{ok=0x00;}
	  ReadSW(); show_pressed(); if(key==Password1[7]){ok=0x01;} else{ok=0x00;}
	  if(ok==0x01){show_status();}
	  if(ok==0x00){show_status(); PORTB=0x00; _delay_ms(3000);}}
  if(locknumber==0x02){
	  ReadSW(); show_pressed(); if(key==Password2[0]){ok=0x01;} else{ok=0x00;}
	  ReadSW(); show_pressed(); if(key==Password2[1]){ok=0x01;} else{ok=0x00;}
	  ReadSW(); show_pressed(); if(key==Password2[2]){ok=0x01;} else{ok=0x00;}
	  ReadSW(); show_pressed(); if(key==Password2[3]){ok=0x01;} else{ok=0x00;}
	  ReadSW(); show_pressed(); if(key==Password2[4]){ok=0x01;} else{ok=0x00;}
	  ReadSW(); show_pressed(); if(key==Password2[5]){ok=0x01;} else{ok=0x00;}
	  ReadSW(); show_pressed(); if(key==Password2[6]){ok=0x01;} else{ok=0x00;}
	  ReadSW(); show_pressed(); if(key==Password2[7]){ok=0x01;} else{ok=0x00;}
	  if(ok==0x01){show_status();}
	  if(ok==0x00){show_status(); PORTB=0x00; _delay_ms(3000);}}
  if(locknumber==0x03){
	  ReadSW(); show_pressed(); if(key==Password3[0]){ok=0x01;} else{ok=0x00;}
	  ReadSW(); show_pressed(); if(key==Password3[1]){ok=0x01;} else{ok=0x00;}
	  ReadSW(); show_pressed(); if(key==Password3[2]){ok=0x01;} else{ok=0x00;}
	  ReadSW(); show_pressed(); if(key==Password3[3]){ok=0x01;} else{ok=0x00;}
	  ReadSW(); show_pressed(); if(key==Password3[4]){ok=0x01;} else{ok=0x00;}
	  ReadSW(); show_pressed(); if(key==Password3[5]){ok=0x01;} else{ok=0x00;}
	  ReadSW(); show_pressed(); if(key==Password3[6]){ok=0x01;} else{ok=0x00;}
	  ReadSW(); show_pressed(); if(key==Password3[7]){ok=0x01;} else{ok=0x00;}
	  if(ok==0x01){show_status();}
	  if(ok==0x00){show_status(); PORTB=0x00; _delay_ms(3000);}}
   if(locknumber==0x04){
	   ReadSW(); show_pressed(); if(key==Password4[0]){ok=0x01;} else{ok=0x00;}
	   ReadSW(); show_pressed(); if(key==Password4[1]){ok=0x01;} else{ok=0x00;}
	   ReadSW(); show_pressed(); if(key==Password4[2]){ok=0x01;} else{ok=0x00;}
	   ReadSW(); show_pressed(); if(key==Password4[3]){ok=0x01;} else{ok=0x00;}
	   ReadSW(); show_pressed(); if(key==Password4[4]){ok=0x01;} else{ok=0x00;}
	   ReadSW(); show_pressed(); if(key==Password4[5]){ok=0x01;} else{ok=0x00;}
	   ReadSW(); show_pressed(); if(key==Password4[6]){ok=0x01;} else{ok=0x00;}
	   ReadSW(); show_pressed(); if(key==Password4[7]){ok=0x01;} else{ok=0x00;}
	   if(ok==0x01){show_status();}
	   if(ok==0x00){show_status(); PORTB=0x00; _delay_ms(3000);}}
	if(locknumber==0x05){
		ReadSW(); show_pressed(); if(key==Password5[0]){ok=0x01;} else{ok=0x00;}
		ReadSW(); show_pressed(); if(key==Password5[1]){ok=0x01;} else{ok=0x00;}
		ReadSW(); show_pressed(); if(key==Password5[2]){ok=0x01;} else{ok=0x00;}
		ReadSW(); show_pressed(); if(key==Password5[3]){ok=0x01;} else{ok=0x00;}
		ReadSW(); show_pressed(); if(key==Password5[4]){ok=0x01;} else{ok=0x00;}
		ReadSW(); show_pressed(); if(key==Password5[5]){ok=0x01;} else{ok=0x00;}
		ReadSW(); show_pressed(); if(key==Password5[6]){ok=0x01;} else{ok=0x00;}
		ReadSW(); show_pressed(); if(key==Password5[7]){ok=0x01;} else{ok=0x00;}
		if(ok==0x01){show_status();}
		if(ok==0x00){show_status(); PORTB=0x00; _delay_ms(3000);}}
	if(locknumber==0x06){
		ReadSW(); show_pressed(); if(key==Password6[0]){ok=0x01;} else{ok=0x00;}
		ReadSW(); show_pressed(); if(key==Password6[1]){ok=0x01;} else{ok=0x00;}
		ReadSW(); show_pressed(); if(key==Password6[2]){ok=0x01;} else{ok=0x00;}
		ReadSW(); show_pressed(); if(key==Password6[3]){ok=0x01;} else{ok=0x00;}
		ReadSW(); show_pressed(); if(key==Password6[4]){ok=0x01;} else{ok=0x00;}
		ReadSW(); show_pressed(); if(key==Password6[5]){ok=0x01;} else{ok=0x00;}
		ReadSW(); show_pressed(); if(key==Password6[6]){ok=0x01;} else{ok=0x00;}
		ReadSW(); show_pressed(); if(key==Password6[7]){ok=0x01;} else{ok=0x00;}
		if(ok==0x01){show_status();}
		if(ok==0x00){show_status(); PORTB=0x00; _delay_ms(3000);}}
	   
	 
  
	  }
  

}
void Init(void){
	DDRB=0xFF;        //PORTB as OUTPUT
	DDRA=0xFF;        //PORTB as OUTPUT
	DDRC=0x00;        //PORTC as INPUT
	DDRD=0xF0;        //set PORTD as INPUT
	PORTD=0xFF;       //active pull up resistors
	PORTC=0xFF;       //active pull up resistors
	
}
void show_pressed(void){
	key1=key;
	if(key1>0x29 && key1<0x40 ){ key1=key1-0x30;}
	if( key1>0x40 ){ key1=key1-0x31;}
	locknumber1=locknumber1 & 0xF0;
	key1=key1 | locknumber1;
	PORTB=key1;
}
void show_status(void){
	ok1=ok;
	key1=key1 & 0x7F;
	ok1=ok1 << 7;
	ok1=ok1 | key1;
	PORTB=ok1;
}
void check_locker_number(void){
	locknumber=0x00;
	if(bit_is_clear(PINC,0)){locknumber=0x01;}    //if Pin1 is 1 increment count
	if(bit_is_clear(PINC,1)){locknumber=0x02;}    //if Pin1 is 2 increment count
	if(bit_is_clear(PINC,2)){locknumber=0x03;}    //if Pin1 is 3 increment count
	if(bit_is_clear(PINC,3)){locknumber=0x04;}    //if Pin1 is 4 increment count
	if(bit_is_clear(PINC,4)){locknumber=0x05;}    //if Pin1 is 5 increment count
	if(bit_is_clear(PINC,5)){locknumber=0x06;}    //if Pin1 is 6 increment count
	ok1=ok1 & 0x8F;
	locknumber1=locknumber;
	locknumber1=locknumber1 << 4;
	locknumber1=locknumber1 | ok1;
	PORTB=locknumber1;
}
void ReadSW(void){
	do{
		do{
			PORTD &= 0x0F;             //ground all rows at once
			colloc=(PIND & 0x0F);      //read all columns
		}while(colloc != 0x0F);    //check until all key released
		
		for(i=0;i<=70;i++);         //small delay for switch denouncing
		colloc=(PIND & 0x0F);      //see if any key is pressed
	}while(colloc != 0x0F);   //keep checking for key pressed
	
	while(1){
		
		PORTD=0xEF;              //ground row0
		colloc=(PIND & 0x0F);    //read columns
		if(colloc != 0x0F){      //if column detected
			rowloc=0;            //save row location
		break;}              //exit while loop
		
		PORTD=0xDF;              //ground row1
		colloc=(PIND & 0x0F);    //read columns
		if(colloc != 0x0F){     //if column detected
			rowloc=1;            //save row location
		break;}                  //exit while loop
		
		PORTD=0xBF;             //ground row2
		colloc=(PIND & 0x0F);   //read columns
		if(colloc != 0x0F){     //if column detected
			rowloc=2;           //save row location
		break;}                //exit while loop
		
		PORTD=0x7F;            //ground row3
		colloc=(PIND & 0x0F);   //read columns
		if(colloc != 0x0F){    //if column detected
			rowloc=3;          //save row location
		break;}                //exit while loop
	}
	
	// each columns wrt row and save number in key variable
	
	if(colloc==0x0E)
	key= (keypad[rowloc][0]);
	else if(colloc==0x0D)
	key= (keypad[rowloc][1]);
	else if(colloc==0x0B)
	key= (keypad[rowloc][2]);
	else
	key= (keypad[rowloc][3]);
}
void Disply(void){
	//PORTB=key;       //Display button pressed on PORTB
	 PORTB  = Password1[7];
}

