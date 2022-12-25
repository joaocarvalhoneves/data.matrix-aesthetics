class Rect{

  float x;
  float y;
  float l;
  float a;
  float area;

  Rect(float x, float y, float l, float a) {
    this.x = x;
    this.y = y;
    this.l = l;
    this.a = a;
    this.area = l*a;
  }

  void draw() {
    fill(255);
    strokeWeight(0.5);
    rect(x, y, l, a);
  }

  public String toString() {
    return "Area: " + area;
  }
}

class RectCompare implements Comparator<Rect> {

  public int compare(Rect ind1, Rect ind2) {
    if (ind1.area < ind2.area)
      return 1;
    if (ind1.area > ind2.area)
      return -1;
    return 0;
  }
}
