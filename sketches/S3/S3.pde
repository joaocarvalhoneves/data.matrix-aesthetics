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
ArrayList<Square> s = new ArrayList<Square>();
ArrayList <PVector> matrix = new ArrayList<PVector>();
PImage img1;
PImage img2;
PImage img3;
PImage img4;
PFont akk;

void setup() {
  size(553, 645);
  img1 = loadImage("img1.png");
  img2 = loadImage("img2.png");
  img3 = loadImage("img3.png");
  img4 = loadImage("img4.png");
  akk = createFont("akk.otf", 9);
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
  imageMode(CENTER);
}

void draw() {
  if (record) {
    beginRecord(PDF, "frame-####.pdf");
  }
  background(255);
  counter++;

  vol+=amp.analyze();
  if (counter > 16) {
    if (s.size() < 2254) {
      if (maxamp < vol) maxamp = vol;
      s.add(new Square(matrix.get(num).x, matrix.get(num).y, vol));
    }
    if (num+1 < matrix.size())
      num++;

    counter = 0;
    vol = 0;
  }

  if (record) {
    pushMatrix();
    translate(0, height);
    rotate(-PI/2);
    textFont(akk);
    textSize(8);
    fill(0);
    for (int i = 0; i < 70; i++) {
      String a = "";
      while (textWidth(a) < height + 40) {
        float rand = random(1);
        if (rand < 0.5)
          a+="data.matrix ";
        else if (rand < 0.7)
          a+="music is beautiful because you can't see it. ";
        else if (rand < 0.9)
          a+="space time infinity nature. ";
        else if (rand < 1)
          a+="your experience";
      }
      text(a, random(-40, 0), i*8);
    }
    popMatrix();
  }

  for (int i = 0; i < s.size(); i++) {
    s.get(i).draw();
  }

  if (record) {
    endRecord();
    record = false;
    s.clear();
  }

  if (s.size() == matrix.size())
    record = true;
}

void mousePressed() {
  record = true;
}
