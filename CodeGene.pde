class CodeGene extends Gene {
  CodeGene(int wd, int ht) {
    super(wd, ht);
  }
  
  SimpleStack returnStack = new SimpleStack();
  SimpleStack paramStack = new SimpleStack();

  void reset() {
    returnStack.reset();
    paramStack.reset();
  }
  
  void step() {
    
  }
  
  // renders to internal buffer
  void render() {
    // reset the graphics state
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

