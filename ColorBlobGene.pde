class ColorBlobGene extends Gene {
  ColorBlobGene(int wd, int ht) {
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
      float r = getNextValue( );
      float g = getNextValue( );
      float b = getNextValue( );
      float a = getNextValue( );
      x = x * pg.width;
      y = y * pg.height;
      w = w * pg.width;
      r = r * 192 + 64;
      g = g * 192 + 64;
      b = b * 192 + 64;
      a = a * 192 + 64;
      pg.fill( r, g, b, a );
      pg.ellipse(x, y, w, w);
    }
    pg.endDraw();
    reflect();
  }
}
