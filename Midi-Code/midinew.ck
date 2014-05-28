
Gain master => dac;

Flute flute =>NRev rev => LPF lpf=>   master;


// reverb params
0.1 => rev.mix;

//Gains
0.8 => master.gain;



    

//=---------------Sound chain----------



//LPF params
(880.0 ,0.8)=> lpf.set;


//=------Midi events-----------//

MidiIn min;
MidiMsg msg;

// Midi Port
0 => int port;



              
//Open the port

if ( !min.open(port))
{
    <<<"ERROR: midi port did not openon port ", port>>>;    
   
me.exit();   
    }
    
<<< "MIDI device:", min.num(), " -> ", min.name() >>>;
    
    ///loop
    
    while(true)
    {
        min => now;
        
        
        while ( min.recv(msg))
            {
               
                //print out all data
                <<< msg.data1 , msg.data2 , msg.data3>>>;
                
                //BUTTON1
                if((msg.data1==144)&&(msg.data2==48))
                {     
                     84=>Std.mtof => flute.freq;
                    flute.noteOn(1.0);
                       
                    }
                    if((msg.data1==128)&&(msg.data2==48))
                    {
                        
                         flute.noteOff(1.0);
                         
                        }
                        
                //BUTTON2                        
                        if((msg.data1==144)&&(msg.data2==50))
                        {
                         87=>Std.mtof => flute.freq;
                           flute.noteOn(1.0);
                       
                       }
                       if((msg.data1==128)&&(msg.data2==50))
                       {
                        
                        
                         flute.noteOff(1.0);
                         
                         
                          }
                         
                         
                //BUTTON3 
                          if((msg.data1==144)&&(msg.data2==52))
                        {
                         91=>Std.mtof => flute.freq;
                           flute.noteOn(1.0);
                       
                       }
                       if((msg.data1==128)&&(msg.data2==52))
                       {
                        
                        
                         flute.noteOff(1.0);
                         
                         
                          }
                     
                          //Pontetiometer1   
                       if((msg.data1==176)&&(msg.data2==20))
                       {  
                          msg.data3 / 127 => flute.vibratoGain;
                           
                           }
                          
                          
                          
                          //Pontetiometer2
                       if((msg.data1==176)&&(msg.data2==21))
                       {  
                          msg.data3  => flute.vibratoFreq;
                           
                           }
                               
                 //  bcm4312       
                          
                          
                }
        
        }





