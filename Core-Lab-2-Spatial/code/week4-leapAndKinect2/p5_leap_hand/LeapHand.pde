class LeapHand {

  PVector [] fingerTips = new PVector[5];
  PVector palm;
  PVector wrist;
  PVector elbow;
  LeapFinger [] fingers = new LeapFinger[5];
  int type;

  LeapHand() {
    palm = new PVector(0, 0, 0);
    wrist = new PVector(0, 0, 0);
    elbow = new PVector(0, 0, 0);
    
    for (int i = 0; i < fingerTips.length; i++) {
      fingerTips[i] = new PVector(0, 0, 0);
    }
 
    for (int i = 0; i < fingers.length; i++) {
      fingers[i] = new LeapFinger(4);
    }
  }

  void update() {
  }

  void draw() {

    fill(255);
    sphereDetail(15);

    pushMatrix();
    translate(palm.x, palm.y, palm.z);
    fill(255);
    sphere(10);
    popMatrix();

    pushMatrix();
    translate(wrist.x, wrist.y, wrist.z);
    fill(255);
    sphere(6);
    popMatrix();

    stroke(255);
    line(wrist.x, wrist.y, wrist.z, elbow.x, elbow.y, elbow.z);
    line(wrist.x, wrist.y, wrist.z, palm.x, palm.y, palm.z);

    for (int i = 0; i < fingerTips.length; i++) {
      pushMatrix();
      translate(fingerTips[i].x, fingerTips[i].y, fingerTips[i].z);
      fill(255);
      sphereDetail(10);
      sphere(3);
      popMatrix();
    }

    for (int i = 0; i < fingers.length; i++) {
      fingers[i].draw();
    }
    
  }
}

class LeapFinger {

  ArrayList<PVector>joints;

  LeapFinger(int nJoints) {
    joints = new ArrayList();
    for (int i = 0; i < nJoints; i++) {
      joints.add(new PVector(0, 0, 0));
    }
  }

  void setJoints(ArrayList<PVector> m_joints ) {
    for ( int i = 0; i < m_joints.size (); i++) {
        joints.get(i).set(m_joints.get(i).x,m_joints.get(i).y,m_joints.get(i).z);
    }
  }

  void draw() {
    
    // draw joints
    for ( int i = 0; i < joints.size (); i++) {
      PVector joint = joints.get(i);
      pushMatrix();
      translate(joint.x, joint.y, joint.z);
      fill(255);
      sphereDetail(10);
      sphere(3);
      popMatrix();
      
    }
    
    // draw connections "bones"
    for ( int i = 1; i < joints.size (); i++) {
      PVector a = joints.get(i-1);
      PVector b = joints.get(i);
      line(a.x, a.y, a.z, b.x, b.y, b.z);
    }
  }
}
