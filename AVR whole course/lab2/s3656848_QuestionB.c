/* ****************************************************
* EEET2256 - Laboratory 2 (2022) Template
* Author: Dr. Glenn Matthews
* Last Updated:  04/08/2022 10:55:04 AM
* laboratory2.c
******************************************************/

#include <avr/io.h>
char smallest;
char largest;
unsigned char largest_location;
unsigned char smallest_location;
unsigned char z;

int main(void)
{
	DDRB=0xFF;        //make PORTB as OUTPUT
	DDRD=0xFF;        //make PORTD as OUTPUT
	
	// Create the table in memory
	int8_t table[64] =	{	91, 109, 110, -32,   7, -74,  81,  38,  45,  39, 117,   0, -19,  94,  89,  91,
		98,  42,  -3,  23,  90,  83,  76,  13, 13, -15, -86, -77,  16,  98, 123,  24,
		102,  19,  17,  10,  25,  68,  31,  12, 81,  27,  80,  43,  59,  52, -44, -76 ,
	64, -22, -105, 18,  40,  24,  48, -17, 28,  16,  25,  55,  26,  21, -45, -58  };
	
	largest=table[0];              // insert 1st element of the array as largest       
	for(z=0;z<=64;z++){           // loop to check all 64 numbers
		if(table[z]>largest){     // if current number is greater than largest
			largest=table[z];     //assign that number as largest
		largest_location=z; }     //save the location of that number
	}
	smallest=table[0];           // insert 1st element of the array as smallest
	for(z=0;z<64;z++){           // loop to check all 64 numbers
		if(table[z]<smallest){   // if current number is smaller than smallest
			smallest=table[z];   //assign that number as smallest
		smallest_location=z;}     //save the location of that number
	}
	PORTB=largest;                //show largest number on PORTB
	PORTD=smallest;               //show smallest number on PORTDsss
	while(1){};
	
}

