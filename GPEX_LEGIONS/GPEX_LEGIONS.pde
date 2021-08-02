Target[] targets = new Target[100];
Scope scope;

float mx = mouseX;
float my = mouseY;
float bg_x = -300;
float bg_y = -300;
int score = 0;
int set = 0;
int m = 0;
int scene = 0;
PImage img;
String high[];
String time[];
boolean s_dis=true; //maru
boolean p_dis=false;
boolean r_dis=false;
boolean h_dis=false;
boolean highscoreCheck = false;
int cu;
PImage tit;

class Target {
  PImage en1, en2, en3, en4;
  float x, y, w=40, h=40;  
  int moveX = 2;
  int moveY = 2;
  Target(float x0, float y0) { 
    x =x0; 
    y =y0;
    en1 = loadImage("en1.png");
    en2 = loadImage("en2.png");
    en3 = loadImage("en3.png");
    en4 = loadImage("en4.png");
  } 
  void display(int i) { 
    //x-280 y-150
    if (i%4==0) {
      image(en1, x-280, y-150);
    } else if (i%4==1) {
      image(en2, x-277, y-155);
    } else if (i%4==2) {
      image(en3, x-270, y-230);
    } else {
      image(en4, x-300, y-150);
    }
    fill(255, 0, 0); 
    ellipse(x, y, w-(i/5), h-(i/5));
  } 



  boolean isInside() { 
    return dist(x, y, width/2, height/2) < w/2;
  }

  void move(int num) {

    if (num%2 == 0) {
      if (m%30 == 0) {
        moveX *= -1;
      }
      x += moveX;
    } else {
      if (m%30 == 0) {
        moveY *= -1;
      }
      y += moveY;
    }
  }
} 

class Scope {
  int scopeR = width/2;
  int scopeX = width/2;
  int scopeY = height/2;

  void display() {
    noFill();
    strokeWeight(2);
    line(scopeX, scopeY/100*38, scopeX, scopeY/100*163);//縦線
    line(scopeX/10*5, scopeY, scopeX/10*15, scopeY);//横線

    strokeWeight(15);

    line(scopeX, scopeY/10*5, scopeX, scopeY/100*25);//上線
    line(scopeX, scopeY/100*175, scopeX, scopeY/10*15);//下線
    line(scopeX/10*4, scopeY, scopeX/10*6, scopeY);//左線
    line(scopeX/10*16, scopeY, scopeX/10*14, scopeY);//右線


    strokeWeight(4);
    ellipse(scopeX, scopeY, scopeR/100*6, scopeR/100*6);
    strokeWeight(10);
    ellipse(scopeX, scopeY, scopeR, scopeR);//(500,400,500,500)

    strokeWeight(3);

    ellipse(scopeX, scopeY, scopeR/10*4, scopeR/10*4);
    ellipse(scopeX, scopeY, scopeR/100*96, scopeR/100*96);
    ellipse(scopeX, scopeY, scopeR/10*12, scopeR/10*12);
  }
}

void Tsetting() {
  for (int i = 0; i < targets.length; i++) {
    targets[i] = new Target(random(150, width-150), random(150, height-150));
  }
}


void title() {
  
  background(123);
  fill(0, 123, 123);
  rectMode(CENTER);
  rect(width/2, height/2, 300, 100);
  rect(width/2, height*3/4, 300, 100);
  fill(255);
  stroke(0);
  image(tit,100,-100);
  textSize(30);
  text("game start", width/2-70, height/2);
  text("how to", width/2-50, height*3/4);
  fill(255);
  stroke(255,123,188);
  rect(width/2, height-35, 150, 50);
  fill(255, 123, 188);
  text("exit", width/2-28, height-25);
  if (mouseX>=width/2-75&&mouseX<=width/2+75&&mouseY>=height-50&&mouseY<=height&&mousePressed) {
    exit();
  }
  stroke(0);
}

void howto() {
  background(123);
  fill(255);
  text("The aim moves with the mouse and keyboard.  ", 10, 30);
  text("Align the aim with the red circle and click.", 10, 60);
  text("Aim for a high score.                       ", 10, 90);
  rect(width/4, height/2-60, 50, 50);
  rect(width/4-60, height/2, 50, 50);
  rect(width/4, height/2, 50, 50);
  rect(width/4+60, height/2, 50, 50);
  ellipse(width/2-30, height/2-20, 80, 120);
  line(width/2-30, height/2-20, width/2-30, height/2-80);
  line(width/2-70, height/2-20, width/2+10, height/2-20);
  fill(0);
  text("W", width/4-5, height/2-55);
  text("A", width/4-65, height/2+5);
  text("S", width/4-5, height/2+5);
  text("D", width/4+55, height/2+5);
  text("or", width/4+100, height/2-25);

  fill(255);
  rect(width-75, height-25, 150, 50);
  fill(0, 123, 123);
  text("return", width-110, height-20);
  if (mouseX>=width-150&&mouseX<=width&&mouseY>=height-50&&mouseY<=height&&mousePressed) {
    scene = 0;
  }
}

