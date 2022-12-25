class Cross {
  float x;
  float y;
  float w;
  float s;
  int num;

  Cross(float x, float y, int num) {
    this.x = x;
    this.y = y;
    this.num = num;
    s = 2;
  }

  void draw() {
    strokeWeight(0.5);
    rectMode(CENTER);
    noFill();
    noStroke();
    pushMatrix();
    translate(x, y);
    if (num == 0)
      fill(0); else noFill();
    ellipse(0, -3, 5, 5);
    if (num == 1)
      fill(0);  else noFill();
    ellipse(0, -1, 5, 5);
    if (num == 2)
      fill(0);  else noFill();
    ellipse(0, 1, 5, 5);
    if (num == 3)
      fill(0);  else noFill();
    ellipse(0, 3, 5, 5);
    popMatrix();
  }
}
