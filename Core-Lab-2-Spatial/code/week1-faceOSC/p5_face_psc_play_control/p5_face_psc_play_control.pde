
import oscP5.*;
import ddf.minim.*;

OscP5 oscP5;

Minim minim;
AudioPlayer player;

int found;
float eyeLeft;
float eyeRight;

void setup()
{
  size(512, 200, P3D);

  oscP5 = new OscP5(this, 8338);
  oscP5.plug(this, "found", "/found");
  oscP5.plug(this, "eyeLeftReceived", "/gesture/eye/left");
  oscP5.plug(this, "eyeRightReceived", "/gesture/eye/right");

  // we pass this to Minim so that it can load files from the data directory
  minim = new Minim(this);

  // loadFile
  player = minim.loadFile("marcus_kellis_theme.mp3");

  // play the file looping.
  player.loop();

  // set volume to 0 to start
  //player.setVolume(0);
}

void draw()
{
  background(0);
  stroke(255);

  if (found == 0) player.mute();
  else {
    if (eyeLeft < 3 && eyeRight < 3)player.unmute();
    else player.mute();
  }

  // draw the waveforms
  if (!player.isMuted()) {
    for (int i = 0; i < player.bufferSize () - 1; i++)
    {
      float x1 = map( i, 0, player.bufferSize(), 0, width );
      float x2 = map( i+1, 0, player.bufferSize(), 0, width );
      line( x1, 50 + player.left.get(i)*50, x2, 50 + player.left.get(i+1)*50 );
      line( x1, 150 + player.right.get(i)*50, x2, 150 + player.right.get(i+1)*50 );
    }
  }
}

public void found(int i) {
  println("found: " + i);
  found = i;
}


public void eyeRightReceived(float f) {
  println("eye right: " + f);
  eyeRight = f;
}

public void eyeLeftReceived(float f) {
  println("eye left: " + f);
  eyeLeft = f;
}

