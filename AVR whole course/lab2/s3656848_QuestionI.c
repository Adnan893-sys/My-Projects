/* ****************************************************
* EEET2256 - Laboratory 2 (2022) Template
* Author: Dr. Glenn Matthews
* Last Updated:  04/08/2022 10:55:04 AM
* laboratory2.c
******************************************************/

#include <avr/io.h>
unsigned char z;
int i,x;
int main(void)
{
	DDRB=0xFF;
	DDRD=0xFF;
	
    // Create the table in memory
	 int8_t table[64] =	{	91, 109, 110, -32,   7, -74,  81,  38,  45,  39, 117,   0, -19,  94,  89,  91,
							98,  42,  -3,  23,  90,  83,  76,  13, 13, -15, -86, -77,  16,  98, 123,  24,
							102,  19,  17,  10,  25,  68,  31,  12, 81,  27,  80,  43,  59,  52, -44, -76 ,
							64, -22, -105, 18,  40,  24,  48, -17, 28,  16,  25,  55,  26,  21, -45, -58  };
						
	
		for(i=0;i<63;i++){            //take loop from 0 to 63
			for(x=0;x<62;x++){        //take loop from 0 to 62
			if(table[x]<table[x+1]){   // compare to consecutive numbers
				int hold= table[x];     // if previous number is less than next number  , save value
				table[x]=table[x+1];    // swap with next
				table[x+1]=hold;}      // save hold value in the next
			}
			}
			while(1){
			for(i=0;i<=63;i++){       // //take loop from 0 to 63   
				PORTB=table[i];}}     // show each value one by one on the PORTB  
	
}

