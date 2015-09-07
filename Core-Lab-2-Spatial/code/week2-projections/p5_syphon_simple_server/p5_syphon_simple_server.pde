// be sure to install syphon library
import codeanticode.syphon.*;

// for syphon we need to draw into a canvas that we can send out
PGraphics canvas;
// create syphon object
SyphonServer server;

void setup() {
  size(800, 600, P3D);
  canvas = createGraphics(800, 600, P3D);
  server = new SyphonServer(this, "Processing Syphon");
}


void draw() {
  
  // first draw into the canvas
  canvas.beginDraw();
  canvas.background(0);
  canvas.rectMode(CENTER);
  canvas.translate(width/2, height/2);
  if(frameCount % 10 == 0) canvas.fill(random(255),random(255),random(255));
  canvas.rotate(millis()*.001);
  canvas.rect(0,0, 300, 300);
  canvas.endDraw();

  // now darw the canvas to the screen
  image(canvas, 0, 0);
  
  // send to client using syphon
  server.sendImage(canvas);
}

