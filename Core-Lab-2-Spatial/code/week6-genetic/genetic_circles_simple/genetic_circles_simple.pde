// define an arraylist of our population
ArrayList<DNA> dna;

// define our target color
int [] targetColor = {202,9,224};

float mutationRate = 0.01;    // Mutation rate


void setup(){
  size(400,400);
  
  dna = new ArrayList();
  
  // create the initial population
  int totalPopulation = 150;
  for(int i = 0; i < totalPopulation; i++){
    dna.add( new DNA((int)random(255), (int)random(255), (int)random(255)) );
  }
  
}

void draw(){
  background(targetColor[0],targetColor[1],targetColor[2]);
  noStroke();
  // loop through everybody and draw them
  for( int i = 0; i < dna.size(); i++){
    DNA d = dna.get(i);
    d.calculateFitness();
    d.display();
  }     
  if(frameCount % 10 == 0) nextGeneration();
}


void nextGeneration(){
  
  ArrayList<DNA> matingPool = new ArrayList<DNA>();  // ArrayList which we will use for our "mating pool"

  for (int i = 0; i < dna.size(); i++) {
    int n = int(dna.get(i).fitness * 100);  // arbitrary mult, we can also use monte carlo methodiplier
    for (int j = 0; j < n; j++) {        // and pick two random numbers      
      matingPool.add(dna.get(i));
    }
  }
  
  
  for (int i = 0; i < dna.size(); i++) {
    int a = int(random(matingPool.size()));
    int b = int(random(matingPool.size()));
    DNA partnerA = matingPool.get(a);
    DNA partnerB = matingPool.get(b);
    DNA child = partnerA.crossover(partnerB);
    child.mutate(mutationRate);
    dna.set(i,child);
  }
}


void keyPressed(){
  if( key == ' ') nextGeneration();
  else if( key == 'x'){ 
    for(int i = 0; i < targetColor.length; i++){
      targetColor[i] = (int)random(255);
    }
  }
}


