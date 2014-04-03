//**************************** initialization ****************************
//height
//width
import hypermedia.net.*;

//UDP udp;  // define the UDP object

void setup() {               // executed once at the begining 
  size(1200, 800, P3D);            // window size
  frameRate(30);             // render 30 frames per second
  smooth();  // turn on antialiasing
  initImageBox();
  staff = new Staff();
  initDB();
//  udp = new UDP( this, 9091 );
  //udp.log( true );     // <-- printout the connection activity
//  udp.listen( true );
}

// DRAW      
void draw() { 
  background(white);
  staff.drawMapping();
  //image(boxImage,imagex,imagey,imagewidth,imagewheight); 
  updateGridFromDB();
  staff.updateStaff();
}

//void receive( byte[] data, String ip, int port ) {  // <-- extended handler
//  
//  
//  // get the "real" message =
//  // forget the ";\n" at the end <-- !!! only for a communication with Pd !!!
//  //data = subset(data, 0, data.length-2);
//  //String message = new String( data );
//  
//  // print the result
//  staff.setCurrent(data[data.length-1]);
//  
//  println( "receive: \""+data[data.length-1]+"\" from "+ip+" on port "+port );
//}


