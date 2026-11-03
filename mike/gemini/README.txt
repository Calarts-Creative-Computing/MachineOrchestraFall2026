Each player has their own hemispherical 6-speaker array, microphone, and instrument. 

"gemini-player.maxpat" contains the core sampling and looping playback system interfaced by the performers, as well as their time-based score. 

"gemini-conductor.ck" contains ChucK code that sends OSC messages to the player patch to coordinate and sequence musical events between the players. 

The pianist plays the melody of the tune at the start of the piece before sampling the piano and cueing the start of the timed section (via the ChucK patch) to be performed with the rest of the ensemble. The piano returns for the ending. 
