class Cross {
  float x;
  float y;
  float w;
  float s;
  float f1;
  float f2;
  float f3;
  float f4;

  Cross(float x, float y, float f1, float f2, float f3, float f4) {
    this.x = x;
    this.y = y;
    this.f1 = f1;
    this.f2 = f2;
    this.f3 = f3;
    this.f4 = f4;
    s = 7;
  }

  void draw() {
    strokeWeight(0.5);
    rectMode(CENTER);
    stroke(0);
    pushMatrix();
    translate(x, y);
    // BASS
    strokeWeight(f1);
    line((s/2.5)*cos(PI+PI/4), (s/2.5)*sin(PI+PI/4), s*cos(PI+PI/4), s*sin(PI+PI/4));
    // MED 1
    strokeWeight(f2);
    line((s/2.5)*cos(-PI/4), (s/2.5)*sin(-PI/4), s*cos(-PI/4), s*sin(-PI/4));
    // MED 2
    strokeWeight(f3);
    line((s/2.5)*cos(PI/4), (s/2.5)*sin(PI/4), s*cos(PI/4), s*sin(PI/4));
    // HIGH
    strokeWeight(f4);
    line((s/2.5)*cos(PI-PI/4), (s/2.5)*sin(PI-PI/4), s*cos(PI-PI/4), s*sin(PI-PI/4));
    popMatrix();
  }
}
