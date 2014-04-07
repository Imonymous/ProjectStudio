Staff staff;

public class Staff
{
  float posX = 100;
  float[] xpoints = {-50,20,110,210,310,410,510,603,703,803,900,1020};
  float[] xpoints2 = {-50,20,120,220,320,430,520,620,720,820,910,1020};
  float[] barpos = {170,320,420,520,670,820,920};
  float[] mapxvalues = {0.0,0.04,0.125,0.21,0.295,0.38,0.475,0.585,0.685,0.785,0.885,1.0};
  //float[] bclefvalues = {0.0,0.04,0.125,0.21,0.30,0.40,0.50,0.585,0.685,0.785,0.885,1.0};
  float yheigth = 200;
  boolean[] flags1 = {true,false,false,false,false,false,false,false,false,false,false};
  boolean[] flags2 = {true,false,false,false,false,false,false,false,false,false,false};
  boolean[] flags3 = {true,false,false,false,false,false,false,false,false,false,false};

  int[] count1;
  int[] count2;
  int[] count3;
  int curr = 0;
  
  float deltaXTime =0;
  
  public void initCounters()
  {
    count1 = new int[10];
    count2 = new int[10];
    count3 = new int[10];
  }
  
  public void updateStaff()
  {
    for(int i=0;i<10;i++)
    {
      if(count1[i]==3)
      {
        flags1[i+1] =true;
      }
      else
      {
         flags1[i+1] =false;
      }
      
      if(count2[i]==3)
      {
        flags2[i+1] =true;
      }
      else
      {
         flags2[i+1] =false;
      }
      
      if(count3[i]==3)
      {
        flags3[i+1] =true;
      }
      else
      {
         flags3[i+1] =false;
      }
    }
  }
  
  public void setFlag(int row, int col ,int sequence, int state)
  {
    
    if(row==0||row==1||row==2)
    {
      if ((row * 10 + col) == sequence )
      {
        count1[col] = count1[col]+state;
      }
    }  
    if(row==3||row==4||row==5)
    {
      if ((row * 10 + col) == sequence )
      {
        count2[col] = count2[col]+state;
      }
    }  
    if(row==6||row==7||row==8)
    {
      if ((row * 10 + col) == sequence )
      {
        count3[col] = count3[col]+state;
      }
    }
  }
  public void setCurrent(int current)
  {
    if(curr!=current){
      deltaXTime = 30;
    }else{
      deltaXTime = deltaXTime+7.00;
    }
    curr = current;
    
  }
  
