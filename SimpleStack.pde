int MAX_STACK_DEPTH = 256;
class SimpleStack {
    
    float[] stack = new float[MAX_STACK_DEPTH];
    int sp = 0;
    
    SimpleStack() {
      reset();
    }
    
    void reset() {
      for (int i=0; i<MAX_STACK_DEPTH; i++) {
        stack[i] = 0;
      }
      sp = 0;
    }
    
    void push( float val ) {
      if (sp < MAX_STACK_DEPTH-1) {
        sp++;
      }
      stack[sp] = val;  // overwrites last value when stack is full
    }
    
    float pop( ) {
      if (sp > 0) {
        sp--;
      }
      return stack[sp];
    }
}
