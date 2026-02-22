///////////////////////////////////
//Jonathan Sherman
//11/8/2023
//////////////////////////////////
//importing pictures and sounds
import processing.sound.*;
AudioSample wallSound;
AudioSample song;
AudioSample score;
AudioSample recharge;
AudioSample secret;
PImage BG;
PImage ball;
PVector posL, posR, posB;

//boucing, speed and walls
boolean bounceR = false;
boolean bounceL = false;
boolean wallT = false;
boolean wallB = false;
float speedX = -6, speedY = -6;

//PowerUps
float powerR = 0;
float powerL = 0;
boolean powerX = false;
boolean powerY = false;
boolean powerWL = false;
boolean powerWR = false;
boolean powerRR = false;
boolean powerRL = false;
boolean powerGR = false;
boolean powerGL = false;
boolean powerBR = false;
boolean powerBL = false;
boolean powerYR = false;
boolean powerYL = false;

//controls
boolean o = false;
boolean l = false;
boolean w = false;
boolean s = false;

//button stuff
boolean startGame = false;
boolean options = false;

//Rackets
int RacketR;
int RacketL;
int sideL = 0;
int sideR = 0;
int visibility = 255;
int weight = 0;
int weightO = 0;
int weightW = 0;
int weightR = 0;
int weightG = 0;
int weightB = 0;
int weightY = 0;
int ballcolor = 255;

//Other Powerup stuff
float add = 0;
float add2 = 0;
String colours = "white";
String colours2 = "green";
int colour = color(0, 0, 0);
int colour2 = color(0, 0, 0);
boolean greenL = false;
boolean greenR = false;
boolean red = false;
boolean P1 = false;
boolean cheat = true;
boolean cheat2 = true;
boolean yellow = false;
void setup() {
  frameRate(300);
  fullScreen();
  BG = loadImage("Color.jpg");
  ball = loadImage("ball.png");
  song = new SoundFile(this, "Elevator-Music (nearly) 10 minutes.mp3");
  secret = new SoundFile(this, "Undertale - Megalovania.mp3");
  recharge = new SoundFile(this, "Gunshot Sound Effect Single Shot.mp3");
  wallSound = new SoundFile(this, "bounceEffect.mp3");
  score = new SoundFile(this, "Score.mp3");
  textSize(100);
  surface.setAlwaysOnTop(true);
  posL = new PVector(20, height/2 - 90);
  posR = new PVector(width - 40, height/2 );
  posB = new PVector(width/2, height/2);
  smooth();
  imageMode(CENTER);
  RacketR = height/5;
  RacketL = height/5;
  song.play();
}

