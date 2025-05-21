#include <SPI.h>
#include <MFRC522.h>
#include <ros.h>
#include <std_msgs/String.h>
#include <std_msgs/Int32.h>
#define SS_PIN 53
#define RST_PIN 5
#define buzzer 26
#define green 27
#define ENC_IN1 3 
#define ENC_IN2 20
MFRC522 mfrc522(SS_PIN, RST_PIN);   // Create MFRC522 instance.
ros::NodeHandle nh;
String card= " ";
String message=" ";
//QTR SENSOR
#define s1 A0
#define s2 A1
#define s3 A2
#define s4 A3
#define s5 A4
#define Near A5
//#define CLP 7
void read_sensors(void);
void follow_line(void);
void follow_dirrections(void);
void turning(void);
void get_dirrections(void);
void forward_rotation(void); 
void right_rotation(void); 
void left_rotation(void);
void Forward(void);  
//LEFT MOTOR
#define lmotorenable 10
#define lmotorforward 22
#define lmotorreverse 23

//RIGHT MOTOR
#define rmotorenable 11
#define rmotorforward 24
#define rmotorreverse 25


int error;
int encoderValue1 = 0;
int encoderValue2 = 0;
int motorPwm = 0;
int i;
int a_len,count=0,not_detected=0;
char dirrection[100];
int number=0,previous=0;
String a =" ";
int motor_control=1;
 int sensor1=0,sensor2=0,sensor3=0,sensor4=0,sensor5=0,near_sensor=0;
std_msgs::Int32 str_msg;

ros::Publisher chatter("rfid2", &str_msg);
 void messageCb( const std_msgs::String& toggle_msg){
 if(count==1)
{
i=0;
a=toggle_msg.data;
nh.loginfo(toggle_msg.data);
get_dirrections();
turning();
}
 if(count==0){
  a=toggle_msg.data;
  nh.loginfo(toggle_msg.data);
  get_dirrections();
count++;
}


}
void callback( const std_msgs::String& stat){
  message=stat.data;
if(message=="detected")
{
turning();
}
if(message=="not detected")
{
if(not_detected==0){
Forward();
delay(700);}
else{
not_detected=0;
}
}
}

void Speed(const std_msgs::Int32& control)
{
int contrl;
contrl=control.data;
if(contrl==0)
{
Stop();
delay(3000);
}

}

ros::Subscriber<std_msgs::String> sub("robot2", &messageCb );
ros::Subscriber<std_msgs::String> Status("status2", &callback );
ros::Subscriber<std_msgs::Int32> motor("motor2", &Speed );

void setup() {
  // put your setup code here, to run once:
//Serial1.begin(9600);
Serial1.begin(9600);
  pinMode(lmotorforward,OUTPUT);
  pinMode(lmotorreverse,OUTPUT);
  pinMode(lmotorenable,OUTPUT);
  pinMode(rmotorforward,OUTPUT);
  pinMode(rmotorreverse,OUTPUT);
  pinMode(rmotorenable,OUTPUT);
digitalWrite(lmotorforward,HIGH);
digitalWrite(lmotorreverse,LOW);
digitalWrite(rmotorforward,HIGH);
digitalWrite(rmotorreverse,LOW);
pinMode(buzzer,OUTPUT);
pinMode(green,OUTPUT);
 SPI.begin();      // Initiate  SPI bus
  mfrc522.PCD_Init();   // Initiate MFRC522
  Serial1.println("Approximate your card to the reader...");
  Serial1.begin(9600);
  nh.initNode();
  nh.subscribe(sub);
  nh.subscribe(Status);
  nh.subscribe(motor);
  nh.advertise(chatter);

 }

void loop() {
 if(a!= " ")
 { 
 read_sensors();
 follow_line();
 follow_dirrections();
 
 
  
 }
  nh.spinOnce();
 /* get_number();
  Serial1.print(card);
  card="";*/
 
}  // main get error ki

void forward(){
  analogWrite(lmotorenable, 87);
  analogWrite(rmotorenable, 93);
}

