/* Processing application for visualising EKG data.
   Use with Processing 2.2.1.
*/

import processing.serial.*;

Serial myPort;
int xPos = 1;         // horizontal position of the graph
float height_old = 0;
float height_new = 0;
float inByte = 0;


void setup () {
  
  size(1000, 400);    // set the window size    

  // List all the available serial ports (list is shown below Processing mail window):
  println(Serial.list());
  
  myPort = new Serial(this, "/dev/ttyUSB0", 9600);  // we are using first USB on Linux, which is /dev/ttyUSB0 device

  myPort.bufferUntil('\n');   // don't generate a serialEvent() unless you get a newline character
  background(0xff);           // set inital background
}


void draw () {
  // everything happens in the serialEvent()
}


void serialEvent (Serial myPort) {
  
  String inString = myPort.readStringUntil('\n');  // get the ASCII string

  if (inString != null) {
    
    inString = trim(inString);   // trim off any whitespace

    // If leads off detection is true notify with blue line:
    if (inString.equals("!")) { 
      stroke(0, 0, 0xff);        // set stroke to blue (R, G, B)
      inByte = 512;              // middle of the ADC range (Flat Line)
    }
    // If the data is good let it through:
    else {
      stroke(0xff, 0, 0);        // set stroke to red (R, G, B)
      inByte = float(inString); 
     }
     
     // Map and draw the line for new data point:
     inByte = map(inByte, 0, 1023, 0, height);
     height_new = height - inByte; 
     line(xPos - 1, height_old, xPos, height_new);
     height_old = height_new;
    
      // At the edge of the screen, go back to the beginning:
      if (xPos >= width) {
        xPos = 0;
        background(0xff);
      } 
      else {
        // Increment the horizontal position:
        xPos++;
      }
    
  }
}
