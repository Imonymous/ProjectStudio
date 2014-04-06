import de.bezier.data.sql.*;

MySQL mysql;
public void initDB(){
  String user   = "psmatrix";
  String pass   = "password";
  //String user     = "root";
  //String pass     = "shuo";
  
  String database = "psmatrix";
  //mysql = new MySQL(this, "10.0.1.20", database, user, pass);
  //mysql = new MySQL(this, "localhost", database, user, pass);
  mysql = new MySQL(this, "192.168.0.113", database, user, pass);
  
  if (mysql.connect())
  {
   mysql.query("SELECT * FROM matrix");
    while(mysql.next())
     {
       int row = mysql.getInt("row");
       int col = mysql.getInt("col");
       println(row + ",  " + col);
     } 
  }
}

void updateGridFromDB(){
//    if (mysql.connect())
//  
  try{
   staff.initCounters();
   mysql.query("SELECT * FROM matrix");
    while(mysql.next())
     {
       int row = mysql.getInt("row");
       int col = mysql.getInt("col");
       int sequence = mysql.getInt("sequence");
       int state = mysql.getInt("state");
       println(row + ",  " + col + ", " + sequence + ", " + state);
       staff.setFlag(row,col,sequence, state);
     } 
    
    mysql.query("SELECT * FROM conductor");
    while(mysql.next())
    {
      int current = mysql.getInt("current");
      println(current);
      staff.setCurrent(current);
    }
     
     staff.updateStaff();
  } catch (Exception e){
  System.out.println("catch execption");
  }
  //}
}
