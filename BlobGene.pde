class BlobGene extends Gene {
  BlobGene(int wd, int ht) {
    super(wd, ht);
  }

  // renders to inernal buffer
  void render() {
    // first, draw the data
    pg.beginDraw();
    pg.background( 0 );
    pg.noStroke();
    resetGeneCounter();
    for (int i=0; i < this.active_length; i += 3) {
      float x = getNextValue( );
      float y = getNextValue( );
      float w = getNextValue( );
      x = x * pg.width;
      y = y * pg.height;
      if (w > 0.5) {
        pg.fill( 255, 128 );
        w = w - 0.5;
      } 
      else {
        pg.fill( 0, 128 );
      }
      w = w * pg.width;
      pg.ellipse(x, y, w, w);
    }
    pg.endDraw();
    reflect();
  }
}

