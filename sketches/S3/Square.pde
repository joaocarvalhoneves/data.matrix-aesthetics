class Square {
  float x;
  float y;
  float w;
  float s;
  float rotation;
  float which;

  Square(float x, float y, float w) {
    this.x = x;
    this.y = y;
    this.w = w;
    float rot = random(1);

    if (rot < 0.25)
      rotation = PI/2;
    else if (rot < 0.5)
      rotation = PI;
    else if (rot < 0.75)
      rotation = (3*PI/2);
    which = random(1);
  }

  void draw() {
    fill(0);
    pushMatrix();
    translate(x, y);
    rotate(rotation);
    if(w > 6.8)
    rect(0, 0, 13, 13);
    else if (w > 5.5) {
      if (which > 0.5)
        image(img3, 0, 0, 13.2, 13.2);
      else  image(img4, 0, 0, 13.2, 13.2);
    } else if (w > 3.5)
      image(img2, 0, 0, 13.2, 13.2);
    else if (w > 1.5)
      image(img1, 0, 0, 13.2, 13.2);
    popMatrix();
  }
}
