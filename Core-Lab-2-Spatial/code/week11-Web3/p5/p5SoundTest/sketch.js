
function setup() {
  createCanvas(windowWidth, windowHeight);
  background(30); // alpha

  
  oscillator = new p5.SinOsc(440);
  oscillator.start();

}

function draw() {
  var modFreq = map(touchY, 0, height, 700, 1);
  oscillator.freq(modFreq);

  var modAmp = map(touchX, 0, width, 0, 1);
  oscillator.amp(modAmp, 0.01); // fade time of 0.1 for smooth fading
 
  ellipse(touchX,touchY,20,20);
 
}


function touchMoved() {
  // do some stuff
  return false;
}