void left(){
  analogWrite(lmotorenable, 70);
  analogWrite(rmotorenable, 103);
}
void right(){
  analogWrite(lmotorenable, 100);
  analogWrite(rmotorenable, 70);
}
void turn_left(){
  analogWrite(lmotorenable, 0);
  analogWrite(rmotorenable, 130);
 //Serial1.println("left");
}
void turn_right(){
  analogWrite(lmotorenable, 190);
  analogWrite(rmotorenable, 0);
  //Serial1.println("right");
}
void Stop(){
  analogWrite(lmotorenable, 0);
  analogWrite(rmotorenable, 0);
}
void Forward(){
  analogWrite(lmotorenable, 80);
  analogWrite(rmotorenable, 85);
}
void forward_rotation(void)
{
  encoderValue1=0;
  encoderValue2=0;
  attachInterrupt(digitalPinToInterrupt(ENC_IN1), updateEncoder1, RISING);
  attachInterrupt(digitalPinToInterrupt(ENC_IN2), updateEncoder2, RISING);
    float x,y;
    x=0.58;
    y=0.18; //0.3
    float t=x*215;
    float u=y*215;
   while(encoderValue1 <t  && encoderValue2 <u  ){
    Serial.println("here4");
    motorPwm = 100;
    analogWrite(rmotorenable, motorPwm);
    analogWrite(lmotorenable, 95);
    digitalWrite(rmotorforward,HIGH);
    digitalWrite(rmotorreverse,LOW);
    digitalWrite(lmotorforward,HIGH);
    digitalWrite(lmotorreverse,LOW);
    Serial.print("1st=");
    Serial.print(encoderValue1);
    Serial.print("      ");
    Serial.print("2nd=");
    Serial.print(encoderValue2);
    Serial.println(" ");
   }
  
  // Update RPM value every second
  
    Serial.println("here5");
    analogWrite(rmotorenable, 0);
    analogWrite(lmotorenable, 0);
    
   
}
void updateEncoder1(){
  encoderValue1++;
}
void updateEncoder2(){
  encoderValue2++;
}
void get_dirrections(){

 a_len= a.length()+1;
 dirrection[ a_len];
a.toCharArray(dirrection,a_len);
Serial1.println(dirrection[0]);
Serial1.println(dirrection[1]);
Serial1.println(dirrection[2]);
Serial1.println(dirrection[3]);
Serial1.println(dirrection[4]);
Serial1.println(dirrection[5]);
Serial1.println(dirrection[6]);
Serial1.println(dirrection[7]);
 Serial1.println(a_len);
 Serial1.println(a.length());
 Serial1.println(a);
 Serial1.println("here");
  delay(1500);//}
}


void show(void){
          digitalWrite(buzzer,HIGH);
          delay(50);
          digitalWrite(buzzer,LOW);
          delay(50);
          digitalWrite(green ,HIGH);
          delay(25);
          digitalWrite(green,LOW);
          delay(25); }
void get_number(void){
 if ( ! mfrc522.PICC_IsNewCardPresent()) {
  Serial1.println("1");
    return;}
  if ( ! mfrc522.PICC_ReadCardSerial()) {
    Serial1.println("2" );
    return ;}
  String content= "";
  byte letter;
  for (byte i = 0; i < mfrc522.uid.size; i++) {
     Serial1.print(mfrc522.uid.uidByte[i] < 0x10 ? " 0" : " ");
     Serial1.print(mfrc522.uid.uidByte[i] < 0x10 ? " 0" : " ");
     // Serial1.print(mfrc522.uid.uidByte[i], HEX);
     content.concat(String(mfrc522.uid.uidByte[i] < 0x10 ? " 0" : " "));
     content.concat(String(mfrc522.uid.uidByte[i], HEX));
  }
  Serial1.println();
  content.toUpperCase();
  Serial1.print("built");
 Serial1.print(content.substring(1));
 Serial1.println();
 card=(content.substring(1));
 Serial1.print("Card");
 Serial1.print(card);
  Serial1.println();
 show();
 //delay(50);
}
void read_sensors(void){
   sensor1=digitalRead(s1);
  sensor2=digitalRead(s2);
  sensor3=digitalRead(s3);
  sensor4=digitalRead(s4);
  sensor5=digitalRead(s5);
  near_sensor=digitalRead(Near);
 }
