Grid grid;

public class Grid{
  //Use a static quad , usa an additional layer to show the movement, flag to does not display that box
  int QUAD_SIZE = 10;//& ideal number
  pt[] centers;
  int[] mappings;
  boolean[] flagdraws;
  int[] midias;
  int[] midibs;
  float size;
  int pv = -1;
  pt movPoint;
  int movIndex;
  float delta;
  
  float startX,startY, sizeXY;
      float randomness =0.00;
  
  public Grid(float x, float y, float size){
    startX =x;
    startY = y;
    sizeXY = size;

    
    centers = new pt[QUAD_SIZE*QUAD_SIZE];
    mappings = new int[QUAD_SIZE*QUAD_SIZE];
    midias = new int[QUAD_SIZE*QUAD_SIZE];
    midibs = new int[QUAD_SIZE*QUAD_SIZE];
    
    
    movPoint = null;
     flagdraws = new boolean[QUAD_SIZE*QUAD_SIZE];
    this.size = size;
    delta = size/QUAD_SIZE;
    for(int row= 0;row<QUAD_SIZE;row++){
      for(int col= 0;col<QUAD_SIZE;col++){
        //centers[boxIndex(row, col)] = P(random(width), random(height));//P(x + (delta*col), y + (delta*row));  
        centers[boxIndex(row, col)] = P(x + (delta*col), y + (delta*row));  
        mappings[boxIndex(row, col)] = boxIndex(row, col);
        flagdraws[boxIndex(row, col)]=true;
      }
    }
    println("hi out..");
  }
  
  public int boxIndex(int row, int col){
    return row*QUAD_SIZE+col;
  }
  
  private int getCol(int index){
    return index % QUAD_SIZE;  
  }
  
  private int getRow(int index){
    return floor(index/QUAD_SIZE);  
  }
  
  public void drawCenters(){
    for(int i=0;i<QUAD_SIZE*QUAD_SIZE;i++){
      if(flagdraws[i]){
        showDisk(centers[i].x, centers[i].y, 5);
      }
    }
  }
  
  
  public void drawQuad(){
    pen(magenta, 2.0);
    float delta2 = size/(2*QUAD_SIZE);
    for(int row= 0;row<QUAD_SIZE;row++){
      edge( P(centers[boxIndex(row, 0)].x-delta2,centers[boxIndex(row, 0)].y- delta2) ,
              P(centers[boxIndex(row, 0)].x-delta2,centers[boxIndex(row, 0)].y+ delta2) );
      for(int col= 0;col<QUAD_SIZE;col++){
        edge( P(centers[boxIndex(row, col)].x-delta2,centers[boxIndex(row, col)].y- delta2) ,
              P(centers[boxIndex(row, col)].x+delta2,centers[boxIndex(row, col)].y- delta2) );
        edge( P(centers[boxIndex(row, col)].x+delta2,centers[boxIndex(row, col)].y- delta2) ,
              P(centers[boxIndex(row, col)].x+delta2,centers[boxIndex(row, col)].y+ delta2) );   
        if(row ==QUAD_SIZE-1 ){
             edge( P(centers[boxIndex(row, col)].x-delta2,centers[boxIndex(row, col)].y+ delta2) ,
              P(centers[boxIndex(row, col)].x+delta2,centers[boxIndex(row, col)].y+ delta2) );   
        }      
      }
    }  
  }
  

  
  
  
  public pt ptTopLeft(pt center){
    float delta2 = size/(2*QUAD_SIZE);
    return P(center.x-delta2,center.y- delta2);
  }
  
  public pt ptTopRight(pt center){
    float delta2 = size/(2*QUAD_SIZE);
    return P(center.x+delta2,center.y- delta2);
  }
  
 public pt ptBottomLeft(pt center){
    float delta2 = size/(2*QUAD_SIZE);
    return P(center.x-delta2,center.y+ delta2);
  }
  
  public pt ptBottomRight(pt center){
    float delta2 = size/(2*QUAD_SIZE);
    return P(center.x+delta2,center.y+ delta2);
  }
  
  private float mapTopLeftX(int row, int col){
    float in = 1./QUAD_SIZE;
    int index = mappings[boxIndex(row, col)];
    return getCol(index)*in;
  }
  
