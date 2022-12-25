class Clock {
  float x;
  float y;
  float w;
  float s;

  Clock(float x, float y, float w) {
    this.x = x;
    this.y = y;
    this.w = w;
    s = 10;
    //s = 6;
  }

  void draw() {
    strokeWeight(0.5);
    rectMode(CENTER);
    stroke(0);
    pushMatrix();
    translate(x, y);
    rect(0, 0, s, s);
    strokeWeight(1);
    line(0, 0, s/2*cos(w), s/2*sin(w));
    popMatrix();
  }
}
