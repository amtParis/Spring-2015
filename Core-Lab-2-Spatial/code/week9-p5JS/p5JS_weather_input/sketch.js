var input, button;
var canvas;

function setup() {
  //var myCanvas = 
  canvas = createCanvas(600, 400);
  canvas.parent('myContainer');

  input = createInput();
  input.position(10, 450);

  button = createButton('submit');
  button.position(170, 450);
  button.mousePressed(getWeather);

  loadJSON('http://api.openweathermap.org/data/2.5/weather?q=Paris,France', drawWeather);
}

function draw() {

}

function getWeather() {
  var place = input.value();
  var apiString = "http://api.openweathermap.org/data/2.5/weather?q=" + place;
  loadJSON(apiString, drawWeather);

}

function drawWeather(weather) {
  // Get the loaded JSON data
  console.log(weather); // inspect the weather JSON
  var humidity = weather.main.humidity; // get the main.humidity out of the loaded JSON
  console.log(humidity); // inspect the humidity in the console
  background(40, 90, 200);
  noStroke();
  fill(0, 255, 255, 127); // use the humidity value to set the alpha
  for (var i = 0; i < humidity; i++) {
    ellipse(random(width), random(height), 30, 30);
  }
  
  var elem = document.getElementById("humidity");
  elem.innerHTML = "Humidity: "+humidity;
}