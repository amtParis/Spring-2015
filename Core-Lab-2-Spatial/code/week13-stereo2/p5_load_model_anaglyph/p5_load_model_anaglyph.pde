boolean isShader = true;
PShape rocket;

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

  rocket = loadShape("rocket.obj");
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
  pg.lights();

  // large centered
  pg.pushMatrix();
  pg.translate(width/2, height/2, 0);
  pg.rotateZ(PI);
  pg.rotateX(PI/2.2);
  pg.rotateY(rotation);
  pg.shape(rocket);
  pg.popMatrix();
  
  // circle of rockets behind
  float ang = -90;
  for(int i = 0; i < 10;  i++){
  pg.pushMatrix();
  pg.translate(width/2+2000*sin(radians(ang)), height/2, -1000-4000*cos(radians(ang)));
  pg.rotateZ(PI);
  pg.rotateY(rotation);
  pg.scale(2);
  pg.shape(rocket);
  pg.popMatrix();
  ang+=18;
  }
  
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

