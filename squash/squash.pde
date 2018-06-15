float paddleX, paddleY, paddleY2, paddleWidth, paddleHeight, paddleSpeed; //paddle values such as x and y location, width and height, and speed

float ballX, ballY, ballX2, ballY2, ballHeight, ballWidth; //ball values like x and y location, width and height

double xSpeed, xSpeed2, ySpeed, ySpeed2; //the universal x and y speed of the ball

double xSpeedN, ySpeedN, xSpeedI, ySpeedI;//the x and y speed of the ball when normal or infernal is pressed (ball speed increases differently

boolean up, up2, down, down2;//allows user to control paddle when they press w or a, and up or down in multiplayer

int score, score2, score3; //remembers the numbers of times the ball hit the paddle

int bg[]; //array for backgrounds

int screen = 0; //title screen value
int bigFont = 48; //font size of the big fonts
int mediumFont = 28; //font size of the medium fonts
int smallFont = 20; //font size of the small fonts

float mouseLoc; //for clicking the options on the screen

int normalDiffScreen = 1; //normal screen value
int infernalDiffScreen = 2; //infernal diff screen
int randomScreen = 3; //random diff screen
int pongScreen = 4; //pong mode
int coopScreen = 5; //co-op mode 
int randomPongScreen = 6; //random pong mode

PImage img, img2; //function for loading the image for the wall's "face"

void setup() { 
  size(700, 580);//size of canvas
  //loads images for wall's "face"
  img = loadImage("angery.png");
  img2 = loadImage("awesomeface.png");
  //backgrounds for each game mode
  bg = new int[7];
  bg[1] = #1ACB00;
  bg[2] = #AF02F0;
  bg[3] = #FF95D0;
  bg[4] = #000000;
  bg[5] = #FFBC00;
  bg[6] = #83DB00;

  paddleX = 75; //x location of paddle
  paddleY = height/2; //y location of paddle
  paddleY2 = height/2; //y location of the second paddle (co-op mode only)
  paddleWidth = 20; //width of paddle
  paddleHeight = 150; //height of paddle
  paddleSpeed = 10; //speed of paddle

  ballX = width/2; //x location of ball
  ballX2 = 3*width/4; //x location of the second ball (co-op mode only)
  ballY = height/2; //y location of ball
  ballY2 = height/4; //y location of second ball (co-op mode only)
  ballWidth = 50; //width of ball
  ballHeight = 50; //height of ball

  xSpeed = 5; //x speed of ball
  xSpeed2 = 3; //x speed of second ball (co-op mode only)
  ySpeed = 4; //y speed of ball
  ySpeed2 = 4; //y speed of second ball (co-op mode only)

  score = 0; //sets initial score value to 0
}

void draw() {
  screen(); //draws the title screen
}

