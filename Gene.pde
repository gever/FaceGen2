int MAX_GENE_LENGTH = 512;

class Gene {
  float[] data;
  public int active_length;
  public int next_value = 0;
  PGraphics pg;

  Gene(int wd, int ht) {
    data = new float[MAX_GENE_LENGTH];
    pg = createGraphics(wd, ht, P2D);
    this.randomize();
  }

  void randomize() {
    active_length = (int)random(MAX_GENE_LENGTH / 2) + 10;

    // to allow for simple expansion of active area
    // of the gene, the entire gene space is filled
    // with random data (akin to carrying "junk data")
    for (int i=0; i<MAX_GENE_LENGTH; i++) {
      data[i] = random(1);
    }
  }

  void mutate(float pct) {
    // decide if we are going to lengthen the gene
    if (random(1) > 0.9) {
      if (random(1) > 0.5) {
        this.active_length += 1;
      } 
      else {
        this.active_length -= 1;
      }
      active_length = constrain( active_length, 6, MAX_GENE_LENGTH );
    }
    // note how even the "junk data" of the gene is mutated
    for (int i=0; i<MAX_GENE_LENGTH; i++) {
      // change this data?
      if (random(1) < pct) {
        // what kind of change?
        if (random(1) > 0.8) {
          this.data[i] = random(1);
        } 
        else {
          this.data[i] = constrain( this.data[i] + (random(0.2) - 0.1), 0, 1.0);
        }
      }
    }
  }

  void copy( Gene src ) {
    for (int i=0; i<MAX_GENE_LENGTH; i++) {
      this.data[i] = src.data[i];
    }
    this.active_length = src.active_length;
  }

  float getValue(int i) {
    i = i % this.active_length;
    return this.data[i];
  }

  void resetGeneCounter() {
    next_value = 0;
  }

  float getNextValue() {
    float v = this.data[next_value];
    next_value = (next_value + 1) % active_length;
    return v;
  }

  // renders to inernal buffer
  void render() {
    // first, draw the data
    pg.beginDraw();
    pg.background( 0 );
    pg.fill( 200 );
    resetGeneCounter();
    for (int i=0; i < this.active_length; i += 3) {
      float x = getNextValue( );
      float y = getNextValue( );
      x = x * pg.width;
      y = y * pg.height;
      pg.ellipse(x, y, 20, 20);
    }
    pg.endDraw();
    reflect();
  }

  void reflect( ) {
    pg.loadPixels();
    stroke(255, 100, 100);
    for ( int i=0; i < pg.width/2; i++ ) {
      copyLine( pg, i, (pg.height-1)-i);
    }
    pg.updatePixels();
  }

  void copyLine(PGraphics img, int src, int dest) {
    int srcP = img.width * src;
    int destP = img.width * dest;
    arrayCopy(img.pixels, srcP, img.pixels, destP, img.width);
  }

  PGraphics getImage() {
    return pg;
  }
}
