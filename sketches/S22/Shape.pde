class Shape {
  String [] values;
  float ang = TWO_PI/6;
  int [] valuesInt;
  int a = 1;

  Shape(String [] values) {
    this.values = values;
    valuesInt = new int [values.length];
    for (int i = 0; i < values.length; i++) {
      valuesInt[i] = int(map(int(values[i]), 0, 255, 100, 545));
    }
  }

  Shape(int [] values, int a) {
    this.valuesInt = values;
    this.a = a;
  }

  void draw() {
    pushMatrix();
   // translate(width/2-100, height/2+132);
   translate(width/2, height/2);
    if(a == 1)
    stroke(0); else stroke(255,0,0);
    strokeWeight(0.5);
    noFill();
    beginShape();

    for (int i = 0; i < 6; i++) {
      curveVertex(valuesInt[i] * cos(ang * i), valuesInt[i] * sin(ang * i)) ;
    }
    for (int i = 0; i < 6; i++) {
      curveVertex(valuesInt[i] * cos(ang * i), valuesInt[i] * sin(ang * i)) ;
    }

    endShape();
    popMatrix();
  }
}
