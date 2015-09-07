import com.leapmotion.leap.Bone;
import com.leapmotion.leap.Arm;
import com.leapmotion.leap.Controller;
import com.leapmotion.leap.Finger;
import com.leapmotion.leap.Frame;
import com.leapmotion.leap.Hand;
import com.leapmotion.leap.Tool;
import com.leapmotion.leap.Vector;
import com.leapmotion.leap.processing.LeapMotion;
import peasy.*;

LeapMotion leapMotion;
PeasyCam cam;

ArrayList<LeapHand>leapHands;

void setup()
{
  size(640, 480, P3D);
  background(20);

  leapMotion = new LeapMotion(this);

  leapHands = new ArrayList();
  cam = new PeasyCam(this, 430);
  cam.rotateX(radians(-60));
  cam.rotateY(radians(0));
  cam.rotateZ(radians(180));
}

void draw() {
  background(0);

  // leapOSC is sending x is reverse so scale- to compensate
  scale(-1, 1, 1);

  // draw hands
  pushMatrix();

  for (int i = 0; i < leapHands.size (); i++) {
    leapHands.get(i).draw();
  }

  // draw floor box
  drawFloor();

  popMatrix();
}



// Processes leap frame and stores hand info in hand objects
void onFrame(final Controller controller)
{
  Frame frame = controller.frame();

  leapHands.clear();

  for ( Hand hand : frame.hands () ) {

    leapHands.add( new LeapHand() );
    int i = leapHands.size()-1;

    // set palm and wrist
    leapHands.get(i).palm.set(hand.palmPosition().getX(), hand.palmPosition().getY(), hand.palmPosition().getZ());
    leapHands.get(i).wrist.set(hand.wristPosition().getX(), hand.wristPosition().getY(), hand.wristPosition().getZ());

    // set elbow
    Arm arm = hand.arm();
    leapHands.get(i).elbow.set(arm.elbowPosition().getX(), arm.elbowPosition().getY(), arm.elbowPosition().getZ());

    int f = 0;
    
    // set each fingertip and bone
    for (Finger finger : hand.fingers ()) {
      leapHands.get(i).fingerTips[f].set(finger.tipPosition().getX(), finger.tipPosition().getY(), finger.tipPosition().getZ());
      ArrayList<PVector>joints = new ArrayList();
      for (Bone.Type boneType : Bone.Type.values ()) {
        Bone bone = finger.bone(boneType);
        Vector boneEnd = bone.nextJoint();
        joints.add(new PVector(boneEnd.getX(), boneEnd.getY(), boneEnd.getZ()));
      }
      leapHands.get(i).fingers[f].setJoints(joints);

      f++;
    }
  }
}


void drawFloor() {

  // Draw a grid plane.
  pushMatrix();

  noFill();
  stroke(255);
  translate(0, 250, 0);
  box(500, 500, 500);
  popMatrix();

  rectMode(CENTER);
  pushMatrix();
  fill(120, 255);
  translate(0, 0, 0);
  rotateX(radians(90));
  rect(0, 0, 500, 500);
  popMatrix();
  rectMode(CORNER);

}
