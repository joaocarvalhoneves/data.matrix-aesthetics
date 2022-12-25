import processing.sound.*;
import processing.pdf.*;

Amplitude amp;
SoundFile dm;
boolean record;
float vol = 0;
int counter = 0;
float ang = 0;
ArrayList <PVector> matrix = new ArrayList<PVector>();

void setup() {
  size(553, 645);
  background(255);
  beginRecord(PDF, "frame-####.pdf");
  amp = new Amplitude(this);
  dm = new SoundFile(this, "dm.mp3");
  dm.play();
  amp.input(dm);
}

void draw() {
  counter++;
  vol+=amp.analyze();

  if (counter >= 100) {
    vol/= 100;
    stroke(0);
    println(vol);
    strokeWeight(map(vol, 0, 1, 0, 4));
    line(width/2, height/2, width/2 + 276*cos(-PI/2 + ang), height/2 + 276*sin(-PI/2 + ang));
    ang+=radians(1);
    counter = 0;
    vol = 0;
  }
}

void mousePressed() {
  endRecord();
  exit();
}
