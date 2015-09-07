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

int numHands = 0;
int maxHands = 2;

PVector [] fingerTipsRight = new PVector[5];
PVector [] fingerTipsLeft = new PVector[5];
PVector [] palms = new PVector[maxHands];
PVector [] wrists = new PVector[maxHands];
PVector [] elbows = new PVector[maxHands];

void setup() {

  size(500, 500, P3D);

  cam = new PeasyCam(this, 200);
  cam.rotateX(radians(80));

  // note: port needs to match leapOSC port
  oscP5 = new OscP5(this, 9339);

  oscP5.plug(this, "receivedNumHands", "/leap/hands/total");
  oscP5.plug(this, "receivedPalm", "/leap/hand/palm");
  oscP5.plug(this, "receivedWrist", "/leap/hand/wrist");
  oscP5.plug(this, "receivedElbow", "/leap/hand/elbow");
  oscP5.plug(this, "receivedFingerTip", "/leap/hand/fingerTip");

  for (int i = 0; i < fingerTipsRight.length; i++) {
    fingerTipsRight[i] = new PVector(0, 0, 0);
    fingerTipsLeft[i] = new PVector(0, 0, 0);
  }


  for (int i = 0; i < maxHands; i++) {
    palms[i] = new PVector(0, 0, 0);
    wrists[i] = new PVector(0, 0, 0);
    elbows[i] = new PVector(0, 0, 0);
  }
}


void draw() {

  background(0);
  fill(255);
  sphereDetail(10);

  for (int i = 0; i < numHands; i++) {

    pushMatrix();
    translate(palms[i].x, palms[i].y, palms[i].z);
    fill(255);
    sphere(20);
    popMatrix();

    pushMatrix();
    translate(wrists[i].x, wrists[i].y, wrists[i].z);
    fill(255);
    sphere(10);
    popMatrix();

    stroke(255);
    line(wrists[i].x, wrists[i].y, wrists[i].z, elbows[i].x, elbows[i].y, elbows[i].z);
  }

  for (int i = 0; i < fingerTipsLeft.length; i++) {
    if (fingerTipsLeft[i].mag() != 0 ) {
      pushMatrix();
      translate(fingerTipsLeft[i].x, fingerTipsLeft[i].y, fingerTipsLeft[i].z);
      fill(255);
      sphereDetail(10);
      sphere(6);
      popMatrix();
    }
  }

  for (int i = 0; i < fingerTipsRight.length; i++) {
    if (fingerTipsRight[i].mag() != 0 ) {
      pushMatrix();
      translate(fingerTipsRight[i].x, fingerTipsRight[i].y, fingerTipsRight[i].z);
      fill(255);
      sphereDetail(10);
      sphere(6);
      popMatrix();
    }
  }

  //float [] lookAt = cam.getRotations();
  //println("cam look " + degrees(lookAt[0]) + " " + degrees(lookAt[1]) + " " + degrees(lookAt[2]) );
}

public void receivedNumHands( int totalHands ) {
  //println("Total hands: " + totalHands);
  numHands = totalHands;
}

public void receivedPalm( int handIndex, float x, float y, float z ) {
  //println("Hand "+handIndex+" palm: "+x+" "+y+" "+z);
  if (handIndex < maxHands) {
    palms[handIndex].set(x, y, z);
  }
}

public void receivedWrist( int handIndex, float x, float y, float z ) {
  if (handIndex < maxHands) {
    wrists[handIndex].set(x, y, z);
  }
}

public void receivedElbow( int handIndex, float x, float y, float z ) {
  if (handIndex < maxHands) {
    elbows[handIndex].set(x, y, z);
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

  if (handType == 0) {
    // handType 0 is right
    fingerTipsRight[fingerType].set(x, y, z);
  } else {
    fingerTipsLeft[fingerType].set(x, y, z);
  }
}

