// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Recursive Tree
// Renders a simple tree-like structure via recursion
// Branching angle calculated as a function of horizontal mouse location

import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;


Minim minim;
AudioPlayer player;
AudioInput in;

float theta;   
float blendVol = 0;

void setup() {
  size(1280, 800);
  smooth();
  
  minim = new Minim(this);
  //player = minim.loadFile("05-Sorte.mp3");
  //player.loop();
    in = minim.getLineIn();

}

void draw() {
  //background(70,163,209);
  noStroke();
  fill(70,163,209,30);
  rect(0,0,width,height);
  // Let's pick an angle 0 to 90 degrees based on the mouse position
  if(blendVol == 0 ) blendVol = (in.mix.level()*1000);
  blendVol = .99*blendVol + .01*(in.mix.level()*1000);
  //println((in.mix.level()*1000));
  
  theta = map(blendVol,0,60,0,PI/2);

  // Start the tree from the bottom of the screen
  pushMatrix();
  translate(width/2, height);
  stroke(255);
  branch(240);
  popMatrix();
  
}

void branch(float len) {
  // Each branch will be 2/3rds the size of the previous one

  float sw = map(len,2,120,1,10);
  strokeWeight(sw);
      
  line(0, 0, 0, -len);
  // Move to the end of that line
  translate(0, -len);

  len *= 0.66;
  // All recursive functions must have an exit condition!!!!
  // Here, ours is when the length of the branch is 2 pixels or less
  if (len > 2) {
    pushMatrix();    // Save the current state of transformation (i.e. where are we now)
    rotate(theta);   // Rotate by theta
    branch(len);       // Ok, now call myself to draw two new branches!!
    popMatrix();     // Whenever we get back here, we "pop" in order to restore the previous matrix state

    // Repeat the same thing, only branch off to the "left" this time!
    pushMatrix();
    rotate(-theta);
    branch(len);
    popMatrix();
  }
}

