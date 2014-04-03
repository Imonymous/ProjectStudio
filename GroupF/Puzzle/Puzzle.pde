import de.bezier.data.sql.*;
import hypermedia.net.*;

boolean flagNumbers = true;
boolean flagSwitch = true;
boolean flagMetro= false;
UDP udp; 

//**************************** initialization ****************************
//height
//width
void setup() {               // executed once at the begining 
  size(900, 700, P3D);            // window size
  frameRate(30);             // render 30 frames per second
  smooth();  // turn on antialiasing
  initImageBox();
  grid = new Grid(300,150,500);
  initDB();
  // create a new datagram connection on port 6000
  // and wait for incomming message
  udp = new UDP( this, 9091 );
  //udp.log( true );     // <-- printout the connection activity
  udp.listen( true );
  startTime = 0;
  currentMeasure = 10;
}

// DRAW      
void draw() { 
  background(white);
  image(boxImage,imagex,imagey,imagewheight/2,imagewheight/2); 
  grid.drawQuad();
  grid.drawMapping();
  if(flagNumbers){
    grid.drawNumbers();
  }
  grid.drawMovingSlides();
  //grid.drawCenters();
  updateGridFromDB();
  updateMetro();
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
  if(key=='m') {flagMetro=!flagMetro;currentMeasure=0;}
}

/**
 * To perform any action on datagram reception, you need to implement this 
 * handler in your code. This method will be automatically called by the UDP 
 * object each time he receive a nonnull message.
 * By default, this method have just one argument (the received message as 
 * byte[] array), but in addition, two arguments (representing in order the 
 * sender IP address and his port) can be set like below.
 */
// void receive( byte[] data ) {       // <-- default handler
void receive( byte[] data, String ip, int port ) {  // <-- extended handler
  
  
  // get the "real" message =
  // forget the ";\n" at the end <-- !!! only for a communication with Pd !!!
  //data = subset(data, 0, data.length-2);
  //String message = new String( data );
  
  // print the result
  //println( "receive: \""+message+"\" from "+ip+" on port "+port );
  /*
  for(int i=0;i<data.length;i++){
    println("data "+data[i]);
  }*/
  //println("******************************");
  //println( "receive from "+"length"+ data.length +" "+ip+" on port "+port + " data "+data[0] + " data "+data[1]);
  if(data != null){
    //updateMeasureDB((int)data[data.length-1]);
    //flagMetro = true;
    //System.out.println("Starting Metro ...");
  }
}
