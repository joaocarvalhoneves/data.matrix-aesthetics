class FlowField {
  PVector[][] field;
  int resolutionX;
  int resolutionY;

  FlowField() {
    resolutionX = int((width)/21);
    resolutionY = int((height)/25);
    field = new PVector[21][25];
    init();
  }

  void init() {
    int num = 0;
    for (int j = 0; j < 25; j++) {
      for (int i = 0; i < 21; i++) {
        field[i][j] = new PVector(coords.get(num).x + 14, coords.get(num).y + 10);
        field[i][j].normalize();
        field[i][j] = PVector.fromAngle(ang.get(num) - PI/4);
        field[i][j].normalize();
        num++;
      }
    }
  }

  // Draw every vector
  void display() {
    for (int j = 0; j < 25; j++) {
      for (int i = 0; i < 21; i++) {
        drawVector(field[i][j], i*resolutionX + 14, j*resolutionY + 10, 15);
      }
    }
  }

  void drawVector(PVector v, float x, float y, float scayl) {
    pushMatrix();
    translate(x, y);
    rotate(v.heading());
    float len = v.mag()*scayl;
    stroke(0);
    line(-0.1*len, 0, 0.1*len, 0);
    line(0, 0, len, 0);
    popMatrix();
  }

  PVector lookup(PVector lookup) {
    int column = int(constrain(lookup.x/resolutionX, 0, 21-1));
    int row = int(constrain(lookup.y/resolutionY, 0, 25-1));
    return field[column][row].copy();
  }
}