  private float mapTopLeftY(int row, int col){
    float in = 1./QUAD_SIZE;
    int index = mappings[boxIndex(row, col)];
    return getRow(index)*in;
  }
  
    private float mapTopRightX(int row, int col){
    float in = 1./QUAD_SIZE;
    int index = mappings[boxIndex(row, col)];
    return (getCol(index)+1)*in;
  }
  
  private float mapTopRightY(int row, int col){
    float in = 1./QUAD_SIZE;
    int index = mappings[boxIndex(row, col)];
    return getRow(index)*in;
  }
  
    private float mapBottomRightX(int row, int col){
    float in = 1./QUAD_SIZE;
    int index = mappings[boxIndex(row, col)];
    return (getCol(index)+1)*in;
  }
  
  private float mapBottomRightY(int row, int col){
    float in = 1./QUAD_SIZE;
    int index = mappings[boxIndex(row, col)];
    return (getRow(index)+1)*in;
  }
  
    private float mapBottomLeftX(int row, int col){
    float in = 1./QUAD_SIZE;
    int index = mappings[boxIndex(row, col)];
    return getCol(index)*in;
  }
  
  private float mapBottomLeftY(int row, int col){
    float in = 1./QUAD_SIZE;
    int index = mappings[boxIndex(row, col)];
    return (getRow(index)+1)*in;
  }
  
  public void drawMapping(){
     //pen(magenta, 1.0);
     noStroke();
     float in = 1./QUAD_SIZE;
     float delta2 = size/(2*QUAD_SIZE);
     textureMode(NORMAL);       // texture parameters in [0,1]x[0,1]
     
     //beginShape(QUADS); 
     //texture(boxImage);  

     for(int row= 0;row<QUAD_SIZE;row++) {

       for(int col= 0;col<QUAD_SIZE;col++) { 
         //mappings[boxIndex(row, col)] == boxIndex(row, col)
          beginShape(QUADS); 
         if(mappings[boxIndex(row, col)] == boxIndex(row, col)){
           texture(boxImage); 
         }else{
           texture(boxImageGray); 
         }  
        
         if( flagdraws[boxIndex(row, col)]  && (pv!=boxIndex(row, col)) ){  
           v(ptTopLeft(centers[boxIndex(row, col)]),mapTopLeftX(row,col),mapTopLeftY(row,col)); 
           v(ptTopRight(centers[boxIndex(row, col)]),mapTopRightX(row,col),mapTopRightY(row,col)); 
           v(ptBottomRight(centers[boxIndex(row, col)]), mapBottomRightX(row,col),mapBottomRightY(row,col));
           v(ptBottomLeft(centers[boxIndex(row, col)]), mapBottomLeftX(row,col),mapBottomLeftY(row,col));

         }
         
          endShape();
         
       };

     };
     
    //endShape();
     
     
            
       
  }
  
  public void drawNumbers(){
     //pen(magenta, 1.0);
     fill(yellow);
     textSize(12);

     for(int row= 0;row<QUAD_SIZE;row++) {

       for(int col= 0;col<QUAD_SIZE;col++) { 

         if( flagdraws[boxIndex(row, col)]  && (pv!=boxIndex(row, col)) ){  
           text(mappings[boxIndex(row, col)], centers[boxIndex(row, col)].x, centers[boxIndex(row, col)].y);
           //v(ptTopLeft(centers[boxIndex(row, col)]),mapTopLeftX(row,col),mapTopLeftY(row,col)); 
         }
         
       };

     };
           
       
  }
  
  public void drawGauge(){
    pen(red, 10.0);
    float lengthGauge = sizeXY*currentState();
    float endPoint = startX+sizeXY-delta/2;
    
    line( endPoint-lengthGauge, startY-50, endPoint, startY-50);
  }

  
  public void drawSelected(){
    if(pv >=0){
      showDisk(centers[pv].x, centers[pv].y, 10);
    }
  }
  