void result() {
  cursor();
  background(0);
  fill(255);
  text("score", width/2-30, height/2-100);
  text(score, width/2-5, height/2-60);
  if(score >= int(high[4])){
    fill(255,150,60);
    text("New Record!!",width/2-60, height/2-130);
  }
  strokeWeight(3);
  stroke(255, 0, 0);
  fill(255);
  rect(width/2, height*3/4, 300, 100);
  fill(255, 0, 0);
  text("return", width/2-40, height*3/4+8);
  if (mouseX>=width/2-150&&mouseX<=width/2+150&&mouseY>=height*3/4-50&&mouseY<=height*3/4+50&&mousePressed) {
    r_dis=false;
    s_dis=true;
    m = 0;
    score = 0;
    highscoreCheck = false;
    Tsetting();
    scene = 0;
  }
  fill(255);
  stroke(0,123,123);
  rect(80, height-35, 150, 50);
  fill(0, 123, 123);
  text("highscore", 20, height-25);
  if (mouseX>=0&&mouseX<=150&&mouseY>=height-50&&mouseY<=height&&mousePressed) {
    scene = 3;
  }
  fill(255);
  stroke(255,123,188);
  rect(width/2, height-35, 150, 50);
  fill(255, 123, 188);
  text("exit", width/2-20, height-25);
  if (mouseX>=width/2-75&&mouseX<=width/2+75&&mouseY>=height-50&&mouseY<=height&&mousePressed) {
    exit();
  }
  strokeWeight(1);
}

void highscore() {
  if (!(highscoreCheck)) {
    for (int i = 0; i < 5; i++) {
      if (score >= int(high[i])) {
        for(int j = 3; j >= i; j--){
          high[j+1] = high[j];
          time[j+1] = time[j];
        }
        if(score < 10){
          high[i] = "0" + str(score);
        }else{
          high[i] = str(score);
        }
        time[i] = maketime();
        break;
      }
    }
    saveStrings("highscore.txt",high);
    saveStrings("time.txt",time);
    highscoreCheck = true;
  }
  background(123);

  for(int i = 0; i < 5; i++){
    textSize(48);
    fill(255);
    text(i+1+".",400,(i+1)*100);
    text(high[i]+"pt",600,(i+1)*100);
    textSize(24);
    text(time[i],450,(i+1)*100+30);
  }
  stroke(0,123,123);
  rect(width-75, height-25, 150, 50);
  fill(0, 123, 123);
  text("return", width-110, height-20);
  if (mouseX>=width-150&&mouseX<=width&&mouseY>=height-50&&mouseY<=height&&mousePressed) {
    scene = 2;
  }
}

String maketime(){
  String m,d,h,mi;
  if(month() < 10){
    m = "0" + str(month());
  }else{
    m = str(month());
  }
  if(day() < 10){
    d = "0" + str(day());
  }else{
    d = str(day());
  }
  if(hour() < 10){
    h = "0" + str(hour());
  }else{
    h = str(hour());
  }
  if(minute() < 10){
    mi = "0" + str(minute());
  }else{
    mi = str(minute());
  }
  return year() + "-" + m + "-" + d+ " " + h + ":" + mi;
}

void setup() {
  size(1000, 800);
  frameRate(30);
  rectMode(CENTER);
  Tsetting();
  img = loadImage("image0.jpg");
  tit = loadImage("gpex.png");
  high = loadStrings("highscore.txt");
  time = loadStrings("time.txt");
  scope = new Scope();
  noSmooth();
}

void draw() {
  if (scene == 0) {
    title();
  } else if (scene == 1) {
    noCursor();
    image(img, bg_x, bg_y, width*1.5, height*1.5);
    fill(255);
    rect(0, 0, 200, 120);
    rect(width, 0, 80, 80);
    fill(255, 0, 0);
    textSize(48);
    text(score, 10, 50);  
    textSize(24);
    text(int(30-(m/30)), width-30, 30);
    if (set < 20) {
      m ++;
      int nullcount = 0;
      for (int i = 0 + (5*set); i < 5 + (5*set); i++) { 
        if (targets[i] != null) { 
          targets[i].display(i);
          targets[i].move(i);
          scope.display();
        } else {
          nullcount ++;
        }
      }
      if (nullcount == 5) {
        set ++;
      }
      if (m == 900) {
        scene ++;
      }
    } else {
      println("clear!");
      println("time;"+m);
      exit();
    }
  } else if (scene == 2) {
    result();
  } else if (scene == 3) {
    highscore();
  } else if (scene == 4) {
    howto();
  }
}

void mousePressed() { 
  if (scene == 0) {
    if (mouseX>=width/2-150&&mouseX<=width/2+150&&mouseY>=height/2-50&&mouseY<=height/2+50&&mousePressed) {
      scene ++;
    }
    if (mouseX>=width/2-150&&mouseX<=width/2+150&&mouseY>=height*3/4-50&&mouseY<=height*3/4+50&&mousePressed) {
      scene = 4;
    }
  }

  if (scene == 1) {
    for (int i = 0 + (5*set); i < 5 + (5*set); i++) { 
      if (targets[i] != null &&targets[i].isInside()) {
        targets[i] = null;
        score ++;
      }
    }
  }
}

void keyPressed() {
  for (int i = 0; i < targets.length; i++) {
    if (targets[i] != null) {
      if (key == 'a') {
        targets[i].x += 10;
      }      
      if (key == 'd') {
        targets[i].x -= 10;
      }
      if (key == 'w') {
        targets[i].y += 10;
      }
      if (key == 's') {
        targets[i].y -= 10;
      }
    }
  }
}

void mouseMoved() {
  if (scene == 1) {
    for (int i = 0; i < targets.length; i++) {
      if (targets[i] != null) {
        if (mx < mouseX) {
          targets[i].x -= 5.5;
          bg_x += 0.015;
        }
        if (mx > mouseX) {
          targets[i].x += 5.5;
          bg_x -= 0.015;
        }
        if (my < mouseY) {
          targets[i].y -= 5.5;
          bg_y += 0.015;
        }
        if (my > mouseY) {
          targets[i].y += 5.5;
          bg_y -= 0.015;
        }
      }
    }
    mx = mouseX;
    my = mouseY;
  }
}