//all the functions normal mode needs to call
void normalMode() {
  background(bg[normalDiffScreen]);
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

//all the functions infernal mode needs to call 
void infernalMode() {
  background(bg[infernalDiffScreen]);
  theWall();
  paddleHeight = 200;
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

//all the functions random mode needs to call
void randomMode() {
  background(bg[randomScreen]);
  seizureBackground();
  theWall();
  drawPaddle();
  movePaddle();
  restrictPaddle();
  drawBall();
  moveBall();
  ballBounceRandom();
  paddleBounce();
  gameOver();
  scores();
}

//all the functions pong mode needs to call
void pongMode() {
  background(bg[pongScreen]);
  drawPaddle();
  movePaddle();
  restrictPaddle();
  ballWidth = 35; //ball is smaller in pong modesco
  ballHeight = 35;
  drawBall();
  moveBall();
  ballBounce();
  ballReset();
  paddleBouncePong();
  gameOverPong();
  scores();
}

//all the functions co-op mode needs to call
void coopMode() {
  background(bg[coopScreen]);
  theWall();
  drawPaddle();
  movePaddle();
  restrictPaddle();
  ballHeight = 35; //smaller in co-op mode
  ballWidth = 35;
  drawBall();
  moveBall();
  ballBounce();
  paddleBounceCoop();
  gameOver();
  scores();
}

//all the functions random pong mode needs to call
void randomPongMode() {
  background(bg[randomPongScreen]);
  image(img2, width/2-137.5,height/2-137.5,275,275); //awesome face in the middle of the screen
  drawPaddle();
  movePaddle();
  restrictPaddle();
  ballHeight = 35; //smaller in random pong
  ballWidth = 35;
  drawBall();
  moveBall();
  ballBounceRandom();
  ballReset();
  paddleBounceRandomPong();
  gameOverPong();
  scores();
}

//draws the paddle and colors it cyan
void drawPaddle() {
  fill(#00FFFF);
  noStroke();
  rect(paddleX, paddleY, paddleWidth, paddleHeight);
  //also draws the second paddle if the game is in the co-op screen and colours it green
  if (screen == coopScreen) {
    fill(#C600EA);
    rect(paddleX+50, paddleY2, paddleWidth, paddleHeight);
  }
  //also draws the second paddle if the game is in the pong screen and colours it red
  if (screen == pongScreen || screen == randomPongScreen) {
    fill(#FF0000);
    rect(paddleX+550, paddleY2, paddleWidth, paddleHeight);
  }
}

//allows user to control the paddle up and down
void movePaddle() {
  if (up) {
    paddleY-=paddleSpeed;
  } else if (down) {
    paddleY+=paddleSpeed;
  }
  //if the game is in co-op or pong screens, then allows player 2 to control the second paddle
  if (screen == coopScreen || screen == pongScreen || screen == randomPongScreen) {
    if (up2) {
      paddleY2 -= paddleSpeed;
    } else if (down2) {
      paddleY2 += paddleSpeed;
    }
  }
}

//stops the paddle from going off screen
void restrictPaddle() {
  if (paddleY < 0) {
    paddleY += paddleSpeed;
  }
  if (paddleY + paddleHeight > height) {
    paddleY -= paddleSpeed;
  }
  //stops the second paddle from going off screen
  if (screen == coopScreen || screen == pongScreen || screen == randomPongScreen) {
    if (paddleY2 < 0) {
      paddleY2 += paddleSpeed;
    }
    if (paddleY2 + paddleHeight > height) {
      paddleY2 -= paddleSpeed;
    }
  }
}

//draws the ball and colors it white also draws the second ball if the game is in co-op mode
void drawBall() {
  fill(#ffffff);
  ellipse(ballX, ballY, ballWidth, ballHeight);
  if (screen == coopScreen) {
    ellipse(ballX2, ballY2, ballWidth, ballHeight);
  }
}
//moves the ball by constantly updating its x and y locations
void moveBall() {
  ballX += xSpeed;
  ballY += ySpeed;
  if (screen == coopScreen) {
    ballX2 += xSpeed2;
    ballY2 += ySpeed2;
  }
}

//draws the wall and colors it red
void theWall() {
  noStroke();
  fill(#FF0000);
  rect(width-100, 0, width, height);
  image(img, 600, 230, 100, 100);
  if (screen == randomScreen) {
    image (img2, 600, 230, 100, 100); // gives the wall the "angery" face
  }
  //gives the wall a "face"
  if (screen == randomScreen) {
    if (score % 4 == 0) { //ball shows awesome face whenever score is not a multiple of 4, otherwise it shows the "angery" face, not really random
      image(img, 600, 230, 100, 100);
    } else {
      image (img2, 600, 230, 100, 100);
    }
  }
}

//allows the ball to bounce off the walls 
void ballBounce() {
  if (ballY >= height - ballHeight/2) { //when ball hits the top of the screen, the ball bounces down
    ySpeed = -ySpeed;
  } else if (ballY - ballHeight/2 < 0) { //when ball hits the bottom of the screen, the ball bounces up
    ySpeed = -ySpeed;
  }
  if (screen  != pongScreen && screen != randomPongScreen) {
    if (ballX > width-100 - ballWidth/2) {//when the right side of the ball hits the wall on the left, the ball will bounce off
      xSpeed = -xSpeed;
    }
  }
  //same as above but for co-op mode
  if (screen == coopScreen) {
    if (ballX2 >= width-100 - ballWidth/2) {
      xSpeed2 = -xSpeed2;
    }
    if (ballY2 >= height - ballHeight/2) {
      ySpeed2 = -ySpeed2;
    } else if (ballY2 - ballHeight/2 < 0) {
      ySpeed2 = -ySpeed2;
    }
  }
}

//for random modes only!
void ballBounceRandom() {
  if (screen != randomPongScreen) { //only for random non-pong mode
    if (ballX > width-100 - ballWidth/2) { //when wall bounces off the wall on the right, the xspeed of ball changes depending on the number chosen randomly from 3 to 13
      xSpeed = -random(3, 15); //xspeed of ball changes depending on the number chosen randomly from 3 to 13
      ySpeed = random(-10, 10); //changes the yspeed depending on random number picked from -10 to 10
      if (xSpeed >= 15) {
        xSpeed = random(-15, 15); //limits speed to always be a random value less than or equal to 15 in any x-direction
        if (xSpeed <= 5 && xSpeed >= 0) {
          xSpeed = 5; //makes minimum speed 5 when hitting towards wall
        }
      }
      if (ySpeed >= 10) { 
        ySpeed = random(-10, 10); //limits speed to always be a random value less than or equal to 10 in any y-direction
        if (ySpeed <=2 && ySpeed >= 0) {
          ySpeed = 3; //makes minimum speed 3 when bouncing upwards
        }
        if (ySpeed >= -2 && ySpeed <= 0) {
          ySpeed = -3; //makes minimum speed 3 when bouncing downwards
        }
      }
    }
  }
  //now applies to random pong mode
  if (ballY >= height - ballHeight/2) { //hitting bottom
    ySpeed = -random(3, 10); //ball will bounce back vertically at a random speed value between 3 and 10
    xSpeed = random(-10, 10); //ball can go either left of right at a random value between 3 and 10
    if (xSpeed <= 3 && xSpeed >= 0) {
      xSpeed =3;
    }
    if (xSpeed >= -3 && xSpeed <= 0) {
      xSpeed = -3;
    }
  }
  //same thing for top
  else if (ballY - ballHeight/2 < 0) {
    ySpeed = random(3, 10);
    xSpeed = random(-10, 10);
    if (xSpeed <= 3 && xSpeed >= 0) {
      xSpeed =3;
    }
    if (xSpeed >= -3 && xSpeed <= 0) {
      xSpeed = -3;
    }
  }
}

void paddleBounce() {
  //when the left of the ball hits the 
  //left of the ball is greater than middle of the paddle and left of ball is less than the right of paddle
  //                                                                             bally has to be less than the top of the paddle and greater than the bottom of the paddle
  if (ballX - ballWidth/2 > paddleX && ballX - ballWidth/2 < paddleX + paddleWidth/2 && ballY - ballHeight/2 < paddleY + paddleHeight && ballY + ballHeight/2 > paddleY) { 
    if (screen == normalDiffScreen) {//in normal mode
      //exponential speed growth of ball
      xSpeed = -xSpeed*105/100;
      ySpeed = ySpeed*104/100;
    }
    if (screen == infernalDiffScreen) {//in infernal mode
      //faster growth of ball than in normal
      xSpeed = -xSpeed*108/100;
      ySpeed = ySpeed*107/100;
    }
    if (screen == randomScreen) {//in random mode
      xSpeed = random(5, 25); //ball bounces off paddle at random speed between 5 and 25
      ySpeed = random(-10, 10); // ball bounces off paddle downwards or upwards at a random speed less than or equal to 10
    }
    score+=1; // gives score when ball hits paddle
  }
  //speed limiters for normal mode
  if (screen == normalDiffScreen) {
    if (xSpeed >= 10) {
      xSpeed = 10;
    }
    if (ySpeed >= 10) {
      ySpeed = 10;
    }
  }
  //speed limiters for infernal mode which are higher than in normal mode
  if (screen == infernalDiffScreen) {
    if (xSpeed >= 25) {
      xSpeed = 25;
    }
    if (ySpeed >= 20) {
      ySpeed = 20;
    }
    //speed limiters for random mode
    if (screen == randomScreen) {
      if (ySpeed <= 3 && ySpeed >= 0) {
        ySpeed = 3;
      }
      if (ySpeed >= -3 && ySpeed <= 0) {
        ySpeed = -3;
      }
    }
  }
}

//same as above but for pong, meaning two paddles are involved
void paddleBouncePong() {
  if (ballX - ballWidth/2 > paddleX && ballX - ballWidth/2 < paddleX + paddleWidth/2 && ballY - ballHeight/2 < paddleY + paddleHeight && ballY + ballHeight/2 > paddleY) {
    xSpeed = -xSpeed*105/100;
    ySpeed = ySpeed*104/100;
  } else if (ballX + ballWidth/2 > paddleX+550 && ballX + ballWidth/2 < paddleX+550 + paddleWidth/2 && ballY - ballHeight/2 < paddleY2 + paddleHeight && ballY + ballHeight/2 > paddleY2) {
    xSpeed = -xSpeed*105/100;
    ySpeed = ySpeed*104/100;
  }
  if (xSpeed >9) {
    xSpeed = 9; //speed limit at 9 because ball will penetrate paddle if it goes any higher for some reason
  }
}

//same as above but for co-op
void paddleBounceCoop() {
  if (ballX - ballWidth/2 > paddleX && ballX - ballWidth/2 < paddleX + paddleWidth/2 && ballY - ballHeight/2 < paddleY + paddleHeight && ballY + ballHeight/2 > paddleY || ballX - ballWidth/2 > paddleX+50 && ballX - ballWidth/2 < paddleX+50 + paddleWidth/2 && ballY - ballHeight/2 < paddleY2 + paddleHeight && ballY + ballHeight/2 > paddleY2 ) { 
    if (xSpeed < 0) {
      xSpeed = -xSpeed*106/100;
      ySpeed = ySpeed*105/100;
      score+=1;
    }
  }
  if (ballX2 - ballWidth/2 > paddleX && ballX2 - ballWidth/2 < paddleX + paddleWidth/2 && ballY2 - ballHeight/2 < paddleY + paddleHeight && ballY2 + ballHeight/2 > paddleY || ballX2 - ballWidth/2 > paddleX+50 && ballX2 - ballWidth/2 < paddleX+50 + paddleWidth/2 && ballY2 - ballHeight/2 < paddleY2 + paddleHeight && ballY2 + ballHeight/2 > paddleY2 ) { 
    if (xSpeed2 < 0) {
      xSpeed2 = -xSpeed2*112/100;
      ySpeed2 = ySpeed2*110/100;
      score +=1;
    }
  }
  if (xSpeed >= 10) {
    xSpeed = 10;
  }
  if (ySpeed >= 14) {
    ySpeed = 10;
  }
  if (xSpeed2 >= 12) {
    xSpeed2 = 12;
  }
  if (ySpeed2 >= 16) {
    ySpeed2 = 16;
  }
}

//same but for random pong
void paddleBounceRandomPong() {
  if (ballX - ballWidth/2 > paddleX && ballX - ballWidth/2 < paddleX + paddleWidth/2 && ballY - ballHeight/2 < paddleY + paddleHeight && ballY + ballHeight/2 > paddleY) {
    xSpeed = random(5, 13);
    ySpeed = random(-10, 10);
  } else if (ballX + ballWidth/2 > paddleX+550 && ballX + ballWidth/2 < paddleX+550 + paddleWidth/2 && ballY - ballHeight/2 < paddleY2 + paddleHeight && ballY + ballHeight/2 > paddleY2) {
    xSpeed = random(-5, -13);
    ySpeed = random(-10, 10);
  }
  if (ySpeed <= 3 && ySpeed >= 0) {
    ySpeed = 3;
  }
  if (ySpeed >= -3 && ySpeed <= 0) {
    ySpeed = -3;
  }
  //if the ball goes too fast, the ball penetrates the paddle, so this is to make sure that it doesn't
  if (xSpeed*ySpeed >= 110 || xSpeed*ySpeed <= -110) {//if the product of the x and yspeed goes to high, the ball speed is lowered to the point where it's really slow
    xSpeed = random(-5, 5);
    ySpeed = random(-5, 5);
  }
}

//makes the ball reset at centre when it goes off screen in pong modes
void ballReset() {
  if (ballX - ballWidth/2 < 0) {
    score3 +=1;
    setup();
  } else if (ballX + ballWidth/2 > width) {
    score2 +=1;
    setup();
  }
}

//sets a game over screen
void gameOver() {
  if (ballX - ballWidth/2< 0|| ballX2 - ballWidth/2 <0 ) { //when any ball hits the left of the screen
    //both balls stop, even if they are not there
    xSpeed = 0;
    ySpeed = 0;
    xSpeed2 = 0;
    ySpeed2 = 0;

    //displays a message based on score gotten
    if (score < 10) {
      text("you suck >:]", 100, 300);
    } else if (score < 20 && score >= 10) {
      text("git gud", 100, 300);
      textSize(7);
      text("hub", 228, 300);
    } else if (score < 50 && score >= 20) {
      text("not bad", 100, 300);
    } else if (score < 100 && score >= 50) {
      text("waow", 100, 300);
    } else if (score >= 100) {
      textSize(80);
      text("waow u so cool", 0, 300);
      textSize(7);
      text("like Mr Gallo", width/2-100, 325);
    }
    //text that gives player options to play again or go to title
    textSize(30);
    text("Title Screen", width/5, 500);
    text("Try Again?", width/4+width/3, 500);

    //also gives user two options to go back to the main menu (screen 1) or to play the same mode again
    mouseLoc = dist(mouseX, mouseY, 217, 492);
    if (mousePressed) {
      if (mouseLoc <= 120) {
        screen = 0;
        setup();
      }
      mouseLoc = dist(mouseX, mouseY, 471, 492);
      if (mouseLoc <= 120) {
        if (screen == 1) {
          screen = normalDiffScreen;
          setup();
        }
        if (screen == 2) {
          screen = infernalDiffScreen;
          setup();
        }
        if (screen == 3) {
          screen = randomScreen;
          setup();
        }
        if (screen == 5) { 
          screen = coopScreen;
          setup();
        }
        if (screen == 6) {
          screen = randomPongScreen;
          setup();
        }
      }
    }
  }
}

//game over for pong modes
void gameOverPong() {
  if (score3 == 5 || score2 == 5) {
    xSpeed = 0;
    ySpeed = 0;
    textSize(30);
    text("Title Screen", width/5, 500);
    text("Try Again?", width/4+width/3, 500);
    mouseLoc = dist(mouseX, mouseY, 217, 492);
    if (mousePressed) {
      if (mouseLoc <= 120) {
        screen = 0;
        score2 = 0;
        score3 = 0;
        setup();
      }
      mouseLoc = dist(mouseX, mouseY, 471, 492);
      if (mouseLoc <= 120) {
        score2 = 0;
        score3 = 0;
        setup();
      }
    }
  }
}

//displays the score in the center of screen near the top
void scores() {
  textSize(100);
  fill(255);
  //only singleplayer and co-op
  if (screen != pongScreen && screen != randomPongScreen) {
    text(score, width/2+50, 100);
  }
  //only for pong modes
  if (screen == pongScreen|| screen == randomPongScreen) {
    text(score2, width/2-200, 100);
    text(score3, width/2+150, 100);
  }
}

//if user pressed w/up or s/down then the paddle will move until they release the key
void keyPressed() {
  if (key == 'w'|| key == 'W') {
    up = true;
  } 
  if (key == 's'|| key == 'S') {
    down = true;
  }
  if (keyCode == UP) {
    up2 = true;
  }
  if (keyCode == DOWN) {
    down2 = true;
  }
}

void keyReleased() {
  if (key == 'w'|| key == 'W') {
    up = false;
  } 
  if (key == 's'|| key == 'S') {
    down = false;
  }
  if (keyCode == UP) {
    up2 = false;
  }
  if (keyCode == DOWN) {
    down2 = false;
  }
}

//when score is a multiple of 10 the background starts spazzing out, only exists in random mode for the sake of making the player mess up
void seizureBackground() {
  for (int i = 1; i<100; i++) {
    if (score == i*10) {
      background(random(0, 255), random(0, 255), random(0, 255));
    }
  }
}

//the main menu code! Which is just a bunch of text and buttons
void screen() {
  if (screen == 0) {
    background(0);

    fill(255);

    textSize(bigFont);
    text("Totally Not Pong", width/2-200, 150);

    textSize(mediumFont);
    text("Singleplayer", width/2-250, 200);

    textSize(smallFont);
    text("Normal", width/2-230, 250);

    textSize(smallFont);
    text("Infernal+", width/2-230, 340);

    textSize(smallFont);
    text("Random", width/2-230, 430);

    textSize(mediumFont);
    text("Multiplayer", width/2+100, 200);

    textSize(smallFont);
    text("Pong", width/2+120, 250);

    textSize(smallFont);
    text("Co-op", width/2+120, 340);

    textSize(smallFont);
    text("Random Pong", width/2+120, 430);

    textSize(mediumFont);
    text("Credits: Derek Shat, Leo Xiao", width/2-200, 530);
  }

  if (screen == normalDiffScreen) {
    normalMode();
  }
  if (screen == infernalDiffScreen) {
    infernalMode();
  }
  if (screen == randomScreen) {
    randomMode();
  }
  if (screen == pongScreen) {
    pongMode();
  }
  if (screen == coopScreen) {
    coopMode();
  }
  if (screen == randomPongScreen) {
    randomPongMode();
  }
}

//uses the distance of the mouse and the invisible square to see what the user has clicked to go to the appropriate screen
void mousePressed() {
  mouseLoc = dist(mouseX, mouseY, 165, 246);
  if (mouseLoc <= 50 && screen == 0) {
    screen = normalDiffScreen;
  }

  mouseLoc = dist(mouseX, mouseY, 165, 332);
  if (mouseLoc <= 50 && screen == 0) {
    screen = infernalDiffScreen;
  }

  mouseLoc = dist(mouseX, mouseY, 165, 423);
  if (mouseLoc <= 50 && screen == 0) {
    screen = randomScreen;
  }

  mouseLoc = dist(mouseX, mouseY, 501, 248);
  if (mouseLoc <= 50 && screen == 0) {
    screen = pongScreen;
  }
  mouseLoc = dist(mouseX, mouseY, 501, 332);
  if (mouseLoc <= 50 && screen ==0) {
    screen = coopScreen;
  }
  mouseLoc = dist(mouseX, mouseY, 501, 423);
  if (mouseLoc <= 50 && screen == 0) {
    screen = randomPongScreen;
  }
  println(mouseX, mouseY); //for developer use only
}
