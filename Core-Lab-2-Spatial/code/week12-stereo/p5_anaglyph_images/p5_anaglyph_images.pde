
// stereo viewing taken from http://wiki.processing.org/index.php?title=Stereo_viewing
// @author John Gilbertson

// Optimised anaglyph shader by John Einselen
// http://iaian7.com/quartz/AnaglyphCompositing

// Simple anaglyph shader by r3dux
// http://r3dux.org/2011/05/anaglyphic-3d-in-glsl/

// Adapted for Processing 2.0 by Raphaël de Courville
// https://twitter.com/sableRaph

// X: switch 3D on/off
// MouseX: 3D effect


// to turn shader on / off
boolean isShader = true;

float eyeDist = 6; // distance between the two cameras, the higher, the more the graphics will "pop out"
int imgY = 0;

Integer colorOrder  = 0; // 0 red is on left, 1 red is on right

PShader simple_anaglyph;
PGraphics left, right;
PImage imgL, imgR;


void setup() 
{

  imgL = loadImage("IMG_2640.jpg");
  imgR = loadImage("IMG_2641.jpg");  
  size(imgL.width, int(imgL.height*.6), P3D);

  left = createGraphics(width, height, P3D);
  right = createGraphics(width, height, P3D);

  simple_anaglyph = loadShader("simple_anaglyph.glsl");


}

void draw()
{

  eyeDist = map(mouseX, 0, width, 0, 20);


  // Set up the shader
  PShader s; 
  s = simple_anaglyph;
  s.set("Left", left);
  s.set("Right", right);
  s.set("colorOrder", colorOrder);

  left.beginDraw();
  left.image(imgL, eyeDist, imgY);
  left.endDraw();

  right.beginDraw();
  right.image(imgR, -eyeDist, 0);
  right.endDraw();

  // Anything we draw after that will be affected by the shader
  if (isShader) { 
    shader(s);
  }

  // We need to draw an image to the screen that the shader will
  // be applied to
  image(left, 0, 0, width, height);  

  // Anything we draw after reset will not be affected by the shader anymore
  resetShader();
}


void keyPressed() {
  if (key == 'x' || key == 'X') { 
    isShader = !isShader; 
    println("isShader = "+ isShader);
  }else if(keyCode == DOWN){
    imgY++;
  }else if(keyCode == UP){
    imgY--;
  }
}

