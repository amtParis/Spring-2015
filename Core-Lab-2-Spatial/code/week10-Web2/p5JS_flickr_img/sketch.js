var img;

function setup() {
  createCanvas(500,500)
  getImage("nyc");
}

function draw(){
  if(img){
    image(img,0,0);
  }
}

function getImage(word) {
  var rootUrl = "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=bd48f728c5fd32a23cf3fdd7f2ba8fcf&format=json";
  var key = "";
  var text = "&text="+word;
  var page = "&per_page=1";
  var url = rootUrl + text + page + key;
  console.log(url);
  loadJSON(url, jsonFlickrApi);

}

function jsonFlickrApi(json) {
  
  var serverid = json.photos.photo[0].server;
  var secretid = json.photos.photo[0].secret;
  var farmid = json.photos.photo[0].farm;
  var id = json.photos.photo[0].id;
  var owner = json.photos.photo[0].owner;
  var imageURL = "http://farm"+farmid+".staticflickr.com/"+serverid+"/"+id+"_"+secretid+".jpg";
 img = loadImage(imageURL);
  //img.parent(parentDiv);
}