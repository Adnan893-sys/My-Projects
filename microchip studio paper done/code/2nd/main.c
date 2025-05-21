/*
 * paper.c
 *
 * Created: 10/19/2021 12:31:48 PM
 * Author : Adnan Rao
 */ 

#include <avr/io.h>
#define F_CPU 8000000UL

#include <util/delay.h>
void config_periferals(void);
int game_logic (void);
unsigned char temp;
unsigned char value;
unsigned int result;
// this is the game logic function and this fuction describes the 
// result either 2nd user entered number is small large or equal to the original.
int game_logic (void){
	if(value<temp)
	  return -1;
	if(value>temp)
	   return -1;
	if(value==temp)
	   return 0;
}
//this function configures switches and LEDs attached to the PORTS.
void config_periferals(void){
	DDRD=0x00; //switches
	DDRB=0xFF; //leds
	DDRC=0xFF;  //portc7
}


int main(void)
{
	config_periferals();
	
    /* Replace with your application code */
    while (1) {
	    PORTC=0x00;
		temp=PIND;
		PORTB=temp;   //get number and copy it in portb
		PORTC=0x80;
		
		
		if(PORTC==0x80){       // if number enterd by 2nd user
			for(int i=0; i<10; i++){
				value=PIND;
				         PORTC=0x80;
				         PORTC=0x00;  //h-l-H
				         PORTC=0x80;
				result=game_logic();  // get result
				if(result== -1){
					PORTB=0x0F;}     //glow 0-4 of portb
				if(result== 1){
				    PORTB=0xF0;}       //glow 4-7 of portb
				if(result== 0){
				     PORTB=0xFF;      //glow all of portb
				     _delay_ms(1000);
					  PORTB=0x00;       // glow with freq of 0.5hz
					  _delay_ms(1000);
					  _delay_ms(5000);}
	}
				}
	}
	
}

// this is for configuration for hardware


