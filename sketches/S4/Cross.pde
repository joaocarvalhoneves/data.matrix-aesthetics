class Line {
  float x;
  float y;
  float w;
  float s;

  Line(float y, float w) {
    this.y = y;
    this.w = w;
  }

  void draw() {
    strokeWeight(w);
    line(0, y, width, y);
  }
  
}
