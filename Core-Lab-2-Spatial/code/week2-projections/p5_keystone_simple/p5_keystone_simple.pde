/**
 * This is a simple example of how to use the Keystone library.
 *
 * To use this example in the real world, you need a projector
 * and a surface you want to project your Processing sketch onto.
 *
 * Simply drag the corners of the CornerPinSurface so that they
 * match the physical surface's corners. The result will be an
 * undistorted projection, regardless of projector position or 
 * orientation.
 *
 * You can also create more than one Surface object, and project
 * onto multiple flat surfaces using a single projector.
 *
 * This extra flexbility can comes at the sacrifice of more or 
 * less pixel resolution, depending on your projector and how
 * many surfaces you want to map. 
 */

import deadpixel.keystone.*;

Keystone ks;
CornerPinSurface surfaceA;
PGraphics offscreenA;



void setup() {
  size(1280, 800, P3D);
    
  ks = new Keystone(this);
  surfaceA = ks.createCornerPinSurface(800, 600, 20);  
  offscreenA = createGraphics(800, 600, P3D);

  ks.toggleCalibration();

}

void draw() {
  
  PVector surfaceMouse = surfaceA.getTransformedMouse();

  // Draw the scene, offscreen
  offscreenA.beginDraw();
  offscreenA.background(255);
  offscreenA.fill(0, 255, 0);
  offscreenA.ellipse(surfaceMouse.x, surfaceMouse.y, 75, 75);
  offscreenA.endDraw();

  background(0);
 
  //image(offscreenA,0,0);
  //ellipse(mouseX+100,mouseY,30,30);
  surfaceA.render(offscreenA);

}

void keyPressed() {
  switch(key) {
  case 'c':
    // enter/leave calibration mode, where surfaces can be warped 
    // and moved
    ks.toggleCalibration();
    break;

  case 'l':
    // loads the saved layout
    ks.load();
    break;

  case 's':
    // saves the layout
    ks.save();
    break;
  }
}
