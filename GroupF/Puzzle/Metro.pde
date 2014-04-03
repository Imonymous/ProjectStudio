long startTime;
float metroTime = 2*300;
int currentMeasure;
public void updateMetro(){
  if(!flagMetro){
    startTime = millis();
  }else{
  
  float delta= (millis()-startTime); 
  int measure = floor(delta/metroTime)%10;

   if(currentMeasure != measure){
     currentMeasure = measure;
     updateMeasureDB(measure);
   }

    System.out.println(measure);
  }
}
