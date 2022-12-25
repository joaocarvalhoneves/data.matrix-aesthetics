import processing.pdf.*;
import ddf.minim.analysis.*;
import ddf.minim.*;
Minim minim;
AudioPlayer dm;
FFT fft;
float r1 = 100;
float r2 = 100;
float m1 = 10;
float m2 = 10;
float a1 = PI/2;
float a2 = PI/2;
float a1_v = 0;
float a2_v = 0;
float a1_a = 0;
float a2_a = 0;
float g = 1;
int counter = 0;
PGraphics canvas;
boolean record = false;
ArrayList <PVector> p = new ArrayList <PVector>();
StringList coords = new StringList ();
String saveString [];

void setup() {
  size(553, 645);
  //size(2212, 2580);

  minim = new Minim(this);
  dm = minim.loadFile("dm.mp3", 1024);
  fft = new FFT(dm.bufferSize(), dm.sampleRate() );
  dm.play();
  background(255);
}

void draw() {
  counter++;
  fft.forward(dm.mix);
  float amp = 0;
  for (int i = 0; i < dm.bufferSize(); i++) {
    amp+= fft.getBand(i);
  }


  m1 = map(amp, 0, 255, 20, 40);
  amp = 0;
  background(255);

  float x1 = r1 * sin(a1);
  float y1 = r1 * cos(a1);
  float x2 = x1 + r2 * sin(a2);
  float y2 = y1 + r2 * cos(a2);

  float num1 = -g * (2 * m1 + m2) * sin(a1);
  float num2 = -m2 * g * sin(a1 - 2 * a2);
  float num3 = -2 * sin(a1 - a2) * m2;
  float num4 = a2_v * a2_v * r2 + a1_v * a1_v * r1 * cos(a1 - a2);
  float num5 = r1 * (2 * m1 + m2 - m2 * cos(2 * a1 - 2 * a2));

  a1_a = (num1 + num2 + num3 * num4) / num5;

  num1 = 2 * sin(a1 - a2);
  num2 = (a1_v * a1_v * r1 * (m1 + m2));
  num3 = g * (m1 + m2) * cos(a1);
  num4 = a2_v * a2_v * r2 * m2 * cos(a1-a2);
  num5 = r2 * (2 * m1 + m2 - m2 * cos(2 * a1 - 2 * a2));

  a2_a = (num1 * (num2 + num3 + num4)) / num5;

  a1_v += a1_a;
  a2_v += a2_a;
  a1 += a1_v;
  a2 += a2_v;


  pushMatrix();
  translate(width/2, height/2 -50);
  fill(0);
  line(0, 0, x1, y1);
  ellipse(x1, y1, m1, m1);
  line(x1, y1, x2, y2);
  ellipse(x2, y2, m2, m2);
  popMatrix();
  
  /*
  for (int i = 0; i < p.size()-1; i++) {
   line(p.get(i).x, p.get(i).y, p.get(i+1).x, p.get(i+1).y);
   coords.append("" + p.get(i).x + "," + p.get(i).y);
   }
   */

  if (record) {
    beginRecord(PDF, "frame-####.pdf");
  }

  translate(width/2, height/2 - 50);

  strokeWeight(1);
  noFill();
  stroke(0, 40);

  for (int i = 0; i < p.size()-4; i++) {
    beginShape();
    for (int j = 0; j < 4; j++) {
      curveVertex(p.get(i+j).x, p.get(i+j).y);
    }
    endShape();
  }

  p.add(new PVector(x2, y2));

  if (record) {
    endRecord();
    record = false;
    p.clear();
  }
  if (p.size() > 0)
    println(p.get(0).x);
}

void mousePressed(){
  record = true;
}
