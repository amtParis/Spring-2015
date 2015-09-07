PImage img;

void setup() {

  img = loadImage("orange.jpg");

  size(img.width, img.height, P3D);

  noStroke();
}

void draw() {

  background(0);

  // steps are the amount of pixels we increment by
  // largers steps make a larger grid with less detail
  int step = 10;


  // indicate we want to use quads wth this shape
  beginShape(QUADS);

  // attach texture
  texture(img);
  // no change in z in this example
  float z = 0;

  // create a grid of texture points
  /*
  Note vertices go in this direction:
   1 --> 2
   |     |
   4 <-- 3
   */

  for (int x = 0; x < img.width-step; x+=step) {
    for ( int y = 0; y < img.height-step; y+=step) {

      vertex(x, y, z, x, y);
      vertex(x+step, y, z, x+step, y);
      vertex(x+step, y+step, z, x+step, y+step);
      vertex(x, y+step, z, x, y+step);
    }
  }
  endShape();
}
