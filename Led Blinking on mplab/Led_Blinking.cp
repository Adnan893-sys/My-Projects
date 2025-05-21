#line 1 "C:/Users/Zulfiqar/Desktop/Led Blinking/Led_Blinking.c"
void main() {
 TRISA=0;
 while(1){
 PORTA=63;
 Delay_ms(1000);
 PORTA=0;
 Delay_ms(1000);
 }
}
