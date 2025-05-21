const int Phase1 = 3;
const int Phase2 = 5;
const int Phase3 = 6;  
void setup()
{
  pinMode(Phase1, OUTPUT); // Phase 1
  pinMode(Phase2, OUTPUT); // Phase 2
  pinMode(Phase3, OUTPUT); // Phase 3
}
void loop()
{
  delayMicroseconds(3310);
  digitalWrite(Phase1, LOW);
  delayMicroseconds(3310);
  digitalWrite(Phase2, HIGH);
  delayMicroseconds(3310);
  digitalWrite(Phase3, LOW);
  delayMicroseconds(3310);
  digitalWrite(Phase1, HIGH);
  delayMicroseconds(3310);
  digitalWrite(Phase2, LOW);
  delayMicroseconds(3310);
  digitalWrite(Phase3, HIGH);
}