  public void dragPicked(){
    System.out.println("Dragged");
    if((movPoint!=null) && (pv>=0) ){
       int row = getRow(pv);
       int col = getCol(pv);
       boolean flagX = false;
       boolean flagY = false;
       if( (col<QUAD_SIZE-1) && !flagdraws[boxIndex(row, col+1)]){
         flagX = true;
       }
       if( (col>0) && !flagdraws[boxIndex(row, col-1)]){
         flagX = true;
       }
       
       if( (row<QUAD_SIZE-1) && !flagdraws[boxIndex(row+1, col)]){
         flagY = true;
       }
       if( (row>0) && !flagdraws[boxIndex(row-1, col)]){
         flagY = true;
       }
       
       //System.out.println("flags neighborhood XY"+flagX+" "+flagY);
       if(flagX){
         movPoint.moveWithMouseX();
       }  
       if(flagY){
         movPoint.moveWithMouseY();
       } 
       
       if(flagX&&flagY){
         movPoint.moveWithMouse();
       }
       
       if(!flagX && !flagY){
         pv = -1;
         movPoint = null;
       }
    }

  }
  
 public void drawMovingSlides(){
   if( (movPoint!=null)  && (pv >=0)){
     pen(yellow, 5.0);
     //showDisk(movPoint.x,movPoint.y, 10);
     textureMode(NORMAL);       // texture parameters in [0,1]x[0,1]     
     beginShape(QUADS); 
     texture(boxImage); 
     int row = getRow(pv);
     int col = getCol(pv);
     v(ptTopLeft(movPoint),mapTopLeftX(row,col),mapTopLeftY(row,col)); 
     v(ptTopRight(movPoint),mapTopRightX(row,col),mapTopRightY(row,col)); 
     v(ptBottomRight(movPoint), mapBottomRightX(row,col),mapBottomRightY(row,col));
     v(ptBottomLeft(movPoint), mapBottomLeftX(row,col),mapBottomLeftY(row,col));     
     endShape();
   }
     
  }
  
  public void updateCell(int row, int col, int sequence , int state){
      boolean flag = true;;
      
      if(state == 0){
        flag = false;
      }
      flagdraws[boxIndex(row, col)] = flag;
      mappings[boxIndex(row, col)] = sequence;

  }
  
  public void updateCellBase(int row, int col, int midia , int midib){

      midias[boxIndex(row, col)] = midia;
      midibs[boxIndex(row, col)] = midib;

  }
  
  public float currentState(){
     int count =0;
     for(int i= 0; i<QUAD_SIZE*QUAD_SIZE;i++){
         if( mappings[i] == i){
           count++;
         }
     } 
    randomness = count/(QUAD_SIZE*QUAD_SIZE);
     return count/(QUAD_SIZE*QUAD_SIZE);
  }
  
  public void resetFlagDraws(){
     for(int i= 0; i<QUAD_SIZE*QUAD_SIZE;i++){
       flagdraws[i]= true;
     } 
  }
  
  public void pickClosest(pt M) {
    pv=0; 
    for (int i=0; i<QUAD_SIZE*QUAD_SIZE; i++){
       if (d(M,centers[i])<d(M,centers[pv])) {
         pv=i;
       } 
    }
    if(d(M,centers[pv])<(1.2*delta)){
      if(flagdraws[pv]){
        movPoint = P(centers[pv]);
      }else{
         movPoint = null;
         pv = -1;
      }
    }else{
       movPoint = null;
       pv = -1;
    }
  }
  
  public void switchClosest(pt M) {
    int pos = findClosest(M);
    if(pos >=0){
      onState(pos);
    }
  }
  
  public int findClosest(pt point) {
    int pos =0;
    for (int i=0; i<QUAD_SIZE*QUAD_SIZE; i++){
       if (d(point,centers[i])<d(point,centers[pos])) {
         pos=i;
       } 
    }
    System.out.println("Distance"+d(point,centers[pos]));
    if(d(point,centers[pos])>(0.5*delta)){
        pos = -1;
    }
    
    return pos;
  }
  
  public void onState(int pos){
       System.out.println("*************CHANGE**************");
       int state =  (!flagdraws[pos]) ? 1 : 0;
       System.out.println("*************CHANGE**************" +state);
       String updatepos = "UPDATE matrix set state = "+state+
                                 " where row="+getRow(pos)+ " and col="+getCol(pos);  
       msql.execute( updatepos);  
       updateGridFromDB();                         
  }
  
