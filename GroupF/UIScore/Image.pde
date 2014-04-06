  float imagex;
  float imagey;
  float imagewidth;
  float imagewheight;
  PImage boxImage1,
         boxImage2,
         boxImage3; 
  PImage restImage; 
  
  void initImageBox(){
      boxImage1 = loadImage("MI5_TMPBbV3.png"); 
      imagex = .05*width;
      imagey = .05*height;
      imagewidth = boxImage1.width;
      imagewheight = boxImage1.height;
      System.out.println(boxImage1.width + ","+ boxImage1.height );
      
      boxImage2 = loadImage("MI5_SAXBbV3.png"); 
      imagex = .05*width;
      imagey = .05*height;
      imagewidth = boxImage2.width;
      imagewheight = boxImage2.height;
      System.out.println(boxImage2.width + ","+ boxImage2.height );
      
      boxImage3 = loadImage("MI5_EUPConcertV3.png"); 
      imagex = .05*width;
      imagey = .05*height;
      imagewidth = boxImage3.width;
      imagewheight = boxImage3.height;
      System.out.println(boxImage3.width + ","+ boxImage3.height );
      
      restImage = loadImage("RestV3.png"); 
  }
