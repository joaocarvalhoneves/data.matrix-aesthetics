class Beat {
    constructor(x, y, type) {
        let options1 = {
            density: 0.1,
            stiffness: 0.4,
            friction: 0.3,
            restitution: 0.3,
            frictionAir: 0
        }
        this.x = x;
        this.y = y;
        this.type = type;
        this.r = 36;
        /*
                if (type == 1)
                    this.body = Bodies.circle(this.x, this.y, this.r * 0.7, options1);
                else if (type == 2)
                    this.body = Bodies.polygon(this.x, this.y, 3, this.r * 0.95, options1);
                else if (type == 3)
                */
        this.body = Bodies.rectangle(this.x, this.y, this.r * 1.35, this.r * 1.35, options1);
        /* else if (type == 4)
            this.body = Bodies.polygon(this.x, this.y, 5, this.r * 0.95, options1);
*/
        Composite.add(world, this.body);
    }


    draw() {
        let pos;
        let angle;

        pos = this.body.position;
        angle = this.body.angle;

        push();
        translate(pos.x, pos.y);
        rotate(angle);
        strokeWeight(1.5);
        
                noFill(0);
                stroke(0);
                if (this.type == 1) {
                    ellipse(0, 0, this.r, this.r);

                } else if (this.type == 2) {
                    push();
                    rotate(-PI);
                    triangle(this.r * 0.65, 0, cos(2 * PI / 3) * this.r * 0.65, sin(2 * PI / 3) * this.r * 0.65, cos(2 * PI / 3 + 2 * PI / 3) * this.r * 0.65, sin(2 * PI / 3 + 2 * PI / 3) * this.r * 0.65);
                    pop();
                } else if (this.type == 3) {
                    rectMode(CENTER);
                    rect(0, 0, this.r, this.r, 2);
                } else if (this.type == 4) {
                    beginShape();
                    for (let i = 0; i < 5; i++) {
                        vertex(this.r * 0.65 * cos(i * (TWO_PI / 5)), this.r * 0.65 * sin(i * TWO_PI / 5));
                    }
                    endShape(CLOSE);
                }
                /*

        if (this.type >= 2) {
            stroke(0);
            noFill();

        } else {
            noStroke();
            fill(0);
        }
        
        rectMode(CENTER);
        rect(0, 0, this.r, this.r, 2);
*/

        pop();
    }
}