void follow_line(void){
  if(sensor1==1 && sensor2==1 && sensor3==0 && sensor4==1 && sensor5==1){
forward();
//if(motor_control==0)FORWARD();
//if(motor_control==1)forward();
}                                                                                     //00100
  if(sensor1==1 && sensor2==0 && sensor3==0 && sensor4==0 && sensor5==1){
forward();
//if(motor_control==0)FORWARD();
//if(motor_control==1)forward();
}                                                                                     //01110
  if(sensor1==1 && sensor2==0 && sensor3==0 && sensor4==1 && sensor5==1){
forward();
//if(motor_control==0)FORWARD();
//if(motor_control==1)forward();
}                                                                                      //01100
  if(sensor1==1 && sensor2==0 && sensor3==1 && sensor4==1 && sensor5==1)left();        //01000
  if(sensor1==0 && sensor2==0 && sensor3==0 && sensor4==1 && sensor5==1)left();         //11100
  if(sensor1==0 && sensor2==0 && sensor3==1 && sensor4==1 && sensor5==1)left();        //11000
  if(sensor1==0 && sensor2==1 && sensor3==1 && sensor4==1 && sensor5==1)left();        //10000
  if(sensor1==1 && sensor2==1 && sensor3==0 && sensor4==0 && sensor5==1){
forward();
//if(motor_control==0)FORWARD();
//if(motor_control==1)forward();
}          //00110
  if(sensor1==1 && sensor2==1 && sensor3==1 && sensor4==0 && sensor5==1)right();         //00010
  if(sensor1==1 && sensor2==1 && sensor3==0 && sensor4==0 && sensor5==0)right();         //00111
  if(sensor1==1 && sensor2==1 && sensor3==1 && sensor4==0 && sensor5==0)right();         //00011
  if(sensor1==1 && sensor2==1 && sensor3==1 && sensor4==1 && sensor5==0)right();         //00001
  
}
void follow_dirrections(void){
   if(sensor1==0 && sensor2==0 && sensor3==0 && sensor4==0 && sensor5==0){
    Stop();
    Serial1.println("stop");
    delay(400);
    
     forward_rotation();
      Serial1.println("small staright");
     //delay(500);
     Stop();
     Serial1.println("stop2");
     delay(400);
      //for(i=0;i<2;i++){
     get_number();//}
     convert(card);
     Serial1.println(card);
     //delay(500);
     str_msg.data=number;
     if(number!=previous && number!=0 )
  {
  previous=number;
  //nh.loginfo(&card);
  //nh.loginfo(card_no);
  
  chatter.publish( &str_msg );
  
  }

if(card == " ")
{
str_msg.data=100;
chatter.publish( &str_msg );
turning();

}
card=" ";       
} // intersection ki
delay(100);
}

void turning(){
//if(dirrection[i]=='0' || dirrection[i]==' ' ){
//           Serial1.println("now");
//          Stop();}
  nh.loginfo(dirrection[i]);
  Serial1.println("here");
  
         if(dirrection[i]=='F'){
          nh.loginfo("F");
          Forward();
          delay(600);}
          
        if(dirrection[i]=='R'){
          nh.loginfo("R");
          turn_right();
          delay(800);
          while(sensor1!=1 && sensor3!=0 && sensor5!=1)
          {
            turn_right();
          }
          Stop();
          delay(200);
          }
          
          
        if(dirrection[i]=='L'){
          nh.loginfo("L");
          left_rotation();
         // delay(700);
         /* while(sensor1!=1 && sensor3!=0 && sensor5!=1)
          {
            turn_left();
          }*/
          }

        if(dirrection[i]=='S'){
          nh.loginfo("S");
          Stop();
          while(1)
          {
            Serial1.println("task completed");
            delay(1000);
          }
          }
     i++;
 //else ki
}

void left_rotation(void)
{
  attachInterrupt(digitalPinToInterrupt(ENC_IN2), updateEncoder2, RISING);
    float x;
    x=1.5; //1.6
    float t=x*215;
   while(encoderValue2 <t ){
    Serial.println("here4");
    motorPwm = 160;
    analogWrite(rmotorenable, motorPwm);
    analogWrite(lmotorenable, 0);
    digitalWrite(rmotorforward,HIGH);
    digitalWrite(rmotorreverse,LOW);
    }
  
  // Update RPM value every second
  
    
    analogWrite(rmotorenable, 0);
    analogWrite(lmotorenable, 0);
    encoderValue2=0;
   
}
void right_rotation(void)
{
  attachInterrupt(digitalPinToInterrupt(ENC_IN1), updateEncoder1, RISING);
  
  
    float x;
    x=3.2; // 3;
    float t=x*100;
   while(encoderValue1 <t ){
    Serial.println("here2");
    motorPwm = 160;
    analogWrite(lmotorenable, motorPwm);
    analogWrite(rmotorenable, 0);
    digitalWrite(lmotorforward,HIGH);
    digitalWrite(lmotorreverse,LOW);
    Serial.println(encoderValue1);}
  
  // Update RPM value every second
  
    
    Serial.println("here3");
    analogWrite(lmotorenable, 0);
    analogWrite(rmotorenable, 0);
     encoderValue1=0;
   
}