void draw() {
  if (startGame == false) {
    menu();
  }
  if (options == true) {
    options();
  }
  if (startGame == true) {
    reDraw();
    game();
    powerup();
    leftPaddle();
    rightPaddle();
    rightOut();
    leftOut();
    wall();
    if (sideR == 7) {
      //End screen
      endScreenRight();
    } else if (sideL == 7) {
      endScreenLeft();
    }
  }
}
void menu() {
  //Main Menu
  tint(255, 255);
  image(BG, width/2, height/2, width, height);
  fill(255, 60);
  stroke(255, 50);
  strokeWeight(5);
  rect(width/2.8, height/2.2, 600, 100, 8);
  rect(width/2.8, height/1.57, 600, 100, 8);
  rect(width/4, 0, 1000, 450, 10);
  noStroke();
  strokeWeight(1);
  rect(width - 100, 0, 200, 40);
  fill(0);
  textSize(100);
  text("START", width/2.25, height/1.87);
  text("OPTIONS", width/2.39, height/1.4);
  textSize(30);
  text("EXIT", width -70, 25);
  textSize(300);
  fill(255, 0, 0);
  text('P', width/3.2, height/4);
  fill(0, 255, 0);
  text('O', width/3.2 + 160, height/4);
  fill(0, 0, 255);
  text('N', width/3.2 + 340, height/4);
  fill(255, 255, 0);
  text('G', width/3.2 + 520, height/4);
  textSize(100);
  text("COLOR BATTLES", width/3, height/2.7);
  if (options == false) {
    if (mousePressed) {
      if (mouseX >= width/2.8 && mouseX <= width/2.8 + 600 && mouseY >= height/2.2 && mouseY <= height/2.2 + 100) {
        startGame = true;
      }
      if (mouseX <= width && mouseX >= width - 100 && mouseY >= 0 && mouseY <= 40&& startGame == false) {
        exit();
      }
      if (mouseX >= width/2.8 && mouseX <= width/2.8 + 600 && mouseY >= height/1.57 && mouseY <= height/1.57 + 100) {
        options = true;
      }
    }
  }
}
void rightPaddle() {
  //right paddle
  if (posB.x >= posR.x - 20 && posB.y + 37 >= posR.y && posB.y <= posR.y + RacketR + 37 && !(posB.x > width - 30) && red == false && greenR == false) {
    posB.x = width - 70;
    speedX *= -1.1;
    powerR += 216;
    powerR += add;
    wallSound.play();
    yellow = false;
    ballcolor = 255;
  } else if (posB.x >= posR.x - 20 && posB.y + 37 >= posR.y && posB.y <= posR.y + RacketR + 37 && !(posB.x > width - 30) && red == true && greenR == false) {
    posB.x = width - 70;
    speedX *= -1.1;
    powerR += 216;
    powerR += add;
    wallSound.play();
    speedX /=2;
    red = false;
    yellow = false;
    ballcolor = 255;
  } else if (posB.x >= posR.x - 20 && posB.y >= posR.y - height && posB.y <= posR.y + height && !(posB.x > width - 30) && greenR == true && red == false) {
    posB.x = width - 70;
    speedX *= -1;
    greenR = false;
    yellow = false;
    ballcolor = 255;
  } else if (posB.x >= posR.x - 20 && posB.y >= posR.y - height && posB.y <= posR.y + height && !(posB.x > width - 30) && greenR == true && red == true) {
    posB.x = width - 70;
    speedX *= -1;
    greenR = false;
    speedX/=2;
    red = false;
    yellow = false;
    ballcolor = 255;
  }
}

void leftPaddle() {
  //left paddle
  if (posB.x <= posL.x + 40 && posB.y + 37 >= posL.y && posB.y <= posL.y + RacketL + 37 && !(posB.x < 30) && red == false && greenL == false) {
    posB.x = 70;
    speedX *= -1.1;
    powerL += 216;
    powerL += add2;
    wallSound.play();
    yellow = false;
    ballcolor = 255;
  } else if (posB.x <= posL.x + 40 && posB.y + 37 >= posL.y && posB.y <= posL.y + RacketL + 37 && !(posB.x < 30) && red == true && greenL == false) {
    posB.x = 70;
    speedX *= -1.1;
    powerL += 216;
    powerL += add2;
    wallSound.play();
    speedX /=2;
    red = false;
    yellow = false;
    ballcolor = 255;
  } else if (posB.x <= posL.x + 40 && posB.y >= posL.y - height && posB.y <= posL.y + height && !(posB.x < 30) && greenL == true && red == false) {
    posB.x = 70;
    speedX *= -1;
    greenL = false;
    yellow = false;
    ballcolor = 255;
  } else if (posB.x <= posL.x + 40 && posB.y >= posR.y - height && posB.y <= posL.y + height && !(posB.x < 30) && greenL == true && red == true) {
    posB.x = 70;
    speedX *= -1;
    greenL = false;
    speedX/=2;
    red = false;
    yellow = false;
    ballcolor = 255;
  }
}

void rightOut() {
  //Right gets a point
  if (posB.x >= width - 30 && !(posB.y >= posR.y) && !(posB.y <= posR.y - height/5)) {
    posB.x = 100;
    posB.y = height/2;
    speedX = random(6, 11);
    speedY = random(-6, 6);
    sideL +=1;
    score.play();
    yellow = false;
    ballcolor = 255;
    RacketR = height/5;
    RacketL = height/5;
  }
  if (speedY <= 5 && !(speedY <= -5)) {
    speedY = 6;
  }
}

