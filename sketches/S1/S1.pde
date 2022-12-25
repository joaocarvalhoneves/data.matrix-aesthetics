import processing.sound.*;
import processing.pdf.*;

Amplitude amp;
SoundFile dm;
boolean record;
float vol = 0;
int counter = 0;
float maxv = 0;
float minv = 50;
float y = 0;
int num = 0;
float med = 0;
float maxamp = 0;
ArrayList<Cross> c = new ArrayList<Cross>();
ArrayList <PVector> matrix = new ArrayList<PVector>();

void setup() {
  size(553, 645);

  amp = new Amplitude(this);
  dm = new SoundFile(this, "dm.mp3");
  dm.play();
  amp.input(dm);

  for (int j = 0; j < 49; j++) {
    for (int i = 0; i < 42; i++) {
      matrix.add(new PVector(6+i*13.2, 6+j*13.2));
    }
  }
  rectMode(CENTER);
}

void draw() {
  if (record) {
    beginRecord(PDF, "frame-####.pdf");
  }
  background(255);
  counter++;

  vol+=amp.analyze();
  if (counter > 16) {
    if (c.size() < 2254) {
      if (maxamp < vol) maxamp = vol;
      // 4 para cross (w)
      c.add(new Cross(matrix.get(num).x, matrix.get(num).y, map(vol, 0, 7.865969, 0, TWO_PI)));
    }
    if (num+1 < matrix.size())
      num++;

    counter = 0;
    vol = 0;
  }
  /* CHECK MATRIX
   for (int i = 0; i < matrix.size(); i++) {
   fill(255,0,0);
   textAlign(CENTER, CENTER);
   text(i/49, matrix.get(i).x, matrix.get(i).y);
   }
   */
  for (int i = 0; i < c.size(); i++) {
    c.get(i).tDraw();
  }

  if (record) {
    endRecord();
    record = false;
    c.clear();
  }

  if (c.size() == matrix.size())
    record = true;
}

void mousePressed() {
  record = true;
}
