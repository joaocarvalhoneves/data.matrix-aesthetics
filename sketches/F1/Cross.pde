class Line {
  float x;
  float f [] = new float [6];

  Line(float x, float [] f) {
    this.x = x;
    this.f = f;
  }

  void draw() {
    
    stroke(0);
    pushMatrix();
    translate(x, 0);
    for(int i = 0; i < dm.bufferSize(); i++){;
    strokeWeight(f[i]);
    line(0, 0.63 * i, 0, (0.63 * i) + (0.63 * i));

    }
    popMatrix();
  }
}
  
  
