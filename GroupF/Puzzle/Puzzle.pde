import de.bezier.data.sql.*;
import java.util.*;
boolean flagNumbers = true;
boolean flagSwitch = true;
boolean flagMetro= false;
boolean flagRelease = false;
boolean flagDrawScore = false;

int MODE_PERFORMER = 0;
int MODE_MASTER = 1;
int MODE_VIDEO = 2;

int PLAY_MODE = MODE_VIDEO;
boolean flagMaster = false;

//**************************** initialization ****************************

void setup() {               // executed once at the begining 
  //size(900, 700, P3D);            // window size
  size(displayWidth, displayHeight, P3D);
  frameRate(30);             // render 30 frames per second
  smooth();  // turn on antialiasing
  initImageBox();
  if(PLAY_MODE != MODE_VIDEO){
    grid = new Grid(300,150,500);
  }else{
    grid = new Grid(displayWidth*0.28,displayHeight*0.15,displayHeight*0.8);
  }
  initDB();
  startTime = 0;
  currentMeasure = 10;
  startTime = millis();
}

// DRAW      
void draw() { 
  background(white);
  if(PLAY_MODE!= MODE_VIDEO){
    image(boxImage,imagex,imagey,imagewheight/2,imagewheight/2); 
  }
  //grid.drawGauge();
  grid.drawQuad();
  grid.drawMapping();
  if((flagNumbers)&&(PLAY_MODE!=MODE_VIDEO)){
    grid.drawNumbers();
  }
  grid.drawMovingSlides();
  //grid.drawCenters();
  updateGridFromDB();
  readConductorDB();
  //updateMetro();
  if(flagMaster){
    updateCounter();
  }
}

void mousePressed() {
  if(!flagSwitch){
    grid.pickClosest(Mouse());
  }else{
    grid.switchClosest(Mouse());
    
  }
  System.out.println("Mouse Pressed ...");
}

void mouseDragged() {
  if (!keyPressed || (key=='a')|| (key=='i')) grid.dragPicked();   // drag selected point with mouse
}

void mouseReleased() {
  grid.release();
}

void keyPressed() {
  if(key=='n') flagNumbers=!flagNumbers;
  if(key=='s') flagSwitch=!flagSwitch;
  //if(key=='c') {flagDrawScore=!flagDrawScore; initScoreImage();}
   
   if(key=='M') { 
     if(PLAY_MODE == MODE_MASTER){
       flagMaster=!flagMaster;
     }
   }
   
  //if(key=='m') {flagMetro=!flagMetro;currentMeasure=0;}
}
boolean sketchFullScreen() {
  if(PLAY_MODE==MODE_VIDEO){
    return true;
  }else{
    return false;
  }
}
