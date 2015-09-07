class DNA {

  //color c;
  int [] genes;
  int x;
  int y; 
  float fitness;

  DNA(int r, int g, int b) {
    genes = new int[3];
    genes[0] = r;
    genes[1] = b;
    genes[2] = g;
    x = (int)random(width);
    y = (int)random(height);
    fitness = 1;
  }

  // simple drawing function
  void display() {
    fill(genes[0], genes[1], genes[2]);
    ellipse(x, y, 20*fitness, 20*fitness);
  }

  void calculateFitness() {

    // score based on how close to target
    // how close is each color channel to target channe;
    float rDiff = abs(targetColor[0]-genes[0]);
    float gDiff = abs(targetColor[1]-genes[1]);
    float bDiff = abs(targetColor[2]-genes[2]);

    fitness = (rDiff + gDiff + bDiff) / (255*3);

    // so that 1 equals most fit and 0 least
    fitness = 1 - fitness;
  }


  DNA crossover(DNA partner) {

    int [] childGenes = {
      0, 0, 0
    };

    // A new child
    DNA child = new DNA( 0, 0, 0 );

    // randomly select "genes" from each parent
    for (int i = 0; i < genes.length; i++) {
      int randomParent = (int)random(2);
      if (randomParent == 0) childGenes[i] = genes[i];
      else childGenes[i] = partner.genes[i];
    }

    child.genes = childGenes;

    return child;
  }


  void mutate(float mutationRate) {

    for (int i = 0; i < genes.length; i++) {
      if (random(1) < mutationRate) {
        genes[i] = (int) random(255);
      }
    }
  }
}

