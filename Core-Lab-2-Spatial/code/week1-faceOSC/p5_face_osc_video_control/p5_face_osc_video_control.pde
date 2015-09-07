/**
 Receives osc data from FaceOSC and uses eyebrows
 to control the speed of the video playback
 */
import processing.video.*;
import oscP5.*;
import netP5.*;

Movie mov;

// make osc object
OscP5 oscP5;

float eyeRight = 0;

void setup() {

  size(640, 360);

  // note: port needs to match FaceOSC port
  oscP5 = new OscP5(this, 8338);

  // set up the function that will process the incoming data
  oscP5.plug(this, "eyebrowRightReceived", "/gesture/eyebrow/right");

  mov = new Movie(this, "transit.mov");
  mov.loop();
}

float smoothSpeed = 0;

void draw() {
  image(mov, 0, 0);
  
  float newSpeed = map(eyeRight, 7, 9, 0.0, 5);
  if(eyeRight > 8) mov.pause();
  else mov.play();
  //mov.speed(newSpeed);
}

void movieEvent(Movie movie) {
  mov.read();
}

public void eyebrowRightReceived(float f) {
  println("eye right: " + f);
  eyeRight = f;
}

