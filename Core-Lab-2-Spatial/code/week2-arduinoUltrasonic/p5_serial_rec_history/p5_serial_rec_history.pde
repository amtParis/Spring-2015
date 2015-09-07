import processing.serial.*;

Serial myPort;        // The serial port

  
// IntList is like ArrayList but for integers
IntList dataHistory;

void setup () {
  // set the window size:
  size(400, 300);        

  // List all the available serial ports
  // use this to find which one you are on
  println(Serial.list());
  
  // Open whatever port is the one you're using (may not be 7)
  myPort = new Serial(this, Serial.list()[7], 9600);
  
  // don't generate a serialEvent() unless you get a newline character: gets rid of noise in beginning 
  myPort.bufferUntil('\n');
    
    
  dataHistory = new IntList();
}


void draw () {
  background(0);
  
  stroke(255);
  noFill();
  beginShape();
  for( int i = 0; i < dataHistory.size(); i++){
    vertex(i,height-dataHistory.get(i));
  }
  endShape();
  
}

void serialEvent (Serial myPort) {
  
  // get the ASCII string:
  String inString = myPort.readStringUntil('\n');

  if (inString != null) {
    // trim off any whitespace:
    inString = trim(inString);
    
   // convert to an int 
    int inByte = int(inString);
    
    // map the data to our range (350-650 will change depending 
    // on sensor readings)
    inByte = (int)map(inByte, 350, 650, 0, height/2);
    
    // save the history deleting the first value once we fill up
    dataHistory.append(inByte);
    if(dataHistory.size() > width){
      dataHistory.remove(0);
    }
  }

}

// for debugging
//void mouseMoved(){
//  dataHistory.append(mouseY);
//  if(dataHistory.size() > width){
//    dataHistory.remove(0);
//  }
//}