  public void drawMapping()
  {
    fill(blue);
    textSize(32);
    text("Sax", posX+xpoints[0], 50); 
    textSize(32);
    text("Tmp", posX+xpoints[0], 300); 
        textSize(32);
    text("Eup", posX+xpoints[0], 550); 
    
    noStroke();
    textureMode(NORMAL);       // texture parameters in [0,1]x[0,1] 
    noStroke();
    beginShape(QUADS); 
       texture(boxImage1); 
       vertex(posX+xpoints[0], 50, mapxvalues[0], 0);
       vertex(posX+xpoints[1], 50,mapxvalues[1], 0);
       vertex(posX+xpoints[1], 250, mapxvalues[1], 1);
       vertex(posX+xpoints[0], 250, mapxvalues[0],1);
    endShape();
    beginShape(QUADS); 
       texture(boxImage2); 
       vertex(posX+xpoints[0], 300, mapxvalues[0], 0);
       vertex(posX+xpoints[1], 300,mapxvalues[1], 0);
       vertex(posX+xpoints[1], 500, mapxvalues[1], 1);
       vertex(posX+xpoints[0], 500, mapxvalues[0],1);
    endShape();
    beginShape(QUADS); 
       texture(boxImage3); 
       vertex(posX+xpoints[0], 550, mapxvalues[0], 0);
       vertex(posX+xpoints[1], 550,mapxvalues[1], 0);
       vertex(posX+xpoints[1], 750, mapxvalues[1], 1);
       vertex(posX+xpoints[0], 750, mapxvalues[0],1);
    endShape();
    
    //add bar-line
      strokeWeight(1.5);
   for (int i = 0; i < barpos.length; i++)
   {
      strokeWeight(3.0);
      beginShape(LINES);
        stroke(0,0,0);
        vertex(posX+barpos[i],117);
        vertex(posX+barpos[i],209);
      endShape();
      beginShape(LINES);
        stroke(0,0,0);
        vertex(posX+barpos[i],367);
        vertex(posX+barpos[i],458);
      endShape();
    beginShape(LINES);
        stroke(0,0,0);
        vertex(posX+barpos[i],617);
        vertex(posX+barpos[i],708);
      endShape();
   }
    //indicate the speed of each bar for the musicians;
      
      strokeWeight(2.0);
        strokeCap(ROUND);
        stroke(0,0,255);
 
      beginShape(LINES);
        vertex(posX+xpoints[curr+1]+deltaXTime, 70, mapxvalues[curr+1], 0);
        vertex(posX+xpoints[curr+1]+deltaXTime, 220, mapxvalues[curr+1],1);
      endShape();
      
       beginShape(LINES);
        strokeCap(ROUND);
        stroke(204,0,0);
        vertex(posX+xpoints[curr+1]+deltaXTime, 320, mapxvalues[curr+1], 0);
        vertex(posX+xpoints[curr+1]+deltaXTime, 470, mapxvalues[curr+1],1);
      endShape();
      
       beginShape(LINES);
        strokeCap(ROUND);
        stroke(127,0,255);
        vertex(posX+xpoints[curr+1]+deltaXTime, 570, mapxvalues[curr+1], 0);
        vertex(posX+xpoints[curr+1]+deltaXTime, 720, mapxvalues[curr+1],1);
      endShape();
      
      //the first staff for musician 1
    
    
    for(int i=1;i<xpoints.length-1;i++)
    {
      strokeWeight(3.0);
      strokeCap(ROUND);
      
       beginShape(QUADS); 
       if(flags1[i]){
         //stroke(255,0,0);
         noStroke();
         texture(boxImage1); 
         vertex(posX+xpoints[i], 50, mapxvalues[i], 0);
         vertex(posX+xpoints[i+1], 50,mapxvalues[i+1], 0);
         vertex(posX+xpoints[i+1], 250, mapxvalues[i+1], 1);
         vertex(posX+xpoints[i], 250, mapxvalues[i],1);
       }else{
         noStroke();
         texture(restImage);
         vertex(posX+xpoints[i], 50, 0, 0);
         vertex(posX+xpoints[i+1], 50,1, 0);
         vertex(posX+xpoints[i+1], 250, 1, 1);
         vertex(posX+xpoints[i], 250, 0,1);
       }
       endShape();
       
       //the second staff for musician 2
       beginShape(QUADS); 
       if(flags2[i]){
         //stroke(255,0,0);
         noStroke();
         texture(boxImage2); 
         vertex(posX+xpoints[i], 300, mapxvalues[i], 0);
         vertex(posX+xpoints[i+1], 300,mapxvalues[i+1], 0);
         vertex(posX+xpoints[i+1], 500, mapxvalues[i+1], 1);
         vertex(posX+xpoints[i], 500, mapxvalues[i],1);
       }else{
         noStroke();
         texture(restImage);
         vertex(posX+xpoints[i], 300, 0, 0);
         vertex(posX+xpoints[i+1], 300,1, 0);
         vertex(posX+xpoints[i+1], 500, 1, 1);
         vertex(posX+xpoints[i], 500, 0,1);
       }
       endShape();
       
       //the third staff for musician 3
       beginShape(QUADS); 
       if(flags3[i]){
         //stroke(255,0,0);
         noStroke();
         texture(boxImage3); 
         vertex(posX+xpoints2[i], 550, mapxvalues[i], 0);
         vertex(posX+xpoints2[i+1], 550,mapxvalues[i+1], 0);
         vertex(posX+xpoints2[i+1], 750, mapxvalues[i+1], 1);
         vertex(posX+xpoints2[i], 750, mapxvalues[i],1);
       }else{
         noStroke();
         texture(restImage);
         vertex(posX+xpoints2[i], 550, 0, 0);
         vertex(posX+xpoints2[i+1], 550,1, 0);
         vertex(posX+xpoints2[i+1], 750, 1, 1);
         vertex(posX+xpoints2[i], 750, 0,1);
       }
       endShape();
    }
    
  }
}