void leftOut() {
  //Left gets a point
  if (posB.x <= 30 && !(posB.y >= posL.y) && !(posB.y <= posL.y - height/5)) {
    posB.x = width - 100;
    posB.y = height/2;
    speedX = random(-6, -11);
    speedY = random(-6, 6);
    sideR +=1;
    score.play();
    yellow = false;
    ballcolor = 255;
    RacketR = height/5;
    RacketL = height/5;
  }
  if (speedY <= 5 && !(speedY <= -5)) {
    speedY = 6;
  }
}

void endScreenRight() {
  //Right wins
  speedX = 0;
  speedY = 0;
  ballcolor = 0;
  fill(colour);
  text(colours + " wins", width/2-200, height/10);
  fill(0);
  text("Play again", width/2-200, height/2);
  text("Main Menu", width/2-200, height/1.1);
  textSize(30);
  text("exit", width -70, 25);
  //play again
  if (mousePressed) {
    if (mouseX >= width/2-200 && mouseX <= width/2 + 230 && mouseY <= height/2 && mouseY >= height/3) {
      startGame = false;
      ballcolor = 255;
      sideR = 0;
      sideL = 0;
      powerR = 0;
      powerL = 0;
      speedY = -6;
      speedX = -6;
      posB.x = width/2;
      posB.y = height/2;
      startGame = true;
    }
    //Main Menu
    if (mouseX >= width/2-200 && mouseX <= width/2 + 230 && mouseY <= height/1.1 && mouseY >= height/1.2) {
      startGame = false;
      ballcolor = 255;
      sideR = 0;
      sideL = 0;
      powerR = 0;
      powerL = 0;
      speedY = -6;
      speedX = -6;
    }
    //exit
    if (mouseX <= width && mouseX >= width - 100 && mouseY >= 0 && mouseY <= 40) {
      exit();
    }
  }
}

