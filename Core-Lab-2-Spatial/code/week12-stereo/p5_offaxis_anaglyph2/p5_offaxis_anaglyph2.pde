boolean isShader = true;

float eyeSeparation = 4; 
float fovy = 45;
float nearPlane = 5;
float farPlane = nearPlane * 10000;
float aspectRatio, top, bottom; // calc later in setup

PShader simple_anaglyph;
PGraphics left, right;

Integer colorOrder  = 0; // 0 red is on left, 1 red is on right

float rotation = 0;

void setup() 
{
  size(1000, 500, P3D);

  aspectRatio = width / (float)height;
  top     = nearPlane * tan(fovy/2.0);
  bottom  = -top;

  left = createGraphics(width, height, P3D);
  right = createGraphics(width, height, P3D);

  simple_anaglyph = loadShader("simple_anaglyph.glsl");
}

void draw()
{

  //eyeSeparation = map(mouseX,0,width,0,10);

  PShader s;
  s = simple_anaglyph;

  s.set("Left", left);
  s.set("Right", right);
  s.set("colorOrder", colorOrder);
  
  // Draw the scene for each eye, drwaing into pGraphic
  left.beginDraw();
  leftCamera(left);
  drawScene(left);
  left.endDraw();

  right.beginDraw();
  rightCamera(right);
  drawScene(right);
  right.endDraw();

  // Call shader - anything we draw after, will be affected by the shader
  if (isShader) {
    shader(s);
  }
  // Any image will do but we have to call the function as we're using a TEXTURE shader
  image(left, 0, 0, width, height);  

  // Anything we draw after will not be affected by the shader anymore
  resetShader();

  // Update rotation
  rotation += .01;
}

/* All of your 3D drawing goes here */
void drawScene(PGraphics pg) {

  pg.background(0);

  pg.ambientLight(64, 64, 64);
  pg.pointLight(128, 128, 128, 0, 200, 500);

  pg.pushMatrix();
  pg.translate(width/2, height/2, 0);
  pg.fill(200, 200, 255);
  pg.rect(-250, -250, 200, 200);
  pg.popMatrix();

  pg.pushMatrix();
  pg.translate(width/2+1300, height/2, -3800);
  pg.fill(128);
  pg.noStroke();
  pg.rotateX(rotation);
  pg.rotateY(rotation);
  pg.box(500);
  pg.popMatrix();

  pg.pushMatrix();
  pg.translate(width/2, height/2, 300);
  pg.fill(255);
  pg.noStroke();
  pg.translate(0, 0, 0);
  pg.rotateX(rotation);
  pg.rotateY(rotation);
  pg.box(50);
  pg.translate(0, 60, 0);
  pg.box(10);
  pg.popMatrix();
}

void leftCamera(PGraphics pg) {

  float nleft    = aspectRatio * bottom;
  float nright   = aspectRatio * top;
  nleft  -= .0035*nright;
  nright -= .0035*nright;

  // create off-axis frustum and translate
  pg.frustum(nleft, nright, bottom, top, nearPlane, farPlane);
  pg.translate(-eyeSeparation/2, 0, 0);
}

void rightCamera(PGraphics pg) {

  float nleft    = aspectRatio * bottom;
  float nright   = aspectRatio * top;

  // small sdjustment to make 0 windowplane aligned
  nleft  += .0035*nright;
  nright += .0035*nright;

  // create off-axis frustum and translate
  pg.frustum(nleft, nright, bottom, top, nearPlane, farPlane);
  pg.translate(eyeSeparation/2, 0, 0);
}




void keyPressed() {
  if (key == 'x' || key == 'X') { 
    isShader = !isShader; 
    println("isShader = "+ isShader);
  }
}

