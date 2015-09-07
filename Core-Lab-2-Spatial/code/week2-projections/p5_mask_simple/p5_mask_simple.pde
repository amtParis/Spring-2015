PImage maskImage;

void setup() {
  size(800, 600);
  maskImage = loadImage("mask.png");
}

void draw() {

  background(255);

  rectMode(CENTER);
  // draw animation
  pushMatrix();
  translate(width/2, height/2);
  if (frameCount % 10 == 0) {
    fill(random(255), random(255), random(255));
  }
  rotate(millis()*.001);
  rect(0, 0, 300, 300);
  popMatrix();
  rectMode(CORNER);

  // darw mask on top of everything
  image(maskImage, 0, 0);
}

