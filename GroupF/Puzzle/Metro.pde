long startTime;
float metroTime = 2*250;
int currentMeasure;
int countPicture = 0;
int MAX_COUNTER = 35;

public void updateMetro(){
    
    float delta= (millis()-startTime); 
    int measure = floor(delta/metroTime)%10;
     if(currentMeasure != measure){
         currentMeasure = measure;
         if((currentMeasure%5)==0 ){

          }
      }

}

public void updateCounter(){
    
    countPicture++;
    if(countPicture >= MAX_COUNTER){
         countPicture = 0;
         System.out.println("Automatic Solving...");
         grid.autoRandomFill();
    }
}
