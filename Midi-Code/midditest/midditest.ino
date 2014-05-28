// Super Simple Midi Contoler

 const int button = 51;
 const int button2 = 52;
 const int button3 = 53;
 const int Led = 22;
 const int Led2 = 24;
 const int Led3 = 26;

const int potPin = 14;
const int potPin2 =15;
const int ledPin = 31; 
const int ledPin2 = 30; 

int valpot=0;
int valpot2=0;
int valpotprevious =0;
int valpotprevious2 =0;
int buttonState = 0;
int buttonState2 = 0;
int buttonState3 = 0;
void setup()
{
   pinMode(button,INPUT);
   pinMode(button2,INPUT);
   pinMode(button3,INPUT);
   
   pinMode(Led,OUTPUT);
   pinMode(Led2,OUTPUT);
   pinMode(Led3,OUTPUT);
   
   pinMode(ledPin, OUTPUT);
   pinMode(ledPin2, OUTPUT);
   
   Serial.begin(9600);       // Default speed of MIDI serial port
}

void loop(){
 
  buttonState = digitalRead(button);
  buttonState2 = digitalRead(button2);
  buttonState3 = digitalRead(button3);
  
 Contpot();
 
 
 
 
 //--------BUTTON 1-----------//
 if( buttonState == HIGH)
 {
  

  
    digitalWrite(Led,HIGH);
  MIDI_TX(0,48,127,0,0);       // 176 = CC command, 1 = Which Control
 
 
  while(buttonState==HIGH)
{ Contpot(); 
  buttonState = digitalRead(button);
  delay(5);}

   MIDI_TX(0,48,127,1,0);
}
else{ 
  digitalWrite(Led,LOW);
}



//===========BUTTON 2==========//

 if( buttonState2 == HIGH)
 {
  

  
    digitalWrite(Led2,HIGH);
  MIDI_TX(0,50,127,0,0);       // 176 = CC command, 1 = Which Control
 
 
  while(buttonState2==HIGH)
{  Contpot();  
   buttonState2 = digitalRead(button2);
   delay(5);}

   MIDI_TX(0,50,127,1,0);
}
else{ 
  digitalWrite(Led2,LOW);
}


//===========BUTTON 3==========//

if( buttonState3 == HIGH)
 {
  
  
   digitalWrite(Led3,HIGH);
  MIDI_TX(0,52,127,0,0);       // 176 = CC command, 1 = Which Control
  while(buttonState3==HIGH)
{  Contpot();
   buttonState3 = digitalRead(button3);
   delay(5);}

   MIDI_TX(0,52,127,1,0);
}
else{ 
  digitalWrite(Led3,LOW);
}
  //==============sensor================//
  

  

}
void MIDI_TX(unsigned char CHANNEL,unsigned char PITCH,unsigned char VELOC ,unsigned char OnOff,unsigned char CCmm)
{

  Serial.print(CHANNEL);
  Serial.print(",");
  Serial.print(PITCH);
  Serial.print(",");
  Serial.print(VELOC);
  Serial.print(",");
  Serial.print(OnOff);
  Serial.print(",");
  Serial.print(CCmm);
  Serial.println(",");
}

void Contpot()
  {
    //==========POTENTIOMETER=======??
   valpot = analogRead(potPin); 
   valpot = map(valpot, 0, 1023, 0, 127);
  
   valpot2 = analogRead(potPin2);   
   valpot2 = map(valpot2, 0, 1023, 0, 127);
   
    
if(valpot != valpotprevious)
 {
   MIDI_TX(0,20,valpot,0,1);
   
 digitalWrite(ledPin2, HIGH);
 valpot = valpotprevious;
 }else
 {
   digitalWrite(ledPin2, LOW);
 }

 if(valpot2 != valpotprevious2)
 {
   MIDI_TX(0,21,valpot2,0,1);
   
 digitalWrite(ledPin, HIGH);
  valpot = valpotprevious2;
 }else
 {
   digitalWrite(ledPin, LOW);
 }
  
 
}