void endScreenLeft() {
  //left wins
  ballcolor = 0;
  speedX = 0;
  speedY = 0;
  fill(colour2);
  text(colours2 + " wins", width/2-200, height/10);
  fill(0);
  text("Play again", width/2-200, height/2);
  text("Main Menu", width/2-200, height/1.1);
  textSize(30);
  text("exit", width -70, 25);

  if (mousePressed) {
    if (mouseX >= width/2-200 && mouseX <= width/2 + 230 && mouseY <= height/2 && mouseY >= height/3) {
      startGame = false;
      ballcolor = 255;
      sideR = 0;
      sideL = 0;
      powerR = 0;
      powerL = 0;
      speedY = -6;
      speedX = -6;
      posB.x = width/2;
      posB.y = height/2;
      startGame = true;
    }
    if (mouseX >= width/2-200 && mouseX <= width/2 + 230 && mouseY <= height/1.1 && mouseY >= height/1.2) {
      startGame = false;
      sideR = 0;
      ballcolor = 255;
      sideL = 0;
      powerR = 0;
      powerL = 0;
      speedY = -6;
      speedX = -6;
    }
    if (mouseX <= width && mouseX >= width - 100 && mouseY >= 0 && mouseY <= 40) {
      exit();
    }
  }
}
void powerup() {
  //PowerUps
  if (yellow == true) {
    ballcolor = 0;
  }
  if (powerWR == true) {
    recharge.play();
    speedX *= -1;
    powerR = 0;
    powerWR = false;
  }
  if (powerWL == true) {
    recharge.play();
    speedX *= -1;
    powerL = 0;
    powerWL = false;
  }
  if (powerRR == true) {
    recharge.play();
    speedX *= 2;
    powerR = 0;
    powerRR = false;
    red = true;
  }
  if (powerRL == true) {
    recharge.play();
    speedX *= 2;
    powerL = 0;
    powerRL = false;
    red = true;
  }
  if (powerGR == true) {
    recharge.play();
    powerR = 0;
    powerGR = false;
    greenR = true;
  }
  if (powerGL == true) {
    recharge.play();
    powerL = 0;
    powerGL = false;
    greenL = true;
  }
  if (powerBR == true) {
    recharge.play();
    RacketR += 50;
    powerR = 0;
    powerBR = false;
  }
  if (powerBL == true) {
    recharge.play();
    RacketL += 50;
    powerL = 0;
    powerBL = false;
  }
  if (powerYR == true) {
    recharge.play();
    yellow = true;
    powerR = 0;
    powerYR = false;
  }
  if (powerYL == true) {
    recharge.play();
    yellow = true;
    powerL = 0;
    powerYL = false;
  }
  if (powerY == false) {
    powerWR = false;
  }
  if (powerX == false) {
    powerWL = false;
  }
  if (powerR >= 1080) {
    powerX = true;
  } else {
    powerX = false;
  }
  if (powerL >= 1080) {
    powerY = true;
  } else {
    powerY = false;
  }
  if (keyPressed) {
    if (keyCode == RIGHT && powerX == true && colours == "white") powerWR = true;
    if (key == 'q' && powerY == true && colours2 == "white") powerWL = true;
    else if (keyCode == RIGHT && powerX == true && colours == "red") powerRR = true;
    else if (key == 'q' && powerY == true && colours2 == "red") powerRL = true;
    else  if (keyCode == RIGHT && powerX == true && colours == "green") powerGR = true;
    else  if (key == 'q' && powerY == true && colours2 == "green") powerGL = true;
    else  if (keyCode == RIGHT && powerX == true && colours == "blue") powerBR = true;
    else  if (key == 'q' && powerY == true && colours2 == "blue") powerBL = true;
    else  if (keyCode == RIGHT && powerX == true && colours == "yellow") powerYR = true;
    else  if (key == 'q' && powerY == true && colours2 == "yellow") powerYL = true;
  }
}
void wall() {
  //wall collision
  if (posB.y >= height - 20) {
    speedY*=-1.1;
    speedX *= 1.1;
    wallSound.play();
  }
  if (posB.y <= 20) {
    speedY*=-1.1;
    speedX *= 1.1;
    wallSound.play();
  }
}

