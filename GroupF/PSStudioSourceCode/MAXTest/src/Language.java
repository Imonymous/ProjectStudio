
public class Language {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		String user="aaa";
		String pwd="ppp";
		String ip = "128.61.126.46";
		String dbUrl = "jdbc:mysql://"+ip+":3306/psmatrix?user="+ user+"&password="+pwd;
		System.out.println(dbUrl);
	}

}
