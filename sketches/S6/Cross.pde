class Rect {
  float x;
  float y;
  float w;

  Rect(float x, float y, float w) {
    this.x = x;
    this.y = y;
    this.w = w;
  }

  void draw() {
    noStroke();
    fill(0);
    rectMode(CORNER);
    rect(x,y, 9, w);
  }
}
