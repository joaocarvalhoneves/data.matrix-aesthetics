import ddf.minim.analysis.*;
import ddf.minim.*;
import processing.pdf.*;

Minim minim;
AudioPlayer dm;
FFT fft;
boolean record;
float band [];
float maxvalues [];
String loadMax [];
String saveMax [];
float counter = 0;
float ang = 0;
float maxvalue = 0;

void setup() {
  background(255);
  size(553, 645);

  beginRecord(PDF, "every.pdf");

  minim = new Minim(this);
  dm = minim.loadFile("dm.mp3", 2048);
  dm.play();
  fft = new FFT(dm.bufferSize(), dm.sampleRate());
  loadMax = loadStrings("max502bands-201frame.txt");
  band = new float [502];
  maxvalues = new float [502];
  saveMax = new String [502];

  for (int i = 0; i < band.length; i++) {
    band[i] = 0;
    maxvalues[i] = 0;
  }
}

void draw() {
  counter++;
  fft.forward(dm.mix);

  for (int i = 0; i < band.length; i++) {
    //if (fft.indexToFreq(i) > 4000)
    //println(i);
    band[i]+= fft.getBand(i);
  }

  // GET MAX FOR EACH SPEC SIZE
  if (counter > 201) {
    for (int i = 0; i < band.length; i++) {
      //maxvalues[i] = max(band[i], maxvalues[i]);
      // saveMax[i] = "" + maxvalues[i];
      // println(maxvalues[i], band[i]);
      // stroke(map(band[i], 0, float(loadMax[i]), 200, 0));
      strokeWeight(1);
      stroke(0);
      strokeWeight(map(band[i], 0, float(loadMax[i]), 0.2, 1));
        // AVERAGE FOR GAP
        //   band[i]/= 201;
        // if(maxvalue < band[i]) maxvalue = band[i];
        // stroke(map(band[i], 0, 170.825, 200, 0));

        line(width/2 + ((band.length - i+1-0.5))*cos(ang-PI/2),
        height/2 + ((band.length - i+1-0.5))*sin(ang-PI/2),
        width/2 + ((band.length - i+1-0.5))*cos(ang+radians(2)-PI/2),
        height/2 + ((band.length - i+1-0.5))*sin(ang+radians(2) - PI/2));
    }
    // saveStrings("max502bands-201frame.txt", saveMax);
    ang+= radians(2);
    counter = 0;
    for (int i = 0; i < band.length; i++) {
      band[i] = 0;
    }
  }
}

void keyPressed() {
  if (key == 'q') {
    endRecord();
    exit();
  }
}
