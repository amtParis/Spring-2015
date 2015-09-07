class DNA {

  //color c;
  float [] genes;
  float [] old_genes;

  PVector pos;

  float fitness;
  float old_fitness;

  DNA(float _x, float _y, int r, int g, int b) {
    genes = new float[3];
    old_genes = new float[3];
    genes[0] = r;
    genes[1] = b;
    genes[2] = g;

    for (int i = 0; i < old_genes.length; i++) {
      old_genes[i] = genes[i];
    }

    pos = new PVector(_x, _y);
    fitness = 1;
    old_fitness = 1;
  }

  void update() {


    for (int i =0; i < old_genes.length; i++) {
      old_genes[i] = (.9*old_genes[i] + .1*genes[i]);
    }

    old_fitness = .9*old_fitness+.1*fitness;
  }

  // simple drawing function
  void display() {

    int alpha = 100;
    int radius = 100;
    for ( int i = 0; i < 4; i++) {
      fill((int)old_genes[0], (int)old_genes[1], (int)old_genes[2], alpha);
      ellipse(pos.x, pos.y, radius*old_fitness, radius*old_fitness);
      alpha += 30;
      radius -= 20;
    }


    //ellipse(pos.x, pos.y, 20*fitness, 20*fitness);
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


  DNA crossover(DNA partner, DNA original) {

    float [] childGenes = {
      0, 0, 0
    };

    // A new child
    DNA child = new DNA( original.pos.x, original.pos.y, 0, 0, 0);

    // randomly select "genes" from each parent
    for (int i = 0; i < genes.length; i++) {
      int randomParent = (int)random(2);
      if (randomParent == 0) childGenes[i] = genes[i];
      else childGenes[i] = partner.genes[i];
    }

    child.old_genes = original.old_genes;
    child.old_fitness = original.old_fitness;
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

