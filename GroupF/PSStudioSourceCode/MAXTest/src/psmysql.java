import java.io.PrintWriter;
import java.io.StringWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import com.cycling74.max.Atom;
import com.cycling74.max.DataTypes;
import com.cycling74.max.MaxObject;


public class psmysql extends MaxObject {
	private final String user;
	private final String pwd;
	private final String host;
	private final String type;
	private final int periodTime;
	volatile ArrayList<int[]> dataMatrix = new ArrayList<int[]>();
	volatile int[] Changes = new int[100];
	volatile int countMatch;
	private ScheduledExecutorService service;
	Connection connect = null;
	Statement statement = null;
	Statement updateStatement = null;
	
	public static String getStackTrace(final Throwable throwable) {
	     final StringWriter sw = new StringWriter();
	     final PrintWriter pw = new PrintWriter(sw, true);
	     throwable.printStackTrace(pw);
	     return sw.getBuffer().toString();
	}
	
	public psmysql(Atom[] args) {
		post("ps mysql v1.1 2014");

		declareOutlets(new int[]{DataTypes.ALL, DataTypes.ALL , DataTypes.ALL ,DataTypes.ALL});
		if(args.length>1){
			user = args[0].getString();
			pwd = args[1].getString();
			periodTime = args[2].getInt();
			host = args[3].getString();
			type = args[4].getString();
			post("ps mysql user  "+user +" to host "+ host + " "+ type);
		}else{
			user = "nouser";
			pwd = "nopwd";
			host = "localhost";
			type = "solo";
			periodTime = 1000;
		}
		dataMatrix.clear();
		for(int i=0;i<100;i++){
			dataMatrix.add(new int[12]);
		}
		countMatch =0;
		
	}
	
	public void start() {
		outlet(0, "ps mysql starting ...");


		Thread thread = new Thread(){
		    public void run(){
				service = Executors.newScheduledThreadPool(1);
				try {
					Class.forName("com.mysql.jdbc.Driver");

					//String dbUrl = "jdbc:mysql://"+host+":3306/psmatrix?user="+ user+"&password="+pwd;
					//String dbUrl = dbbase.replaceAll("PPHOST", host);
					String dbUrl = "jdbc:mysql://" + host+":3306/psmatrix";
					//"jdbc:mysql://128.61.126.46:3306/psmatrix"
					connect = DriverManager
					          .getConnection(dbUrl, user, pwd);
					statement = connect.createStatement();
					updateStatement = connect.createStatement();
					
					service.scheduleAtFixedRate(new QueryRunnable(statement), 1, periodTime, TimeUnit.MILLISECONDS);
				} catch (ClassNotFoundException e) {
					// TODO Auto-generated catch block
					post("psmysql ClassNotFoundException ");
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					post("psmysql SQLException " + e.getLocalizedMessage());
				} catch (Exception e) {
					// TODO Auto-generated catch block
					post("psmysql Exception " + e.getLocalizedMessage());
				}
		    }
		  };
		 
		  thread.start();
		

	}
	
	public void stop() {
		outlet(0, "ps 1 mysql ending ...");
		service.shutdown();
		try {
			if(statement!= null){
				statement.close();
			}
			if(updateStatement!= null){
				updateStatement.close();
			}
			if(connect!=null){
				connect.close();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void size(){
		outlet(0, dataMatrix.size());
	}
	
	public int[] getRandomColumns(int col){
		int[] rows = new int[3];
		double randomness = (100.00- countMatch)/100.00;
		ArrayList<Integer> avails = new ArrayList<Integer>();
		for(int i =0;i<9;i++){
			int index = col+ (i*10);
			int[] values = dataMatrix.get(index);
			if(values[2]==1){
				avails.add(Integer.valueOf(index));
			}			
		}
		
		if(avails.size()>0){
			for(int i=0;i<3;i++){
				int temp = (int) ( (i*3.0) + (Math.round(randomness*Math.random()*9.0)));
				temp = temp%avails.size();
				rows[i] = avails.get(temp);
				post("col randomness index.."+ temp+" col "+ col + " with row "+ rows[i]);
			}
			return rows;
		}
		
		return null;
		
	}
	
	public void anything(String s, Atom[] args) {
		//post("hello anything |" + s + "| " + Atom.toOneString(args) + "!");
		if(s.equalsIgnoreCase("cellvalue")){
			//int index = (args[0].getInt()*10) + args[1].getInt(); 
			//post("index .."+ index);
			int col =args[0].getInt();
			int[] indexes =getRandomColumns(col);			
			if( indexes!=null){
				outlet(1, dataMatrix.get(indexes[0]));
				outlet(2, dataMatrix.get(indexes[1]));
				outlet(3, dataMatrix.get(indexes[2]));				
			}
			if(type.equalsIgnoreCase("master")){
			outlet(4, dataMatrix.get((9*10) + col));
				try {
					updateStatement.executeUpdate("update conductor set current="+col);
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					post("update exception ..");
				}
			}
			
		}else if(s.equalsIgnoreCase("cellmatrix")){
			int index = (args[0].getInt()*10) + args[1].getInt(); 
			if((index >=0)&&(index<dataMatrix.size()) ){
				outlet(1, dataMatrix.get(index));
			}
		}
	}

    private class QueryRunnable implements Runnable {
    	private final Statement stm;
    	
    	public void matrixChange(ArrayList<int[]> data){
    		java.util.Arrays.fill(Changes,0);
    		int[] list ={0,0,0};
    		int count =0;
    		for(int i=0;i<data.size();i++){
    			/*
    			if(data.get(i)[2]!= dataMatrix.get(i)[2]){
    				//Changes[i]=1;
    				list[0]= i/10;
    				list[1]=i%10;
    				list[2]=data.get(i)[2];
    				outlet(4, list);
    			}*/
    			if(data.get(i)[7] == i){
    				count++;
    			}
    		}
    		countMatch =count;
    	}
    	
		public QueryRunnable(Statement stm) {
			super();
			this.stm = stm;
		}


		public void run() { 
        	post("ps mysql query ..."); 
		    try {
				ResultSet rs = stm.executeQuery("SELECT * from matrix");
				ResultSetMetaData rsmd = rs.getMetaData();
				int columnNumber = rsmd.getColumnCount();
				ArrayList<int[]> data = new ArrayList<int[]>();

				
				
				rs.beforeFirst();
				
				while(rs.next()) {
					int[] value = new int[columnNumber];
					for(int k=1;k<=columnNumber;k++){
					   value[k-1] =  rs.getInt(k);
					}
					data.add(value);
				}
				rs.close();
				/*
				if(data.size()>0){
					for(int i=0;i<data.size();i++){
						Thread.sleep(2);
						outlet(1, data.get(i));
					}
					//outlet(1, values);
				}*/

				matrixChange(data);
				dataMatrix = data;
				post("ps mysql read done...");
				outlet(0, "DB loop ...");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				post("ps mysql SQLException ...");
			}  catch (Exception e) {
				// TODO Auto-generated catch block
				post("ps mysql Exception ..."+ getStackTrace(e));
			} 
        	//outlet(0, 74);
        }
    };

}
