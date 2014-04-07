import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


public class MainMySQLCopy {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		 try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection connect = null;
			String dbUrl = "jdbc:mysql://128.61.126.46:3306/psmatrix?user=ccortes&password=password";
		    connect = DriverManager
		              .getConnection(dbUrl);
		    Statement statement = connect.createStatement();
		    ResultSet rs = statement.executeQuery("SELECT * from matrix");
		    rs.beforeFirst();
		    while(rs.next()) {
		    	rs.getInt("row");
		    	System.out.println("row.."+rs.getInt("row"));
		    }
		    rs.close();
		    if(connect!=null){
		    	connect.close();
		    }
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			
		}
		 

	}

}
