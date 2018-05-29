int paddleX, paddleY, paddleWidth, paddleHeight, paddleSpeed;

int ballX, ballY, ballHeight, ballWidth;

double xSpeedNormal, ySpeedNormal;

boolean up, down;

int backgroundColour1[], backgroundColour2[];
float bgColourmodifier;

int bG1[], bG2[];

int i;

int score = 0;

int screen = 0;
int bigFont = 48;
int mediumFont = 28;
int smallFont= 20;

float mouseLoc;

int normalDiffScreen = 1;
int infernoDiffScreen = 2;
int randomDiffScreen = 3;
int pongScreen = 4;
int coopScreen = 5;

void setup() { 
  size(700, 580);
  bG1 = new int[10];
  for (int q=0; q<bG1.length; q+=1) {
    bG1[q] = (q*10);
  }
  bG2 = new int[10];
  for (int q=0; q<bG2.length; q+=1) {
    bG2[q] = (255-q*10);
  }
  backgroundColour1 = new int[10];
  for (int q=0; q<backgroundColour1.length; q++) {
    backgroundColour1[q] = color(bG1[q], bG1[q], bG1[q]);
  }
  backgroundColour2 = new int[10];
  for (int q=0; q<backgroundColour1.length; q++) {
    backgroundColour2[q] = color(bG2[q], bG2[q], bG2[q]);
  }
  paddleX = 75;
  paddleY = height/2;
  paddleWidth = 20;
  paddleHeight = 150;
  paddleSpeed = 10;
  ballX = width/2;
  ballY = height/2;
  ballWidth = 50;
  ballHeight = 50;
  xSpeedNormal = 5;
  ySpeedNormal = 4;
  backgroundGradients();
}

void draw() {
  screen();
}

void normalMode() {
  background(0);

  theWall();
  drawPaddle();
  movePaddle();
  restrictPaddle();
  drawBall();
  moveBall();
  ballBounce();
  paddleBounce();
  gameOver();
  scores();
}

void backgroundGradients() {
  int bgNumber = 1;
  int opacity = 1;
  int theLight = width/4;
  i=0;
  bgColourmodifier=0;
  while (i<theLight) {
    fill(lerpColor(backgroundColour2[bgNumber], backgroundColour1[bgNumber], bgColourmodifier), opacity);
    noStroke();
    rect(i, 0, i+2, height, 0.25);
    i+=1;
    bgColourmodifier+=0.0085;
  }
}

void drawPaddle() {
  fill(#00FFFF);
  noStroke();
  rect(paddleX, paddleY, paddleWidth, paddleHeight);
}

void movePaddle() {
  if (up) {
    paddleY-=paddleSpeed;
  } else if (down) {
    paddleY+=paddleSpeed;
  }
}

void restrictPaddle() {
  if (paddleY < 0) {
    paddleY += paddleSpeed;
  }
  if (paddleY + paddleHeight > height) {
    paddleY -= paddleSpeed;
  }
}

void drawBall() {
  fill(#ffffff);
  ellipse(ballX, ballY, ballWidth, ballHeight);
}

void moveBall() {
  ballX+= xSpeedNormal;
  ballY+= ySpeedNormal;
}

void theWall() {
  noStroke();
  fill(#FF0000);
  rect(width-100, 0, width, height);
}

void ballBounce() {
  if (ballX > width-100 - ballWidth/2) {
    xSpeedNormal = -xSpeedNormal;
  }
  if (ballY >= height - ballHeight/2) {
    ySpeedNormal = -ySpeedNormal;
  } else if (ballY < ballHeight/2) {
    ySpeedNormal = -ySpeedNormal;
  }
}

void paddleBounce() {
  if (ballX - ballWidth/2 < paddleX + paddleWidth/2 && ballY - ballHeight/2 < paddleY + paddleHeight && ballY + ballHeight/2 > paddleY) { 
    if (xSpeedNormal < 0) {
      xSpeedNormal = -xSpeedNormal*103/100;
      ySpeedNormal = ySpeedNormal*105/100;
      score+=1;
    }
  }
}

void gameOver() {
  if (ballX - ballWidth/2< 0) {
    xSpeedNormal = 0;
    ySpeedNormal = 0;
    if (score < 10) {
      text("you suck >:]", 100, 300);
    } else if (score < 20 && score >= 10) {
      text("git gud", 100, 300);
    } else if (score < 50 && score >= 20) {
      text("not bad", 100, 300);
    } else if (score < 100 && score >= 50) {
      text("waow", 100, 300);
    } else if (score >= 100) {
      textSize(80);
      text("waow u so cool", 0, 300);
      textSize(7);
      text("like Mr Gallo",width/2-100,325);
    }
    textSize(30);
    text("Title Screen", width/5,500);
    text("Try Again?", width/4+width/3,500);
     mouseLoc = dist(mouseX, mouseY, 217, 492);
  if (mousePressed){
  if (mouseLoc <= 120) {
    screen = 0;
    setup();
  }
   mouseLoc = dist(mouseX, mouseY, 471, 492);
  if (mouseLoc <= 120) {
    screen = normalDiffScreen;
    setup();
  }
  }
  }
}
void scores() {
  textSize(100);
  fill(255);
  text(score, width/2, 100);
}

void keyPressed() {
  if (key == 'w'|| key == 'W') {
    up = true;
  } 
  if (key == 's'|| key == 'S') {
    down = true;
  }
}
void keyReleased() {
  if (key == 'w'|| key == 'W') {
    up = false;
  } 
  if (key == 's'|| key == 'S') {
    down = false;
  }
}


void screen() {
  if (screen == 0) {
    background(0);

    fill(255);

    textSize(bigFont);
    text("Project S", width/2-100, 150);

    textSize(mediumFont);
    text("Singleplayer", width/2-250, 200);

    textSize(smallFont);
    text("Normal", width/2-230, 250);

    textSize(smallFont);
    text("Infernal+", width/2-230, 310);

    textSize(smallFont);
    text("Random", width/2-230, 370);

    textSize(mediumFont);
    text("Multiplayer", width/2+100, 200);

    textSize(smallFont);
    text("Pong", width/2+120, 250);

    textSize(smallFont);
    text("Co-op", width/2+120, 370);

    textSize(mediumFont);
    text("Credits: Derek Shat, Leo Xiao", width/2-200, 530);
  }
  fill(0, 0, 0, 0);
  noStroke(); //normal diff button
  rect(120, 228, 90, 30); 

  noStroke(); //inferno diff button
  rect(120, 288, 90, 30);

  noStroke(); //random diff button
  rect(120, 348, 90, 30);

  noStroke(); //pong button
  rect(465, 228, 90, 30);

  noStroke(); //co op music
  rect(465, 348, 90, 30);


  if (screen == normalDiffScreen) {
    normalMode();
  }
    
}
   
void mousePressed() {
  mouseLoc = dist(mouseX, mouseY, 120, 288);
  if (mouseLoc <= 90) {
    screen = normalDiffScreen;
  }

  mouseLoc = dist(mouseX, mouseY, 120, 348);
  if (mouseLoc <= 90) {
    screen = infernoDiffScreen;
  }

  mouseLoc = dist(mouseX, mouseY, 120, 408);
  if (mouseLoc <= 90) {
    screen = randomDiffScreen;
  }

  mouseLoc = dist(mouseX, mouseY, 465, 288);
  if (mouseLoc <= 90) {
    screen = pongScreen;
  }

  mouseLoc = dist(mouseX, mouseY, 465, 408);
  if (mouseLoc <= 90) {
    screen = coopScreen;
  }
  println(mouseX,mouseY);
}