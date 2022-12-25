class Cross {
  float x;
  float y;
  float w;
  float s;

  Cross(float x, float y, float w) {
    this.x = x;
    this.y = y;
    this.w = w;
    //s = 10;
    s = 6;
  }

  void eDraw() {
    fill(0);
    noStroke();
    pushMatrix();
    translate(x, y);
    rotate(PI/4);
    ellipse(0, 0, s, s);
    fill(255);
    ellipse(0, 0, s-w, s-w);
    popMatrix();
  }

  void xDraw() {
    strokeWeight(w);
    stroke(0);
    pushMatrix();
    translate(x, y);
    rotate(PI/4);
    line(-1*s, 0, 1*s, 0);
    line(0, -1*s, 0, 1*s);
    popMatrix();
  }
    void pDraw() {
    fill(0);
    noStroke();
    pushMatrix();
    translate(x, y);
    ellipse(0, 0, w, w);
    popMatrix();
  }
  
    void tDraw() {
    strokeWeight(1);
    stroke(0);
    pushMatrix();
    translate(x, y);
    rotate(-PI/4 + w);
    line(-1*s, 0, 0, 0);
    line(0, 0, 0, 1*s);
    popMatrix();
  }
}
