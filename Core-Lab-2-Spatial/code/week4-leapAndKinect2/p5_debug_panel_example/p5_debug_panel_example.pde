boolean showText = false;

void setup(){
  size(400,400);
}

void draw(){
  
  background(255);
  
  // draw our text to screen
  if( showText == true){
    fill(0);
    text("Hello",30,30); // string, x, y
  }
}


void keyPressed(){
  if( key == 'a'){
    showText = true;
  }
  
  if( key == 'b'){
    showText = false;
  }
  
  if( key == 'x'){
    showText = !showText;
  }
  
}