    public void release(){
    if((pv>=0) && (movPoint!=null)){
      int pos = findClosest(movPoint);
      if( (pos>=0) && (pv!=pos) && !flagdraws[pos]){
        System.out.println("*************CHANGE**************");
        String querydatapv = "SELECT * FROM matrix where row="+getRow(pv)+ " and col="+getCol(pv);
        String querydatapos = "SELECT * FROM matrix where row="+getRow(pos)+ " and col="+getCol(pos);
        msql.query(querydatapv );
        msql.next();
        int statepv = msql.getInt("state");
        int midinoteapv = msql.getInt("midinotea"); 
        int midinotebpv = msql.getInt("midinoteb"); 
        int midilevelapv = msql.getInt("midilevela"); 
        int midilevelbpv = msql.getInt("midilevelb");  
        int sequencepv = msql.getInt("sequence"); 
        
        msql.query(querydatapos );
        msql.next();
        int statepos = msql.getInt("state");
        int midinoteapos = msql.getInt("midinotea"); 
        int midinotebpos = msql.getInt("midinoteb"); 
        int midilevelapos = msql.getInt("midilevela"); 
        int midilevelbpos = msql.getInt("midilevelb");  
        int sequencepos = msql.getInt("sequence"); 
        
        System.out.println("SEQUENCE SOURCE "+sequencepv+ " TARGET "+sequencepos);
        
        String updatepv = "UPDATE matrix set state ="+statepos+
                                           ",midinotea="+midias[sequencepos]+
                                           ",midinoteb="+midibs[sequencepos]+
                                           ",sequence="+sequencepos+
                                           " where row="+getRow(pv)+ " and col="+getCol(pv);
                                           
        
      String updatepos = "UPDATE matrix set state ="+statepv+
                                 ",midinotea="+midias[sequencepv]+
                                 ",midinoteb="+midibs[sequencepv]+
                                 ",sequence="+sequencepv+
                                 " where row="+getRow(pos)+ " and col="+getCol(pos);                                   
                                           
        msql.execute( updatepv);   
        msql.execute( updatepos);  
        updateGridFromDB();
      }
      
    }
    pv = -1;
    movPoint = null;
  }

  
  public void releaseOld(){
    if((pv>=0) && (movPoint!=null)){
      int pos = findClosest(movPoint);
      if( (pos>=0) && (pv!=pos) && !flagdraws[pos]){
        System.out.println("*************CHANGE**************");
        String querydatapv = "SELECT * FROM matrix where row="+getRow(pv)+ " and col="+getCol(pv);
        String querydatapos = "SELECT * FROM matrix where row="+getRow(pos)+ " and col="+getCol(pos);
        msql.query(querydatapv );
        msql.next();
        int statepv = msql.getInt("state");
        int midinoteapv = msql.getInt("midinotea"); 
        int midinotebpv = msql.getInt("midinoteb"); 
        int midilevelapv = msql.getInt("midilevela"); 
        int midilevelbpv = msql.getInt("midilevelb");  
        int sequencepv = msql.getInt("sequence"); 
        
        msql.query(querydatapos );
        msql.next();
        int statepos = msql.getInt("state");
        int midinoteapos = msql.getInt("midinotea"); 
        int midinotebpos = msql.getInt("midinoteb"); 
        int midilevelapos = msql.getInt("midilevela"); 
        int midilevelbpos = msql.getInt("midilevelb");  
        int sequencepos = msql.getInt("sequence"); 
        
        System.out.println("SEQUENCE SOURCE "+sequencepv+ " TARGET "+sequencepos);
        
        String updatepv = "UPDATE matrix set state ="+statepos+
                                           ",midinotea="+midinoteapos+
                                           ",midinoteb="+midinotebpos+
                                           ",midilevela="+midilevelapos+
                                           ",midilevelb="+midilevelbpos+
                                           ",sequence="+sequencepos+
                                           " where row="+getRow(pv)+ " and col="+getCol(pv);
                                           
        
      String updatepos = "UPDATE matrix set state ="+statepv+
                                 ",midinotea="+midinoteapv+
                                 ",midinoteb="+midinotebpv+
                                 ",midilevela="+midilevelapv+
                                 ",midilevelb="+midilevelbpv+
                                 ",sequence="+sequencepv+
                                 " where row="+getRow(pos)+ " and col="+getCol(pos);                                   
                                           
        msql.execute( updatepv);   
        msql.execute( updatepos);  
        updateGridFromDB();
      }
      
    }
    pv = -1;
    movPoint = null;
  }
  
  
}
