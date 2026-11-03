// destination host name
"224.0.0.1" => string hostname;
//"pho.local" => string host1;
// destination port number
7000 => int port;

// sender object
OscOut xmit;

// aim the transmitter at destination
xmit.dest( hostname, port );

0 => int inSequencer;
0 => int whichSeq;
3 => int numSeq;
Impulse i => dac;

0 => int scoreTime;
0 => int scoreStarted;

300 => int stepTimeMS;

function void scoreTimer() 
{
    1 => scoreStarted;
    while(true) 
    {
        ///<<<"sec: " + scoreTime>>>;
        
        xmit.start( "/time" );
        
        // add int argument
        scoreTime => xmit.add;
        
        // send it
        xmit.send();     
        
        scoreTime++;
        
        1::second => now;   
    }
}


// go beyond sequencer - make a PIECE
function void seqStepper() {
    1 => int stepToSend;
    
    1 => int stepCounter;
    
    10 => int numSteps;
    
    Math.random2(2, 20) => int randomLen;
    Math.random2(1, numSteps) => int stepToPulse;
    0 => int lenCounter;
    
    while( true )
    {
        if (inSequencer > 0) 
        {
            // SEND stepToSend
            <<<"s " + stepToSend>>>;
            xmit.start( "/play" );
            stepToSend => xmit.add;
            xmit.send();
            
            if (whichSeq == 0) {
                stepToSend++;
                if (stepToSend > numSteps) 1 => stepToSend;
            }
            else if (whichSeq == 1) {
                Math.random2(1, numSteps) => stepToSend;
            }
            else if (whichSeq == 2) {
                if ((stepCounter % 2) == 0) {
                    stepCounter => stepToSend;
                } else {
                    Math.random2(1, numSteps) => stepToSend;
                }
                stepCounter++;
                if (stepCounter > numSteps) 1 => stepCounter;
            }
            else if (whichSeq == 3) {
                // every randomLen steps, play random step, otherwise play singular step 
                if (stepCounter >= randomLen) {
                    0 => stepCounter;
                    Math.random2(2, 20) => randomLen;
                    Math.random2(1, 10) => stepToPulse;
                    Math.random2(1, numSteps) => stepToSend;
                } else {
                    stepToPulse => stepToSend;
                }
                stepCounter++;
            }
        }
        
        
        // advance time
        stepTimeMS::ms => now;
        
    }
}

spork ~ seqStepper(); 

Hid hi;
HidMsg msg;

// which keyboard
0 => int device;
// get from command line
if( me.args() ) me.arg(0) => Std.atoi => device;

// open keyboard (get device number from command line)
if( !hi.openKeyboard( device ) ) me.exit();
<<< "keyboard '" + hi.name() + "' ready", "" >>>;

0 => int shiftDown;
100 => int seqNoteLen;
// infinite event loop
while( true )
{
    // wait on event
    hi => now;
    
    // get one or more messages
    while( hi.recv( msg ) )
    {
        
        // check for action type
        if( msg.isButtonDown() )
        {
            <<< "down:", msg.which >>>;
            if (msg.which == 225) {
                1 => shiftDown;
            }
            if (shiftDown) {
                if (msg.which == 22) // s
                {
                    if (inSequencer == 0) 1 => inSequencer;
                    else if (inSequencer > 0) 0 => inSequencer;
                    
                    xmit.start( "/seqOn" );
                    
                    // add int argument
                    inSequencer => xmit.add;
                    
                    // send it
                    xmit.send();        
                }
                else if (msg.which == 39) // 0
                {
                    
                    whichSeq++;
                    if (whichSeq > numSeq) 0 => whichSeq;
                    <<<"seq: " + whichSeq>>>; 
                    
                }
                else if (msg.which >= 30 && msg.which <= 33) //1-9
                { 
                    (msg.which - 30) => whichSeq;    
                } 
                else if (msg.which == 40) {
                    if (scoreStarted == 0) 
                    { 
                        spork ~ scoreTimer();
                    }
                }
                 else if (msg.which == 21) {
                    0 => scoreTime;
                }
                else if (msg.which == 81) 
                {       
                    seqNoteLen - 15 => seqNoteLen;
                    if (seqNoteLen <= 15) 15 => seqNoteLen;
                    <<<"seqNoteLen: "+ seqNoteLen>>>;
                    xmit.start("/seqNoteLen");
                    seqNoteLen => xmit.add;
                    xmit.send();
                }
                else if (msg.which == 82) 
                {      
                    seqNoteLen + 15 => seqNoteLen;
                    <<<"seqNoteLen: "+ seqNoteLen>>>;
                    xmit.start("/seqNoteLen");
                    seqNoteLen => xmit.add;
                    xmit.send();
                }
                else if (msg.which == 79) 
                {       
                    stepTimeMS + 10 => stepTimeMS;
                    <<<"stepTime: " + stepTimeMS>>>;
                }
                else if (msg.which == 80) 
                {      
                    stepTimeMS - 10 => stepTimeMS;
                    if (stepTimeMS <= 10) 15 => stepTimeMS;
                    <<<"stepTime: " + stepTimeMS>>>;
                }
                
            }
        }
        else {
            if (msg.which == 225)
            {
                0=> shiftDown;
            }   
        }
    }
}

