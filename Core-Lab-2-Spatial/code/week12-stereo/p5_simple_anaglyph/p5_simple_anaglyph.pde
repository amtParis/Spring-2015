
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
 
float rotation;

// to turn shader on / off
boolean isShader = true;

PVector cameraPosition;
PVector cameraTarget;

float eyeX = 0;
float eyeY = 0;
float eyeZ = -100; // position of the viewer
float eyeDist = 6; // distance between the two cameras, the higher, the more the graphics will "pop out"


PShader simple_anaglyph;
PGraphics left, right;


void setup() 
{
  size(500,500,P3D);
  
  left = createGraphics(width, height, P3D);
  right = createGraphics(width, height, P3D);
  
  simple_anaglyph = loadShader("simple_anaglyph.glsl");
  
  rotation = 0;
}
 
void draw()
{
  
  eyeDist = map(mouseX, 0, width, 0, 20);
  
  rotation += 0.01; //you can vary the speed of rotation by altering this value

  // Set up the shader
  PShader s; 
  s = simple_anaglyph;
  s.set("Left", left);
  s.set("Right", right);
    
 
  // Draw the scene for each eye
  drawScene(left, -eyeDist/2);
  drawScene(right, eyeDist/2);
  
  // Anything we draw after that will be affected by the shader
  if(isShader){ 
   shader(s);
  }
  
  // We need to draw an image to the screen that the shader will
  // be applied to
  image(left,0,0,width, height);  
  
  // Anything we draw after reset will not be affected by the shader anymore
  resetShader();
}

/* All of your 3D drawing goes here */
void drawScene(PGraphics pg, float offset) {
  
  int w = pg.width;
  int h = pg.height;
  
  pg.beginDraw();  
  
  pg.background(0);

  //some lights to aid the effect
  pg.ambientLight(64,64,64);
  pg.pointLight(128,128,128,0,20,-50);
  
  pg.pushMatrix();
  pg.fill(255);
  pg.noStroke();
  pg.rotateX(rotation);
  pg.rotateY(rotation/2.3);
  pg.scale(height*.003);
  pg.box(30);
  pg.translate(0,0,30);
  pg.box(10);
  pg.popMatrix();
  
  // use custom camera
  pg.camera(eyeX + offset, eyeY, eyeZ, 0,0,0,0,-1,0);
  
  pg.endDraw();
}


void keyPressed() {
 if (key == 'x' || key == 'X') { 
   isShader = !isShader; 
   println("isShader = "+ isShader);
 }
}
