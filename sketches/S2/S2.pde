import processing.sound.*;
import processing.pdf.*;

Waveform waveform;
SoundFile dm;
boolean record;
int counter = 0;
float y = 0;
int num = 0;
int samples = 300;
float total = 0;
float a [] = new float [4000];
float b [] = new float [4000];
String save [] = new String [3000];
ArrayList <PVector> matrix = new ArrayList<PVector>();
ArrayList <PVector> newmatrix = new ArrayList<PVector>();
String load [];

void setup() {
  size(553, 645);
  /*
  waveform = new Waveform(this, samples);
   dm = new SoundFile(this, "dm.mp3");
   dm.play();
   waveform.input(dm);
   */
  for (int j = 0; j < 49; j++) {
    for (int i = 0; i < 42; i++) {
      matrix.add(new PVector(6+i*13.2, 6+j*13.2));
    }
  }
  rectMode(CENTER);

  load = loadStrings("l.txt");
  for (int i = 0; i < load.length; i++) {
    String o [] = split(load[i], ',');
    println(o.length);
    println(o[0], o[1]);
    newmatrix.add(new PVector(float(o[0]), float(o[1])));
  }
}

void draw() {
  //waveform.analyze();
  if (record) {
    beginRecord(PDF, "frame-####.pdf");
  }
  background(255);
  counter++;
  
   /*
   if (counter > 16) {
   for (int i = 0; i < samples; i++) {
   total+= waveform.data[i];
   }
   total/=samples;
   save[num] = "" + (matrix.get(num).x) + "," + (matrix.get(num).y + total*50);
   a[num]= matrix.get(num).x;
   b[num] = matrix.get(num).y + total*50;
   num++;
   counter = 0;
     saveStrings("a.txt", save);
   }
   */

   for(int i = 0; i < 49; i++){
   beginShape();
   for (int j = 0; j < 42; j++) {
   curveVertex(newmatrix.get(42*i+j).x, newmatrix.get(42*i+j).y);
   }
  endShape();
  }

  if (record) {
    endRecord();
    record = false;
  }
}

void mousePressed() {
  record = true;
}