void options() {
  //Options screen
  background(0);
  fill(255);
  text("Options", width/2.35, height/5);
  fill(0);
  stroke(255);
  strokeWeight(weightW);
  rect(25, height/2.4, 300, 300);
  stroke(255, 0, 0);
  strokeWeight(weightR);
  rect(400, height/2.4, 300, 300);
  stroke(0, 255, 0);
  strokeWeight(weightG);
  rect(800, height/2.4, 300, 300);
  stroke(0, 0, 255);
  strokeWeight(weightB);
  rect(1200, height/2.4, 300, 300);
  stroke(255, 255, 0);
  strokeWeight(weightY);
  rect(1600, height/2.4, 300, 300);
  noStroke();
  fill(255);
  rect(50, height/2, 10, 100);
  rect(295, height/2, 10, 100);
  ellipse(175, height/1.8, 30, 30);
  fill(255, 0, 0);
  rect(425, height/2, 10, 100);
  rect(670, height/2, 10, 100);
  ellipse(550, height/1.8, 30, 30);
  fill(0, 255, 0);
  rect(825, height/2, 10, 100);
  rect(1070, height/2, 10, 100);
  ellipse(950, height/1.8, 30, 30);
  fill(0, 0, 255);
  rect(1225, height/2, 10, 100);
  rect(1470, height/2, 10, 100);
  ellipse(1350, height/1.8, 30, 30);
  fill(255, 255, 0);
  rect(1625, height/2, 10, 100);
  rect(1870, height/2, 10, 100);
  ellipse(1750, height/1.8, 30, 30);
  noStroke();
  fill(255);
  textSize(50);
  text("UP", 100, height/6);
  text('W', 105, height/4);
  text("down", 200, height/6);
  text('S', 230, height/4);
  text("PowerUp", 400, height/6);
  text('Q', 450, height/4);
  text("UP", width- 160, height/6);
  text(char(0X2191), width-155, height/4);
  text("down", width- 310, height/6);
  text(char(0X2193), width-280, height/4);
  text("PowerUp", width-550, height/6);
  text(char(0X2192), width-500, height/4);
  fill(255, 255, 0);
  textSize(20);
  text("White reverses the direction of the ball", 25, height/1.38);
  text("This takes 6 hits", 25, height/1.3);
  text("Red increases ball speed for a hit", 400, height/1.38);
  text("This takes 5 hits", 400, height/1.3);
  text("Green makes a protective sheild", 800, height/1.38);
  text("This takes 5 hits", 800, height/1.3);
  text("Blue increases racket size", 1200, height/1.38);
  text("This takes 2 hits", 1200, height/1.3);
  text("Yellow this the ball invisible", 1600, height/1.38);
  text("This takes 7 hits", 1600, height/1.3);
  textSize(30);
  if (mousePressed) {
    if (mouseX >= 25 && mouseX <= 325 && mouseY >= height/2.4 && mouseY <= height/2.4 + 300 && !(colours == "white") && P1 == false) {
      colours = "white";
      P1 = true;
    } else if (mouseX >= 25 && mouseX <= 325 && mouseY >= height/2.4 && mouseY <= height/2.4 + 300) {
      colours2 = "white";
      P1 = false;
    }
    if (mouseX >= 400 && mouseX <= 700 && mouseY >= height/2.4 && mouseY <= height/2.4 + 300 && !(colours == "red") && P1 == false) {
      colours = "red";
      P1 = true;
    } else if (mouseX >= 400 && mouseX <= 700 && mouseY >= height/2.4 && mouseY <= height/2.4 + 300) {
      colours2 = "red";
      P1 = false;
    }
    if (mouseX >= 800 && mouseX <= 1100 && mouseY >= height/2.4 && mouseY <= height/2.4 + 300 && !(colours == "green") && P1 == false) {
      colours = "green";
      P1 = true;
    } else if (mouseX >= 800 && mouseX <= 1100 && mouseY >= height/2.4 && mouseY <= height/2.4 + 300) {
      colours2 = "green";
      P1 = false;
    }
    if (mouseX >= 1200 && mouseX <= 1500 && mouseY >= height/2.4 && mouseY <= height/2.4 + 300 && !(colours == "blue") && P1 == false) {
      colours = "blue";
      P1 = true;
    } else if (mouseX >= 1200 && mouseX <= 1500 && mouseY >= height/2.4 && mouseY <= height/2.4 + 300) {
      colours2 = "blue";
      P1 = false;
    }
    if (mouseX >= 1600 && mouseX <= 1900 && mouseY >= height/2.4 && mouseY <= height/2.4 + 300 && !(colours == "yellow") && P1 == false) {
      colours = "yellow";
      P1 = true;
    } else if (mouseX >= 1600 && mouseX <= 1900 && mouseY >= height/2.4 && mouseY <= height/2.4 + 300) {
      colours2 = "yellow";
      P1 = false;
    }
    if (mouseX <= width && mouseX >= 80 && mouseY >= 0 && mouseY <= 35 && !(colours == colours2)) {
      options = false;
    } else if (mouseX <= width && mouseX >= 80 && mouseY >= 0 && mouseY <= 35) {
      fill(255, 0, 0);
    }
  }
  text("Back", 80, 35);
  if (colours == "white") {
    weightW = 15;
    text("P1", 175, height/2.5);
  } else if (colours2 == "white") {
    text("P2", 175, height/2.5);
    weightW = 15;
  } else {
    weightW = 1;
  }
  if (colours == "red") {
    weightR = 15;
    text("P1", 550, height/2.5);
  } else if (colours2 == "red") {
    text("P2", 550, height/2.5);
    weightR = 15;
  } else {
    weightR = 1;
  }
  if (colours == "green") {
    weightG = 15;
    text("P1", 950, height/2.5);
  } else if (colours2 == "green") {
    text("P2", 950, height/2.5);
    weightG = 15;
  } else {
    weightG = 1;
  }
  if (colours == "blue") {
    weightB = 15;
    text("P1", 1350, height/2.5);
  } else if (colours2 == "blue") {
    text("P2", 1350, height/2.5);
    weightB = 15;
  } else {
    weightB = 1;
  }
  if (colours == "yellow") {
    weightY = 15;
    text("P1", 1750, height/2.5);
  } else if (colours2 == "yellow") {
    text("P2", 1750, height/2.5);
    weightY = 15;
  } else {
    weightY = 1;
  }
}
void reDraw() {
  textSize(100);
  noStroke();
  background(255);
  fill(colour2, 20);
  rect(0, 0, width/2, height);
  fill(colour, 20);
  rect(width/2, 0, width/2, height);
  fill(0);
  for (int i = 0; i < height; i+=100) {
    rect(width/2 - 5, i, 5, 15);
  }
  text(sideR, width/1.5, 100);
  text(sideL, width/3, 100);
  fill(colour2);
  rect(posL.x, posL.y, 20, RacketL, 8);
  fill(colour);
  rect(posR.x, posR.y, 20, RacketR, 8);
  tint(255, ballcolor);
  image(ball, posB.x, posB.y, 75, 75);
  fill(0, 0, 255, 70);
  rect(0, 0, 20, powerL);
  rect(width - 20, 0, 20, powerR);
}
void game() {
  //Acutal game
  if (colours == "white")add = -36;
  if (colours2 == "white")add2 = -36;
  if (colours2 == "red") {
    colour2 = color(255, 0, 0);
  }
  if (colours2 == "green") {
    colour2 = color(0, 200, 0);
    add2=0;
  }
  if (colours2 == "blue") {
    colour2 = color(0, 0, 200);
    add2 = 324;
  }
  if (colours2 == "yellow") {
    colour2 = color(200, 200, 0);
    add2 = -60;
  }
  if (colours == "red") {
    colour = color(255, 0, 0);
  }
  if (colours == "green") {
    colour = color(0, 200, 0);
    add=0;
  }
  if (colours == "blue") {
    colour = color(0, 0, 200);
    add = 324;
  }
  if (colours == "yellow") {
    colour = color(200, 200, 0);
    add = -60;
  }
  posB.x += speedX;
  posB.y += speedY;
  if (speedX >= 25) {
    speedX = 25;
  }
  if (speedY >= 25) {
    speedY = 25;
  }
  if (keyPressed) {
    if (w == true && !(posL.y < 0)) {
      posL.y -= 25;
    } else if (s == true&&!(posL.y > height - RacketR)) {
      posL.y += 25;
    }
    if (o == true && !(posR.y < 0)) {
      posR.y -= 25;
    } else if (l == true && !(posR.y > height - RacketR)) {
      posR.y += 25;
    }
  }
}
void keyPressed() {
  //controls
  if (keyCode == UP) o = true;
  if (keyCode == DOWN) l = true;
  if (key == 'w') w = true;
  if (key == 's') s = true;
  if (key == 'z' && keyPressed && cheat2 == true) {
    powerL = height;
    cheat2 = false;
  }
  if (key == '.' && keyPressed && cheat == true) {
    powerR = height;
    cheat = false;
  }
  if (key == 'x' && keyPressed && cheat2 == true) {
    speedX *= 1.5;
    cheat2 = false;
  }
  if (key == ',' && keyPressed && cheat == true) {
    speedX *= 1.5;
    cheat = false;
  }
}

void keyReleased() {
  //controls
  if (keyCode == UP) o = false;
  if (keyCode == DOWN) l = false;
  if (key == 'w') w = false;
  if (key == 's') s = false;
}
