import ddf.minim.analysis.*;
import ddf.minim.*;
import processing.pdf.*;

Minim minim;
AudioPlayer dm;
FFT fft;
ArrayList <Line> l = new ArrayList<Line>();
boolean record;
int values [] = {125, 250, 500, 1000, 2000, 20000};
float band [] = new float [6];
float maxvalues [] = new float [6];
String saveMax [] = new String [6];
String loadMax [];
float counter = 0;
int num = 0;

void setup()
{
  size(553, 645);
  minim = new Minim(this);
  dm = minim.loadFile("dm.mp3", 1024);
  dm.play();
  fft = new FFT(dm.bufferSize(), dm.sampleRate() );
  rectMode(CENTER);
  stroke(0);
  loadMax = loadStrings("max6-325frame.txt");

  for (int i = 0; i < band.length; i++) {
    band[i] = 0;
    maxvalues[i] = 0;
  }
}

void draw() {
  counter++;
  background(255);
  if (counter > 325)
    record = true;

  if (record) {
    beginRecord(PDF, "frame-####.pdf");
  }
  fft.forward(dm.mix);

  // GET MAX FOR EACH SPEC SIZE
  for (int i = 0; i < fft.specSize(); i++) {
    if (fft.indexToFreq(i) < values[0]) {
      band[0]+=fft.getBand(i);
    } else  if (fft.indexToFreq(i) < values[1]) {
      band[1]+=fft.getBand(i);
    } else  if (fft.indexToFreq(i) < values[2]) {
      band[2]+=fft.getBand(i);
    } else if (fft.indexToFreq(i) < values[3]) {
      band[3]+=fft.getBand(i);
    } else if (fft.indexToFreq(i) < values[4]) {
      band[4]+=fft.getBand(i);
    } else {
      band[5]+=fft.getBand(i);
    }
  }

  if (counter > 325) {
    float f [] = new float [band.length];
    for (int i = 0; i < band.length; i++) {
      // maxvalues[i] = max(band[i], maxvalues[i]);
      //saveMax[i] = "" + maxvalues[i];
      f[i] = map(band[i], 0, float(loadMax[i]), 0.5, 3.7);
    }

    l.add(new Line(num*4, f));
    num++;
    //saveStrings("max6-325frame.txt", saveMax);

    for (int i = 0; i < band.length; i++) {
      band[i] = 0;
    }
    // println(maxvalues[0], maxvalues[1], maxvalues[2], maxvalues[3]);
    counter = 0;
  }

  for (int i = 0; i < l.size(); i++) {
    l.get(i).draw();
  }


  if (record) {
    endRecord();
    record = false;
  }
}

void mousePressed() {
  record = true;
}
