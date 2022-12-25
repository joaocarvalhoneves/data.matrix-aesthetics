class Line {
  float x;
  float f [] = new float [6];

  Line(float x, float [] f) {
    this.x = x;
    this.f = f;
  }

  void draw() {
    strokeWeight(0.5);
    rectMode(CENTER);
    stroke(0);
    pushMatrix();
    translate(x, 0);
    for(int i = 0; i < 6; i++){
    strokeWeight(f[i]);
    line(0, (height/6) * i, 0, ((height/6) * i) + height/6);
    }
    popMatrix();
  }
}
  
  
