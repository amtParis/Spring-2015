import peasy.*;

PeasyCam cam;


void setup() {
  size(640, 480, P3D);
  cam = new PeasyCam(this, 100); // zoom out to 100 (change to be far/closer)
}

void draw(){
  
  background(0);
  noFill();
  stroke(255);
  box(50);
  
}

void keyPressed(){
  // resets to original setting
  cam.reset();
}
