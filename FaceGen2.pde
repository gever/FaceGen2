void drawLabel( String s, int x, int y ) {
  fill( 0 );
  text( s, x, y);
  fill( 255 );
  text( s, x+1, y+1);
}

int POOL_SIZE = 9;
Gene[] genes = null;

boolean changed = true;
boolean show_data = false;
int cellWidth = 0;
int cellHeight = 0;

void setup( ) {
  // TODO: eliminate the janky sizing going on here
  size( 700, 700, P2D );
  cellWidth = width / 3;
  cellHeight = height / 3;

  smooth();
  newDefaultGenes();
}

// generate a blank set of genes
void newDefaultGenes() {
  changed = true;
  genes = new Gene[POOL_SIZE];
  for (int i=0; i<genes.length; i++) {
    genes[i] = new Gene(cellWidth, cellHeight);
  }
}


void newBlobGenes() {
  changed = true;
  genes = new BlobGene[POOL_SIZE];
  for (int i=0; i<genes.length; i++) {
    genes[i] = new BlobGene(cellWidth, cellHeight);
  }
}

void newLineGenes() {
  changed = true;
  genes = new LineGene[POOL_SIZE];
  for (int i=0; i<genes.length; i++) {
    genes[i] = new LineGene(cellWidth, cellHeight);
  }
}

void newColorBlobGenes() {
  changed = true;
  genes = new ColorBlobGene[POOL_SIZE];
  for (int i=0; i<genes.length; i++) {
    genes[i] = new ColorBlobGene(cellWidth, cellHeight);
  }
}

void draw( ) {
  PGraphics pg;

  if (changed) {
    for (int y = 0; y < 3; y++) {
      for (int x = 0; x < 3; x++) {
        int i = y * 3 + x;
        genes[i].render();
        pg = genes[i].getImage();
        pg.background( 0 );

        int gapW = (height - (cellHeight * 3)) / 3;
        int gapH = (width - (cellWidth * 3)) / 3;
        pushMatrix( );
        translate( x * (cellWidth + gapW), y * (cellHeight + gapH) );
        pushMatrix( );
        translate( cellWidth, 0 );
        rotate( HALF_PI );
        image( pg, 0, 0 );

        if (true) {
          noFill();
          stroke(0, 0, 0);
          strokeWeight(3);
          rect(0, 0, width, height);
        }
        popMatrix();
        if (show_data) {
          String label = "" + i + ":" + genes[i].active_length;
          drawLabel( label, 5, 15 );
        }
        popMatrix();
      }
    }

    // draw grid overlay
    if (false) {
      stroke( 0 );
      strokeWeight( 8 );
      for (int y = 0; y < 3; y++) {
        line( 0, y*height/3, width, y*height/3);
      }
      for (int x = 0; x < 3; x++) {
        line( x*width/3, 0, x*width/3, height);
      }
    }

    changed = false;
  }
}

void mousePressed() {
  changed = true;

  // which square got clicked on?
  int x = mouseX / (width/3);
  int y = mouseY / (height/3);
  int target = y * 3 + x;

  // copy target to everything else
  for (int i=0; i<9; i++) {
    if (i != target) {
      genes[i].copy( genes[ target ] );
      genes[i].mutate(0.09);
    }
  }
}

void keyTyped() {
  changed = true;

  switch (key) {
  case ' ':  
    // randomize every gene
    for (int i=0; i<9; i++) {
      genes[i].randomize();
    }
    break;
  case 'a':
    newDefaultGenes();
    break;
  case 'b':
    newBlobGenes();
    break;
  case 'c':
    newLineGenes();
    break;
  case 'd':
    newColorBlobGenes();
    break;
  case 'z':
    show_data = !show_data;
    break;
  }
}

