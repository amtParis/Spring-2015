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
CornerPinSurface surfaceB;
CornerPinSurface surfaceC;

PGraphics offscreenA;
PGraphics offscreenB;
PGraphics offscreenC;

PImage penguin;

void setup() {
  // Keystone will only work with P3D or OPENGL renderers, 
  // since it relies on texture mapping to deform
  // if you want to use presentation mode, set the size to screen res
  size(1280, 800, P3D);
  
  penguin = loadImage("penguin.png");
  
  ks = new Keystone(this);
  surfaceA = ks.createCornerPinSurface(400, 300, 20);
  surfaceB = ks.createCornerPinSurface(400, 300, 20);
  surfaceC = ks.createCornerPinSurface(400, 300, 20);
  
  // move the surfaces so they do not overlap
  surfaceA.moveTo(0,100);
  surfaceB.moveTo(410,100);
  surfaceC.moveTo(0,410);
  
  // uncomment to load saved alignment
  //ks.load();
  
  // We need an offscreen buffer to draw the surface we
  // want projected
  // note that we're matching the resolution of the
  // CornerPinSurface.
  // (The offscreen buffer can be P2D or P3D)
  offscreenA = createGraphics(400, 300, P3D);
  offscreenB = createGraphics(400, 300, P3D);
  offscreenC = createGraphics(400, 300, P3D);


}

void draw() {
  
  
  // Convert the mouse coordinate into surface coordinates
  // this will allow you to use mouse events inside the 
  // surface from your screen. 
  PVector surfaceMouse = surfaceA.getTransformedMouse();

  // Draw the scene, offscreen
  offscreenA.beginDraw();
  offscreenA.background(255);
  offscreenA.fill(0, 255, 0);
  offscreenA.ellipse(surfaceMouse.x, surfaceMouse.y, 75, 75);
  offscreenA.endDraw();

  offscreenB.beginDraw();
  offscreenB.background(234,54,209);
  offscreenB.imageMode(CENTER);
  offscreenB.image(penguin,200,150);
  offscreenB.endDraw();
  
  offscreenC.beginDraw();
  offscreenC.background(234,254,13);
  offscreenC.endDraw();
  
  // most likely, you'll want a black background to minimize
  // bleeding around your projection area
  background(0);
 
 // some instructions
  fill(255);
  textSize(12);
  text("Press 'c' to distort\nPress 'l' to load\nPress 's' to save",10,20);
  
  
  // render the scene, transformed using the corner pin surface
  surfaceA.render(offscreenA);
  surfaceB.render(offscreenB);
  surfaceC.render(offscreenC);
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