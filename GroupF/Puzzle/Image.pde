  float imagex;
  float imagey;
  float imagewidth;
  float imagewheight;
  PImage boxImage;  
  PImage boxImageGray;
  PImage scoreImage;  
  PImage scoreImageGray;
  
  PImage paintImage;  
  PImage paintImageGray;
  
  void initImageBox(){
      paintImage = loadImage("pic6.jpg"); 
      paintImageGray = loadImage("pic6.jpg");
      paintImageGray.filter(GRAY);
      
      boxImage =paintImage;
      boxImageGray = paintImageGray;
      
      imagex = .05*width;
      imagey = .05*height;
      imagewidth = boxImage.width/2.0;
      imagewheight = boxImage.height/2.0;
      System.out.println(boxImage.width + ","+ boxImage.height );
      
      scoreImage = loadImage("score.png"); 
      scoreImageGray = loadImage("score.png");
  }
  
  void initScoreImage(){
      boxImage = scoreImage;
      boxImageGray =scoreImageGray;
      imagewidth = scoreImage.width/2.0;
      imagewheight = scoreImage.height/2.0;
      System.out.println(scoreImage.width + ","+ scoreImage.height );
  }
  
  void initPaintImage(){
      boxImage = paintImage;
      boxImageGray =paintImageGray;
      imagewidth = paintImage.width/2.0;
      imagewheight = paintImage.height/2.0;
      System.out.println(paintImage.width + ","+ paintImage.height );
  }
