/**
 Receives osc data from kinectA openFrameworks app
 Uses oscP5 
 */

import oscP5.*;
import netP5.*;

OscP5 oscP5;

ArrayList<TrackedObject>trackedObj = new ArrayList();
int lastID = 0;

void setup() {

  size(640, 480, P3D);
  oscP5 = new OscP5(this, 55555);
  oscP5.plug(this, "receivedObject", "/objects/ID-centralXYZ");
  oscP5.plug(this, "receivedObjectSize", "/objects/width-height-size");
}

void draw() {
  background(0);

  for (int i = 0; i < trackedObj.size (); i++) {
    trackedObj.get(i).update();
    trackedObj.get(i).draw();
  }

  for (int i = trackedObj.size ()-1; i >=0; i--) {
    if (trackedObj.get(i).markForDead) {
      trackedObj.remove(i);
    }
  }
}

public void receivedObject(int id, float x, float y, float z) {

  x *= width;
  y *= height;

  boolean bAlreadyTracking = false;
  for (int i = 0; i < trackedObj.size (); i++) {
    if (trackedObj.get(i).id == id ) {
      trackedObj.get(i).setPosition(x, y, z);
      bAlreadyTracking = true;
      break;
    }
  }

  if (!bAlreadyTracking) {
    trackedObj.add(new TrackedObject(id, x, y, z) );
  }

  lastID = id;
}

public void receivedObjectSize(float w, float h, float s) {
  w *= width;
  h *= height;
  s *= 1;

  for (int i = 0; i < trackedObj.size (); i++) {
    if (trackedObj.get(i).id == lastID ) {
      trackedObj.get(i).setDimensions(w,h,s);
      break;
    }
  }
}


class TrackedObject {

  float lastTimeFound = 0;
  int id;
  boolean markForDead = false;
  float x = 0;
  float y = 0;
  float z = 0;
  float w = 0;
  float h = 0;
  float s = 0;

  TrackedObject(int _id, float _x, float _y, float _z) {
    id = _id;
    setPosition(_x, _y, _z);
  }

  void update() {
    if (millis()-lastTimeFound > 100) {
      markForDead = true;
    }
  }

  void setPosition(float _x, float _y, float _z) {
    x = _x;
    y = _y;
    z = _z;
    lastTimeFound = millis();
  }

  void setDimensions(float _w, float _h, float _s) {
    w = _w;
    h = _h;
    s = _s;
  }

  void draw() {
    fill(255);
    ellipse(x, y, 30, 30);
    fill(255, 0, 0);
    text(id, x-6, y+5);
    noFill();
    stroke(0, 255, 255);
    rect(x-w/2, y-h/2, w, h);
  }
}

