#include <stdio.h>
#include <stdlib.h>
#include  <conio.h>
#include  <math.h>
#define pi 3.1415
int main(){

     int FR=0,FL=0,RR=0,RL=0;
     char t;
    while(1){
    printf("\nEnter respective alphabet (small/Big) to do your desired operation\n\n");
    printf("H: Hover\tD: Descend\tF: Forward\t\tB: Back\nL: Left Roll\tR: Right Roll  \tC: Clockwise Yaw\tA: Clockwise Yaw\n\n");
    printf("Enter your choice\n");
   // scanf("%c",&t);
    while((t=getchar()) != '\n') {
    switch(t){

      case 'h' :
      case 'H' :
               printf("Entered H\n");
               FR=2;    // medium speed of FR
               FL=2;    // medium speed of FL
               RR=2;    // medium speed of RR
               RL=2;    // medium speed of RL
               break;
      case 'd' :
      case 'D' :
               printf("Entered D \n");
               FR=0;    // Off speed of FR
               FL=0;    // Off speed of FL
               RR=0;    // Off speed of RR
               RL=0;    // Off speed of RL
               break;
      case 'f' :
      case 'F' :
              printf("Entered F \n");
               FR=1;    // LOW speed of FR
               FL=1;    // LOW speed of FL
               RR=3;    // HIGH speed of RR
               RL=3;    // HIGH speed of RL
              break;
      case 'b' :
      case 'B' :
               printf("Entered B\n");
               FR=3;    // HIGH speed of FR
               FL=3;    // HIGH speed of FL
               RR=1;    // LOW speed of RR
               RL=1;    // LOW speed of RL
               break;
      case 'l' :
      case 'L' :
              printf("Entered L\n");
               FR=3;    // HIGH speed of FR
               FL=1;    // LOW speed of FL
               RR=3;    // HIGH speed of RR
               RL=1;    // LOW speed of RL
              break;
      case 'r' :
      case 'R' :
              printf("Entered R\n");
               FR=1;    // LOW speed of FR
               FL=3;    // HIGH speed of FL
               RR=1;    // LOW speed of RR
               RL=3;    // HIGH speed of RL
              break;
      case 'c' :
      case 'C' :
              printf("Entered C\n");
               FR=3;    // HIGH speed of FR
               FL=1;    // LOW speed of FL
               RR=1;    // LOW speed of RR
               RL=3;    // HIGH speed of RL
              break;
      case 'a' :
      case 'A' :
              printf("Entered A\n");
               FR=1;    // LOW speed of FR
               FL=3;    // High speed of FL
               RR=3;    // High speed of RR
               RL=1;    // Low speed of RL
              break;
       case '\n' :
       case '\t' :
       case ' ' :
              break;
    default :
              printf("invalid choice");
              return(0);
    }

         printf("FL and RR in Clockwise dirrection\n");
         printf("RL and FR in AntiClockwise dirrection\n");

         if(FR==0){printf("FR=MOTOR_OFF\n");}
         if(FR==1){printf("FR=MOTOR_LOW\n");}
         if(FR==2){printf("FR=MOTOR_MED\n");}
         if(FR==3){printf("FR=MOTOR_HIGH\n");}

         if(FL==0){printf("FL=MOTOR_OFF\n");}
         if(FL==1){printf("FL=MOTOR_LOW\n");}
         if(FL==2){printf("FL=MOTOR_MED\n");}
         if(FL==3){printf("FL=MOTOR_HIGH\n");}

         if(RR==0){printf("RR=MOTOR_OFF\n");}
         if(RR==1){printf("RR=MOTOR_LOW\n");}
         if(RR==2){printf("RR=MOTOR_MED\n");}
         if(RR==3){printf("RR=MOTOR_HIGH\n");}

         if(RL==0){printf("RL=MOTOR_OFF\n");}
         if(RL==1){printf("RL=MOTOR_LOW\n");}
         if(RL==2){printf("RL=MOTOR_MED\n");}
         if(RL==3){printf("RL=MOTOR_HIGH\n");}
         printf("here\n");

}
    }
}
