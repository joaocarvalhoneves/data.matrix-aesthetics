var w = 553;
var h = 645;
let dm;
let fft;
let peakDetect;
var Engine = Matter.Engine,
    Composite = Matter.Composite,
    Bodies = Matter.Bodies,
    Constraint = Matter.Constraint,
    Vertices = Matter.Vertices,
    World = Matter.World,
    Common = Matter.Common;
var engine;
var world;
var b = [];
var counter = 0;
var counter2 = 0;
var lengths = [];
var pdf;

function preload() {
    dm = loadSound('assets/dm.mp3');
}

function setup() {

    createCanvas(w * 3, h * 3, P2D);
    pixelDensity(2);
    engine = Engine.create();
    world = engine.world;
    engine.gravity.y = 1;
    fft = new p5.FFT();
    peakDetect = new p5.peakDetect();
    pdf = createPDF();
    pdf.beginRecord();

    // WALLS
    World.add(world, [
        Bodies.rectangle((w * 3) / 2, (h * 3) - 5, (w * 3), 10, {
            isStatic: true,
        }),
        Bodies.rectangle(0, (h * 3) / 2, 6, (h * 3), {
            isStatic: true,
        }),
        Bodies.rectangle((w * 3), (h * 3) / 2, 6, (h * 3), {
            isStatic: true,
        }),
    ]);

}

function draw() {
    Engine.update(engine);
    background(255);
    fft.analyze();
    peakDetect.update(fft);
    let spectrum = fft.analyze();


    for (let i = 0; i < b.length; i++) {
        b[i].draw();
    }


    if (peakDetect.energy > 0.135 && counter == 0) {
        counter++;
        let highest = 0
        let saveI = 0;
        for (let i = spectrum.length - 1; i >= 0 ; i--) {
            if (highest < spectrum[i] - lengths[i]) {
                highest = spectrum[i] - lengths[i];
                saveI = i;
            }
        }
        let type = 0;
        if (saveI < 70) type = 1;
        else if(saveI < 200) type = 2; else type = 3;
        console.log(saveI);
        b.push(new Beat(width / 2, 0, type));
    }
    if (dm.currentTime() > 0 && dm.currentTime() < 1) {
        for (let i = 0; i < spectrum.length; i++) {
            lengths[i] = spectrum[i];
        }
    } else {
        for (let i = 0; i < spectrum.length; i++) {
            //rect(i*2, height - (spectrum[i]-lengths[i]),2, spectrum[i]-lengths[i])
        }
    }

    if (counter > 0) counter2++;
    if (counter2 > 40) {
        counter = 0;
        counter2 = 0;
    }
}

function keyPressed() {
    dm.play();
}

function mousePressed() {
    noLoop();
    pdf.save();
}