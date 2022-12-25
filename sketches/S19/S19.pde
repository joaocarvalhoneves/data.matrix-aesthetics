float rotacaoHorizontalAtual;
float rotacaoVerticalAtual;
float dragHorizontalAtual;
float dragVerticalAtual;
float ratoX;
float ratoY;
float rotacao;
float rotacaoH          = PI/3;
float rotacaoV          = PI/2;
float zoom              = PI/2;
float newZoom           = PI;
float centroX           = 0;
float centroY           = 0;
boolean drag;
boolean dragTrigger;
boolean rotacaoTrigger;
boolean view            = false;
boolean focus           = false;
ArrayList <Sphere> s = new ArrayList <Sphere> ();
int larg = 100;
PImage black;
String loadString [];
  int num = 0;

void setup() {
  size(1200, 1200, P3D);  pixelDensity(2);
  smooth(8);
  pixelDensity(2);
  loadString = loadStrings("amp.txt");

  for (int i = 4; i >= 0; i--) {
    for (int j = 4; j >= 0; j--) {
      for (int k = 0; k < 5; k++) {
        float amp = float(loadString[num]);
        num++;
        s.add(new Sphere(k*larg, i*larg, j*larg, amp));  
      }
    }
  }
}

void draw() {
  background(255);
  if (!view)
    perspective(zoom+(PI/24*newZoom), 1.0, 0.1, 10000);
  else ortho(- 1.3 * map(newZoom, -TWO_PI, TWO_PI, 100, 800), 1.3 * map(newZoom, -TWO_PI, TWO_PI, 100, 800), - map(newZoom, -TWO_PI, TWO_PI, 100, 800), map(newZoom, -TWO_PI, TWO_PI, 100, 800));

  if (!focus)
    camera(centroX+((width)*cos(rotacaoH)), centroY+((height)*sin(rotacaoH)), 400 + rotacaoV, centroX, centroY, 0, 0, 0, -1);
  else   camera(centroX+((width)*cos(rotacaoH)), centroY+((height)*sin(rotacaoH)), 400 + rotacaoV, 200, 80, 170, 0, 0, -1);


  if (newZoom >= TWO_PI) {
    newZoom = TWO_PI;
  } else {
    if (newZoom <= -TWO_PI)
      newZoom = -TWO_PI;
  }

  if (rotacaoTrigger) {
    rotacaoH = map((rotacaoHorizontalAtual + mouseX - ratoX), -800, 800, -PI, PI);
    rotacaoV = map((rotacaoVerticalAtual + mouseY - ratoY), -800, 800, -2000, 2000);
  } else {
    rotacaoHorizontalAtual = map(rotacaoH, -PI, PI, -800, 800);
    rotacaoVerticalAtual = map(rotacaoV, -2000, 2000, -800, 800);
  }

  if (dragTrigger) {
    centroX = dragHorizontalAtual + mouseX - ratoX;
    centroY = dragVerticalAtual + mouseY - ratoY;
  } else {
    dragHorizontalAtual = centroX;
    dragVerticalAtual = centroY;
  }

  for (int i = 0; i < s.size(); i++) {
    s.get(i).draw();
  }

  //Eixos();
  int larg = 100;
  for (int i = 0; i < 5; i++) {
    for (int j = 0; j < 5; j++) {
      for (int k = 0; k < 5; k++) {
        strokeWeight(0.3);
        stroke(200);
        if (i < 4)
          line(i*larg, j*larg, k*larg, (i+1)*larg, j*larg, k*larg);
        if (j < 4)
          line(i*larg, j*larg, k*larg, i*larg, (j+1)*larg, k*larg);
        if (k < 4)
          line(i*larg, j*larg, k*larg, i*larg, j*larg, (k+1)*larg);
      }
    }
  }
}

void mousePressed() {
  ratoX = mouseX;
  ratoY = mouseY;
}

void mouseDragged() {
  if ((mouseX != pmouseX || mouseY != pmouseY) && !drag)
    rotacaoTrigger = true;
  if ((mouseX != pmouseX || mouseY != pmouseY) && drag) {
    dragTrigger = true;
  }
}

void mouseReleased() {
  rotacaoTrigger = false;
  dragTrigger = false;
}

void mouseWheel(MouseEvent event) {

  //////////////////// ZOOM ////////////////////

  if (zoom <= TWO_PI && zoom >= -TWO_PI) {
    newZoom+=event.getCount();
  }
}

void keyPressed() {
num++;
  if (keyCode==ALT)
    drag = true;

  if (key == 'R' || key == 'r') {
    centroX = 0;
    centroY = 0;
    newZoom = PI;
    rotacaoH = PI/3;
    rotacaoV = 0;
    focus = false;
  }

  if (key == 'F' || key == 'f') {
    focus = !focus;
  }
  if (key == 'V' || key == 'v') {
    view = !view;
  }
  
  if(key == 'S')
  save("OUTPUT.TIFF");
}

void keyReleased() {
  drag = false;
}
