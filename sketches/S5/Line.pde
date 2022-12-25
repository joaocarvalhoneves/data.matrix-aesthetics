class Line {
  float x;
  float y;
  float w;

  Line(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void draw() {
    line(x,y-6, x, y+6);
  }
}
