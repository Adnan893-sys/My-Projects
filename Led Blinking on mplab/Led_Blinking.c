void main() {
 TRISA=0;        //make PortA as output Port
 while(1){
 PORTA=63;       //send high on 6 pins
 Delay_ms(1000);   //delay for one second
 PORTA=0;         //send low on all pins
 Delay_ms(1000);   //delay for one second
 }
}