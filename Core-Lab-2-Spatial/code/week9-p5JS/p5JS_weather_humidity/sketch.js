function setup() {
  createCanvas(600, 400);
  loadJSON('http://api.openweathermap.org/data/2.5/weather?q=Paris,France', drawWeather);
  //noLoop();
}

function draw(){
  
}

function drawWeather(weather) {
  // Get the loaded JSON data
  console.log(weather); // inspect the weather JSON
  var humidity = weather.main.humidity; // get the main.humidity out of the loaded JSON
  console.log(humidity); // inspect the humidity in the console
  background(40, 90, 200);
  noStroke();
  fill(0, 255, 255, humidity); // use the humidity value to set the alpha
  for (var i = 0; i < 50; i++) {
    ellipse(random(width), random(height), 30, 30);
  }
}