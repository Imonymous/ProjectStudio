  float imagex;
  float imagey;
  float imagewidth;
  float imagewheight;
  PImage boxImage;  
  PImage boxImageGray;
  
  void initImageBox(){
      boxImage = loadImage("pic4.jpg"); 
      boxImageGray = loadImage("pic4.jpg");
      boxImageGray.filter(GRAY);
      imagex = .05*width;
      imagey = .05*height;
      imagewidth = boxImage.width/2.0;
      imagewheight = boxImage.height/2.0;
      System.out.println(boxImage.width + ","+ boxImage.height );
  }
