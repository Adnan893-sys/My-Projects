ORG 00h            // starting of code  
MOV A,#0FFH        //mov FF to A    
MoV P3,A           // P3 as input port       
MOV A,#00H         // P1 as output port
MoV P1,A           //mov FF to A    
SETB P2.0          //p2.0 as input for add/sub

again:
JNB P2.0,SUB         //P2.0 if pressed do sub operation else add
Acall Take_numbers   //input both numbers from port3
Add A, R1            //do N-M
Mov P1, A            // show them on P1
sjmp again           // loop this process again

SUB:                 //subtraction operation
Acall Take_numbers   //input both numbers from port3 
CLR C                // clear carry 
Mov A,R1             // mov N to R1
subb A, R2           //do N-M                
Mov P1, A            // show them on P1
sjmp again           // loop this process again


Take_numbers:
MOV A,P3         // mov inputs to A from P3
MOV R7,A        // mov A in R7
MOv R6,A        // copy in R6
ANL A,#0FH       // first digit N
MOV R1, A        // N in R1
MOV A, R6        // Mov R6,A
ANL A,#0F0H     //   second digit M
swap A          // swap A
MOV R2, A     // M in R2
RET

End