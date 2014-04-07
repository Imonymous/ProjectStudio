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
import com.cycling74.max.MaxObject;


public class psmysqlCopy extends MaxObject {
	private final String user;
	private final String pwd;
	private final int periodTime;
	private ScheduledExecutorService service;
	Connection connect = null;
	Statement statement = null;
	
	public psmysqlCopy(Atom[] args) {
		post("ps mysql v1.0 2014");
		if(args.length>1){
			user = args[0].getString();
			pwd = args[1].getString();
			periodTime = args[2].getInt();
			post("ps mysql user "+user);
		}else{
			user = "nouser";
			pwd = "nopwd";
			periodTime = 1000;
		}
		
	}
	
	public void start() {
		outlet(0, "ps mysql starting ...");
		service = Executors.newScheduledThreadPool(1);
		try {
			Class.forName("com.mysql.jdbc.Driver");

			String dbUrl = "jdbc:mysql://128.61.126.46:3306/psmatrix?user="+ user+"&password="+pwd;
			connect = DriverManager
			          .getConnection(dbUrl);
			statement = connect.createStatement();
			
			service.scheduleAtFixedRate(new QueryRunnable(statement), 1, periodTime, TimeUnit.MILLISECONDS);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			post("psmysql ClassNotFoundException ");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			post("psmysql SQLException " + e.getLocalizedMessage());
		}
	}
	
	public void stop() {
		outlet(0, "ps mysql ending ...");
		service.shutdown();
		try {
			if(statement!= null){
				statement.close();
			}
			if(connect!=null){
				connect.close();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

    private class QueryRunnable implements Runnable {
    	private final Statement stm;
    	
    	
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
				if(data.size()>0){
					for(int i=0;i<data.size();i++){
						Thread.sleep(2);
						outlet(1, data.get(i));
					}
					//outlet(1, values);
				}
				post("ps mysql read done...");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				post("ps mysql SQLException ...");
			}  catch (Exception e) {
				// TODO Auto-generated catch block
				post("ps mysql Exception ..."+ e.getLocalizedMessage());
			} 
        	outlet(0, 74);
        }
    };

}
