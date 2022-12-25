import ddf.minim.analysis.*;
import ddf.minim.*;
import processing.pdf.*;

Minim minim;
AudioPlayer dm;
FFT fft;
ArrayList <PVector> matrix = new ArrayList<PVector>();
ArrayList <Circle> c = new ArrayList<Circle>();
boolean record;
int values [] = {250, 500, 1000};
float band [] = new float [4];
float maxvalues [] = new float [4];
String saveMax [] = new String [4];
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
  loadMax = loadStrings("max4-16frame.txt");

  for (int i = 0; i < band.length; i++) {
    band[i] = 0;
    maxvalues[i] = 0;
  }

  for (int j = 0; j < 49; j++) {
    for (int i = 0; i < 42; i++) {
      matrix.add(new PVector(6+i*13.2, 6+j*13.2));
    }
  }
}

void draw() {
  counter++;
  background(255);
  if (counter > 16 && c.size() > 2000)
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
    } else {
      band[3]+=fft.getBand(i);
    }
  }

  if (counter > 16) {
    float f [] = new float [band.length];
    for (int i = 0; i < band.length; i++) {
      maxvalues[i] = max(band[i], maxvalues[i]);
      //saveMax[i] = "" + maxvalues[i];
      f[i] = map(band[i], 0, float(loadMax[i]), 0, 1);
    }
    int which = 0;
    if (f[0] > f[1] && f[0] > f[2] && f[0] > f[3])
      which = 0;
    else  if (f[1] > f[0] && f[1] > f[2] && f[1] > f[3])
      which = 1;
    else  if (f[2] > f[0] && f[2] > f[1] && f[2] > f[3])
      which = 2;
    else  if (f[3] > f[0] && f[3] > f[1] && f[3] > f[2])
      which = 3;

    c.add(new Circle(matrix.get(num).x, matrix.get(num).y, which));
    num++;
    // saveStrings("max4-16frame.txt", saveMax);

    for (int i = 0; i < band.length; i++) {
      band[i] = 0;
    }
    println(maxvalues[0], maxvalues[1], maxvalues[2], maxvalues[3]);
    counter = 0;
  }

  for (int i = 0; i < c.size(); i++) {
    c.get(i).draw();
  }



  if (record) {
    endRecord();
    record = false;
  }
}

void mousePressed() {
  record = true;
}
