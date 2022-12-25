class Sphere {
  float x;
  float y;
  float z;
  float larg;
  float alpha;
  PShape ball;

  Sphere(float x, float y, float z, float alpha) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.alpha = alpha;
    //ball.setTexture(black);
  }

  void draw() {
    pushMatrix();
    stroke(255-alpha);
    strokeWeight(2);
    translate(x, y, z);
    sphere(5);
    popMatrix();
  }
}
