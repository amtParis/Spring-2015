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

  // load pixels to get brightness
  img.loadPixels();

  // translate to center for 3d rotation
  translate(width / 2, height / 2);
  rotateY(map(mouseX, 0, width, -PI, PI));
  rotateZ(PI/6);
  translate(-img.width/2, -img.height/2, 0);

  // indicate we want to use quads wth this shape
  beginShape(QUADS);

  // attach texture
  texture(img);

  // create a grid of texture points
  // width-step so we don't go over index values in image
  for (int x = 0; x < img.width-step; x+=step) {
    for ( int y = 0; y < img.height-step; y+=step) {

      // get pixel index for each so depth goes with brightness
      int index = y*img.width+x;
      float b = brightness(img.pixels[index]);
      vertex(x, y, b*.5, x, y);

      index = y*img.width+(x+step);
      b = brightness(img.pixels[index]);
      vertex(x+step, y, b*.5, x+step, y);

      index = (y+step)*img.width+(x+step);
      b = brightness(img.pixels[index]);
      vertex(x+step, y+step, b*.5, x+step, y+step);

      index = (y+step)*img.width+(x);
      b = brightness(img.pixels[index]);
      vertex(x, y+step, b*.5, x, y+step);
    }
  }
  endShape();
}