void convert(String z){
  if(z=="11 85 C0 2E"){  number=7; }
  if(z=="F9 0A A9 0F"){  number=6; }
  if(z=="E9 18 BC 0F"){  number=5; }
  if(z=="79 11 FA 0F"){  number=4; }
  if(z=="69 25 09 10"){  number=3; }
  if(z=="E9 1E ED 0F"){  number=2; }
  if(z=="79 20 AA 0F"){  number=1; }
  
   if(z=="59 6A FD 0F"){  number=10;  }
   if(z=="D9 88 04 10"){  number=11;  }
   if(z=="29 7E B0 0F"){  number=12;  }
   if(z=="D9 08 BA 0F"){  number=13;  }
   if(z=="B9 4D F8 0F"){  number=14;  }
   if(z=="79 D4 BA 0F"){  number=15;  }
   if(z=="29 5F A7 0F"){  number=16;  }
   if(z=="C9 A5 C5 0F"){  number=17;  }
   if(z=="C6 F4 C4 1A"){  number=18;  }
   
   if(z=="F9 B3 EC 0F"){  number=20;  }
   if(z=="B9 BE D6 0F"){  number=21;  }
   if(z=="59 B2 B2 0F"){  number=22;  }
   if(z=="C9 99 65 08"){  number=23;  }
   if(z=="89 F2 E1 0F"){  number=24;  }
   if(z=="99 EB E0 0F"){  number=25;  }
   if(z=="C9 90 D3 0F"){  number=26;  }
   if(z=="79 BD E7 0F"){  number=27;  }
   if(z=="E1 5C FE 2D"){  number=28;  }
   
   if(z=="A9 E3 1D 10"){  number=30;  }
   if(z=="F9 B4 DF 0F"){  number=31;  }
   if(z=="E9 80 E6 0F"){  number=32;  }
   if(z=="F9 00 C5 0F"){  number=33;  }
   if(z=="99 ED BF 0F"){  number=34;  }
   if(z=="39 3B E3 0F"){  number=35;  }
   if(z=="99 A4 05 10"){  number=36;  }
   if(z=="79 AB EF 0F"){  number=37;  }
   if(z=="99 40 FE 0F"){  number=38;  }

   if(z=="89 3A 05 10"){  number=40;  }
   if(z=="A9 07 D7 0F"){  number=41;  }
   if(z=="39 23 00 10"){  number=42;  }
   if(z=="B9 F8 E4 0F"){  number=43;  }
   if(z=="49 DC FF 0F"){  number=44;  }
   if(z=="49 B0 DA 0F"){  number=45;  }
   if(z=="69 A2 FF 0F"){  number=46;  }
   if(z=="99 B2 E4 0F"){  number=47;  }
   if(z=="39 8C 07 10"){  number=48;  }

   if(z=="A9 FA C8 0F"){  number=50;  }
   if(z=="69 D6 E6 0F"){  number=51;  }
   if(z=="29 3A E0 0F"){  number=52;  }
   if(z=="09 B1 EC 0F"){  number=53;  }
   if(z=="C9 23 C5 0F"){  number=54;  }
   if(z=="E9 44 10 10"){  number=55;  }
   if(z=="F9 0F 00 10"){  number=56;  }
   if(z=="A9 55 DB 0F"){  number=57;  }
   if(z=="49 DE 06 10"){  number=58;  }

   if(z=="C7 0B 5D 14"){  number=60;  }
   if(z=="09 E9 07 10"){  number=61;  }
   if(z=="19 77 06 10"){  number=62;  }
   if(z=="09 D1 04 10"){  number=63;  }
   if(z=="D9 FE 1E 10"){  number=64;  }
   if(z=="99 28 F4 0F"){  number=65;  }
   if(z=="39 EC DD 0F"){  number=66;  }
   if(z=="49 56 03 10"){  number=67;  }
   if(z=="49 6A 05 10"){  number=68;  }

   if(z=="E9 BB FD 0F"){  number=70;  }
   if(z=="A9 97 C9 0F"){  number=71;  }
   if(z=="49 86 F3 0F"){  number=72;  }
   if(z=="59 31 CB 0F"){  number=73;  }
   if(z=="29 A1 05 10"){  number=74;  }
   if(z=="89 35 0A 10"){  number=75;  }
   if(z=="F9 AF DF 0F"){  number=76;  }
   if(z=="29 D6 A5 0F"){  number=77;  }
   if(z=="A9 E8 06 10"){  number=78;  }

   if(z=="89 9D DF 0F"){  number=81;  }
   if(z=="99 17 F8 0F"){  number=82;  }
   if(z=="19 7F BF 0F"){  number=83;  }
   if(z=="B9 FA DF 0F"){  number=84;  }
   if(z=="A9 E6 C6 0F"){  number=85;  }
   if(z=="19 99 05 10"){  number=86;  }
   if(z=="69 DB F3 0F"){  number=87;  }
 }
