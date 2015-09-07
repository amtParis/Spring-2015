/**
 Receives osc data from leapOSC openFrameworks app
 Uses oscP5 and PeasyCam Libraries
 */

import oscP5.*;
import netP5.*;
import peasy.*;

// camera for 3d view
PeasyCam cam;

// make osc object
OscP5 oscP5;

// array of current hands found
ArrayList<LeapHand>leapHands;

// last gesture received 
int gesture;

void setup() {

  size(500, 500, P3D);

  // set up camera to have good view point
  cam = new PeasyCam(this, 430);
  cam.rotateX(radians(-60));
  cam.rotateY(radians(0));
  cam.rotateZ(radians(180));


  // note: port needs to match leapOSC port
  oscP5 = new OscP5(this, 9339);

  oscP5.plug(this, "receivedNumHands", "/leap/hands/total");
  oscP5.plug(this, "receivedGesture", "/leap/gesture");
  oscP5.plug(this, "receivedPalm", "/leap/hand/palm");
  oscP5.plug(this, "receivedWrist", "/leap/hand/wrist");
  oscP5.plug(this, "receivedElbow", "/leap/hand/elbow");
  oscP5.plug(this, "receivedFingerTip", "/leap/hand/fingerTip");
  oscP5.plug(this, "receivedFinger", "/leap/finger");
  oscP5.plug(this, "receivedThumb", "/leap/thumb");
 //<>//
  leapHands = new ArrayList();
}


void draw() {

  background(0);

  // leapOSC is sending x is reverse so scale- to compensate
  scale(-1, 1, 1);

  // draw hands
  pushMatrix();

  for (int i = 0; i < leapHands.size (); i++) {
    leapHands.get(i).draw();
  }

  // draw floor box
  drawFloor();

  popMatrix();
}


void drawFloor() {

  // Draw a grid plane.
  pushMatrix();

  noFill();
  stroke(255);
  translate(0, 250, 0);
  box(500, 500, 500);
  popMatrix();

  rectMode(CENTER);
  pushMatrix();
  fill(120, 255);
  translate(0, 0, 0);
  rotateX(radians(90));
  rect(0, 0, 500, 500);
  popMatrix();
  rectMode(CORNER);

  //  float [] rot = cam.getRotations();
  //  println("rot: "+degrees(rot[0])+" " + degrees(rot[1])+" "+degrees(rot[2]));
  //  println("dist: "cam.getDistance());
}


public void receivedGesture(int gestureID) {

  // 0 - none
  // 1 - screen tap
  // 2 - key tap
  // 3 - swipe right
  // 4 - swipe left
  // 5 - swipe down
  // 6 - swipe up
  // 7 - swipe forward
  // 8 - swipe back
  // 9 - circle counter-clockwise
  // 10 - circle clockwise

  gesture = gestureID;
  println("gesture: "+gesture);
}

public void receivedNumHands( int totalHands ) {
  //println("Total hands: " + totalHands);
  for (int i = leapHands.size (); i < totalHands; i++) {
    leapHands.add(new LeapHand());
  }
}

public void receivedPalm( int handIndex, float x, float y, float z ) {
  //println("Hand "+handIndex+" palm: "+x+" "+y+" "+z);
  if (handIndex < leapHands.size()) {
    leapHands.get(handIndex).palm.set(x, y, z);
  }
}

public void receivedWrist( int handIndex, float x, float y, float z ) {
  if (handIndex < leapHands.size()) {
    leapHands.get(handIndex).wrist.set(x, y, z);
  }
}

public void receivedElbow( int handIndex, float x, float y, float z ) {
  if (handIndex < leapHands.size()) {
    leapHands.get(handIndex).elbow.set(x, y, z);
  }
}

public void receivedFingerTip( int handIndex, int handType, int fingerType, float x, float y, float z ) {
  //println("FingerTip "+fingerType+" pos: "+x+" "+y+" "+z);

  // fingerType:
  // THUMB  = 0
  // INDEX  = 1
  // MIDDLE = 2
  // RING   = 3
  // PINKY  = 4
  if (handIndex < leapHands.size()) {

    leapHands.get(handIndex).fingerTips[fingerType].set(x, y, z);
  }
}


public void receivedFinger(int handIndex, int fingerIndex, 
float x1, float y1, float z1, 
float x2, float y2, float z2, 
float x3, float y3, float z3, 
float x4, float y4, float z4) {
  if (handIndex < leapHands.size()) {
    ArrayList<PVector>joints = new ArrayList();
    joints.add(new PVector(x1, y1, z1)); 
    joints.add(new PVector(x2, y2, z2)); 
    joints.add(new PVector(x3, y3, z3)); 
    joints.add(new PVector(x4, y4, z4)); 
    leapHands.get(handIndex).fingers[fingerIndex-1].setJoints(joints);
  }
}

public void receivedThumb(int handIndex, int fingerIndex, 
float x1, float y1, float z1, 
float x2, float y2, float z2, 
float x3, float y3, float z3) {
  if (handIndex < leapHands.size()) {
    ArrayList<PVector>joints = new ArrayList();
    joints.add(new PVector(x1, y1, z1)); 
    joints.add(new PVector(x2, y2, z2)); 
    joints.add(new PVector(x3, y3, z3)); 
    leapHands.get(handIndex).thumb.setJoints(joints);
  }
}
