import themidibus.*; //Import the library

import processing.serial.*;



Serial myPort;
MidiBus myBus; // The MidiBus
String Midimsg;
  
  int Channel=0;
int Pitch=0;
int Veloc=0;
int OnOff=0;
int Ccmm=0;
int heymsg= 0;



void setup() {
int  lf=10;
  size(400, 400);
  background(0);

  MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.

  // Either you can
  //                   Parent In Out
  //                     |    |  |
  //myBus = new MidiBus(this, 0, 1); // Create a new MidiBus using the device index to select the Midi input and output devices respectively.

  // or you can ...
  //                   Parent         In                   Out
  //                     |            |                     |
  //myBus = new MidiBus(this, "IncomingDeviceName", "OutgoingDeviceName"); // Create a new MidiBus using the device names to select the Midi input and output devices respectively.

  // or for testing you could ...
  //                 Parent  In        Out
  //                   |     |          |
  myBus = new MidiBus(this, 0,3); // Create a new MidiBus with no input device and the default Java Sound Synthesizer as the output device.
 
myPort = new Serial(this, Serial.list()[0],9600);
myPort.bufferUntil(lf);
}

void draw() {


if (heymsg==1){
  
  
  
if(Ccmm == 0){
  if (OnOff==0){
  myBus.sendNoteOn(Channel, Pitch, Veloc); // Send a Midi noteOn
 }else if(OnOff==1){
  myBus.sendNoteOff(Channel, Pitch, Veloc); // Send a Midi nodeOff
  }
}
else if(Ccmm==1)
   {
    myBus.sendControllerChange(Channel, Pitch, Veloc);
   }

}
heymsg = 0;

}
void serialEvent(Serial port) { 
  Midimsg = port.readString(); 
  


 
 if(Midimsg!=null){
   
String[]  msglist = split(Midimsg,",");
 
Channel = int(msglist[0]);
Pitch = int(msglist[1]);
Veloc = int(msglist[2]);
OnOff = int(msglist[3]);
Ccmm  = int(msglist[4]);
heymsg =1;


}
} 

void noteOn(int channel, int pitch, int velocity) {
  // Receive a noteOn
  println();
  println("Note On:");
  println("--------");
  println("Channel:"+channel);
  println("Pitch:"+pitch);
  println("Velocity:"+velocity);
}

void noteOff(int channel, int pitch, int velocity) {
  // Receive a noteOff
  println();
  println("Note Off:");
  println("--------");
  println("Channel:"+channel);
  println("Pitch:"+pitch);
  println("Velocity:"+velocity);
}

void controllerChange(int channel, int number, int value) {
  // Receive a controllerChange
  println();
  println("Controller Change:");
  println("--------");
  println("Channel:"+channel);
  println("Number:"+number);
  println("Value:"+value);
}

void delay(int time) {
  int current = millis();
  while (millis () < current+time) Thread.yield();
}
