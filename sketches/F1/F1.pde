import ddf.minim.analysis.*;
import ddf.minim.*;
import processing.pdf.*;

Minim minim;
AudioPlayer dm;
FFT fft;
ArrayList <Line> l = new ArrayList<Line>();
boolean record;
int values [] = {125, 250, 500, 1000, 2000, 20000};
float band [];
float maxvalues [];
String saveMax [];
String loadMax [];
float results [][];
String loadResults [][];
String saveResults [][];
float counter = 0;
int num = 0;

void setup()
{
  size(553, 645);
  minim = new Minim(this);
  dm = minim.loadFile("dm.mp3", 1024);
  dm.play();
  fft = new FFT(dm.bufferSize(), dm.sampleRate() );
  band = new float[dm.bufferSize()];
  maxvalues = new float[dm.bufferSize()];
  saveMax = new String[dm.bufferSize()];
  results = new float[553][dm.bufferSize()];
  loadResults = new String [553][dm.bufferSize()];
  saveResults = new String[553][dm.bufferSize()];
  loadMax = loadStrings("maxall-allframe.txt");

  for (int i = 0; i < 553; i++) {
    loadResults[i] = loadStrings("output" + i + ".txt");
    for (int j = 0; j < 1024; j++) {
      results[i][j] = map(float(loadResults[i][j]), 0, float(loadMax[j]), 0.3, 0.8);
    }
    l.add(new Line(i, results[i]));
  }

  for (int i = 0; i < band.length; i++) {
    band[i] = 0;
    maxvalues[i] = 0;
  }
}

void draw() {
  counter++;
  background(255);

  if (record) {
    beginRecord(PDF, "frame-####.pdf");
  }
  
  /*
  fft.forward(dm.mix); 
   // GET MAX FOR EACH SPEC SIZE
   for (int i = 0; i < fft.specSize(); i++) {
   band[i]+=fft.getBand(i);
   }
   
   saveStrings("output" + num + ".txt", saveResults[num]);
   saveStrings("maxall-allframe.txt", saveMax);
   */
   
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
