/*
Simlpe point cloud example. Requirs PeayCam Library
 */
import peasy.*;
import SimpleOpenNI.*;

SimpleOpenNI  kinect;
PeasyCam cam;


void setup() {

  size(640, 480, P3D);
  
  // set up peasy cam to work with kinect frustrum
  cam = new PeasyCam(this, -500); // zoom out to -1000 (change to be far/closer)
  cam.rotateZ(radians(180)); // rotate 180 or we are upsiede down
  
  kinect = new SimpleOpenNI(this);
  if (kinect.isInit() == false) {
    println("Can't init SimpleOpenNI, maybe the camera is not connected!"); 
    exit();
    return;
  }

  // enable depthMap generation 
  kinect.enableDepth();
  kinect.enableRGB();
  kinect.setDepthColorSyncEnabled(true);
}

void draw() {

  // update the kinect
  kinect.update();

  background(0);

  // get the depth image from the kinect
  // this is the grayscale image that shows depth by gray value
  // values are saved in an array with gray values for depth of each pixel
  int[]   depthMap = kinect.depthMap();

  // get the rgb image
  PImage  rgbImage = kinect.rgbImage();

  // stores the real world coordinates of each pixel x,y,z
  PVector[] realWorldMap = kinect.depthMapRealWorld();

  // object to hold current point we are drawing
  PVector realWorldPoint;
  
  // color variable to store current pixel color from rgb image
  color   pixelColor;

  int steps = 10;
  stroke(255);
  beginShape(POINTS);
  for (int y=0; y < kinect.depthHeight (); y+=steps) {

    for (int x=0; x < kinect.depthWidth (); x+=steps) {

      int index = x + y * kinect.depthWidth();

      if (depthMap[index] > 0) {
        // get real world coordinates from array
        realWorldPoint = realWorldMap[index];
        
        // get the color of the point
        pixelColor = rgbImage.pixels[index];
        stroke(pixelColor);
        
        vertex(realWorldPoint.x, realWorldPoint.y, realWorldPoint.z);  
        // make realworld z negative, in the 3d drawing coordsystem +z points in the direction of the eye
      }
    }
  } 
  endShape();

  // draw the kinect cam
  kinect.drawCamFrustum();
}
