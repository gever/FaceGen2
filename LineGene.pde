class LineGene extends Gene {
  LineGene(int wd, int ht) {
    super(wd, ht);
  }

  // renders to inernal buffer
  void render() {
    // first, draw the data
    pg.beginDraw();
    pg.background( 0 );
    pg.smooth();
    pg.stroke( 255 );
    pg.strokeWeight( 3 );
    pg.fill( 80 );
    pg.beginShape();
    resetGeneCounter();
    for (int i=0; i < this.active_length; i += 3) {
      float x = getNextValue( );
      float y = getNextValue( );
      x = x * pg.width;
      y = y * pg.height;
      pg.curveVertex(x, y);
    }
    pg.endShape(CLOSE);
    pg.endDraw();
    reflect();
  }
}

