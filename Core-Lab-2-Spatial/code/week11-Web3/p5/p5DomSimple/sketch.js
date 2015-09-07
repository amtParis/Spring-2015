var x = 0;

function setup() {
  createCanvas(200,200);
}

function draw() {
  background(0,255,255);
  rect(x,0,30,30);
  //x+=1;
}

function moveMe(){
  x++;
}