MySQL msql;

public void initDB(){
    // this example assumes that you are running the 
    // mysql server locally (on "localhost").
    //
  
    // replace --username--, --password-- with your mysql-account.
    //
    String user     = "psmatrix";
    String pass     = "password";
  
    // name of the database to use
    //
    String database = "psmatrix";
    // add additional parameters like this:
    // bildwelt?useUnicode=true&characterEncoding=UTF-8
  
    // connect to database of server "localhost"
    //
    msql = new MySQL( this, "192.168.0.113", database, user, pass );
    
    if ( msql.connect() )
    {
        msql.query( "SELECT * FROM matrix" );
        /*
        msql.next();
        println( "number of rows: " + msql.getInt(1) );*/
        while (msql.next())
        {
            int row = msql.getInt("row");
            int col = msql.getInt("col");
            int midia = msql.getInt("MIDINOTEA");
            int midib = msql.getInt("MIDINOTEB");
            grid.updateCellBase(row, col, midia , midib);
            //println(row + " ,  " + col);
        }
    }
    else
    {
        // connection failed !
        println( "mysql connection failed " );
    }
}

void updateGridFromDB(){
     try{
        grid.resetFlagDraws();
        msql.query( "SELECT * FROM matrix" );
        /*
        msql.next();
        println( "number of rows: " + msql.getInt(1) );*/
        while (msql.next())
        {
            int row = msql.getInt("ROW");
            int col = msql.getInt("COL");
            int state = msql.getInt("STATE");
            int seq = msql.getInt("SEQUENCE");
            grid.updateCell(row, col, seq , state);
            //println(row + " ,  " + col);
        }
      }catch (Exception e) {
            System.out.println("Caught Exception " + e.getMessage());
      }


}


void readConductorDB(){
     try{
        msql.query( "SELECT * FROM conductor" );
        msql.next();
        String msg = msql.getString("MESSAGE");
        if(msg.equalsIgnoreCase("enable")){
           flagRelease =true;
        }else if(msg.equalsIgnoreCase("disable")){
          flagRelease =false;
          //System.out.println("*****DISABLE*******");
        }else if(msg.equalsIgnoreCase("picscore")){
          if(PLAY_MODE==MODE_VIDEO){
            initScoreImage();
          }
        }else if(msg.equalsIgnoreCase("picpaint")){
          if(PLAY_MODE==MODE_VIDEO){
            initPaintImage();
          }
        }
      }catch (Exception e) {
            System.out.println("Caught Exception " + e.getMessage());
      }


}



